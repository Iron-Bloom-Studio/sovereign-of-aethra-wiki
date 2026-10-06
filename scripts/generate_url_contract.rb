#!/usr/bin/env ruby

require "pathname"
require "set"
require "yaml"

ROOT = Pathname.new(File.expand_path("..", __dir__))
OUTPUT = ROOT.join("docs/generated/PUBLIC_URL_CONTRACT.md")

def front_matter(path)
  text = path.read
  return {} unless text.start_with?("---\n")

  YAML.safe_load(text.split(/^---\s*$\n?/, 3)[1], permitted_classes: [], aliases: true) || {}
end

def page_files
  files = [ROOT.join("index.md"), ROOT.join("404.html"), ROOT.join("search/index.md")]
  files.concat(ROOT.glob("wiki/**/*.md"))
  files.select(&:file?).sort
end

def route_for(path, data)
  return data["permalink"] if data["permalink"]

  relative = path.relative_path_from(ROOT).to_s
  return "/" if relative == "index.md"
  return "/404.html" if relative == "404.html"

  stem = relative.sub(/\.md\z/, "")
  stem.end_with?("/index") ? "/#{stem.sub(%r{/index\z}, "")}/" : "/#{stem}/"
end

def slugify(text)
  text.gsub(/<[^>]+>/, "").gsub(/[`*_~]/, "").downcase
      .gsub(/[^\p{L}\p{N}\s-]/, "").strip.gsub(/\s+/, "-").gsub(/-+/, "-")
end

def anchors_for(path)
  anchors = []
  counts = Hash.new(0)
  path.read.each_line do |line|
    if (match = line.match(/^\s{0,3}\#{1,6}\s+(.+?)\s*#*\s*$/))
      base = slugify(match[1])
      unless base.empty?
        count = counts[base]
        anchors << (count.zero? ? base : "#{base}-#{count}")
        counts[base] += 1
      end
    end
    line.scan(/\bid=["']([^"']+)["']/).flatten.each { |id| anchors << id }
  end
  anchors.uniq
end

def infer_type(path, data)
  return data["content_type"] if data["content_type"]

  relative = path.relative_path_from(ROOT).to_s
  layout = data["layout"]
  return "error page" if relative == "404.html"
  return "homepage" if relative == "index.md"
  return "search utility" if relative == "search/index.md"
  return "category portal" if relative.start_with?("wiki/categories/")
  return "novel portal/manuscript" if relative.start_with?("wiki/novel/")
  return "portal" if relative.end_with?("/index.md")
  return layout if %w[character event evolution faction location race realm].include?(layout)
  return "meta" if relative == "wiki/about.md"
  return "gallery" if relative == "wiki/artwork.md"
  return "system" if relative.start_with?("wiki/systems/")
  return "world lore" if relative.start_with?("wiki/world/")

  data["category"] || "article"
end

pages = page_files
records = pages.map do |path|
  data = front_matter(path)
  {
    source: path.relative_path_from(ROOT).to_s,
    url: route_for(path, data),
    type: infer_type(path, data),
    anchors: anchors_for(path)
  }
end

all_text = pages.to_h { |path| [path.relative_path_from(ROOT).to_s, path.read] }
records.each do |record|
  token = record[:url]
  record[:references] = all_text.count do |source, text|
    source != record[:source] && text.include?(token)
  end

  record[:referenced_anchors] = record[:anchors].select do |anchor|
    needle = "#{record[:url]}##{anchor}"
    all_text.any? { |source, text| source != record[:source] && text.include?(needle) }
  end
end

protected = [
  ["Free City of Arklune", "/wiki/locations/arklune/#the-grand-adventurer-guild", "wiki/locations/arklune.md", "Grand Adventurer Guild"],
  ["The Hive", "/wiki/factions/the-hive/#the-rogue-hive", "wiki/factions/the-hive.md", "Rogue Hive / Zavor"],
  ["The Hive", "/wiki/factions/the-hive/#zyrath-hive", "wiki/factions/the-hive.md", "Zyrath Hive"],
  ["Characters", "/wiki/characters/#founding-five", "wiki/characters/index.md", "Founding Five"],
  ["Characters", "/wiki/characters/#beta-war", "wiki/characters/index.md", "Beta War"]
]

lines = []
lines << "# Public URL Contract"
lines << ""
lines << "> **Existing public URLs are contracts.** Refactors must preserve every URL and protected anchor listed here unless an explicit migration and redirect plan is approved."
lines << ""
lines << "This inventory is generated from the current Jekyll source. Documentation files without public page front matter and repository-only scripts/data are excluded."
lines << ""
lines << "## Summary"
lines << ""
lines << "- Public page URLs: **#{records.length}**"
lines << "- Protected anchor destinations: **#{protected.length}**"
lines << "- Permalink mode: `pretty`"
lines << "- Production base URL: `/sovereign-of-aethra-wiki`"
lines << ""
lines << "## Protected Anchors"
lines << ""
lines << "| Parent | Contract URL | Source | Public destination |"
lines << "|---|---|---|---|"
protected.each do |parent, url, source, destination|
  lines << "| #{parent} | `#{url}` | `#{source}` | #{destination} |"
end
lines << ""
lines << "Do not rename the headings that generate these anchors until an explicit redirect or compatibility mechanism exists."
lines << ""
lines << "## URL Inventory"
lines << ""
lines << "| Source file | Current URL | Content type | Referenced anchors | Referenced elsewhere? |"
lines << "|---|---|---|---|---|"
records.each do |record|
  anchors = record[:referenced_anchors].empty? ? "—" : record[:referenced_anchors].map { |anchor| "`##{anchor}`" }.join(", ")
  referenced = record[:references].positive? ? "Yes (#{record[:references]} files)" : "No detected references"
  lines << "| `#{record[:source]}` | `#{record[:url]}` | #{record[:type]} | #{anchors} | #{referenced} |"
end
lines << ""
lines << "## Maintenance"
lines << ""
lines << "Regenerate this file after adding an approved public page or intentionally changing a URL contract:"
lines << ""
lines << "```sh"
lines << "ruby scripts/generate_url_contract.rb"
lines << "```"
lines << ""
lines << "Then run `ruby scripts/validate_site.rb` before committing."

OUTPUT.dirname.mkpath
OUTPUT.write(lines.join("\n") + "\n")
puts "Wrote #{OUTPUT.relative_path_from(ROOT)} with #{records.length} URLs"
