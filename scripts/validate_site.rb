#!/usr/bin/env ruby

require "json"
require "pathname"
require "set"
require "yaml"

ROOT = Pathname.new(File.expand_path("..", __dir__))
BASEURL = "/sovereign-of-aethra-wiki"

def front_matter(path)
  text = path.read
  return {} unless text.start_with?("---\n")

  body = text.split(/^---\s*$\n?/, 3)
  YAML.safe_load(body[1], permitted_classes: [], aliases: true) || {}
rescue Psych::SyntaxError => error
  raise "Invalid front matter in #{path.relative_path_from(ROOT)}: #{error.message}"
end

def page_files
  candidates = [ROOT.join("index.md"), ROOT.join("404.html"), ROOT.join("search/index.md")]
  candidates.concat(ROOT.glob("wiki/**/*.md"))
  candidates.select(&:file?).sort
end

def route_for(path, data = front_matter(path))
  permalink = data["permalink"]
  return permalink if permalink

  relative = path.relative_path_from(ROOT).to_s
  return "/" if relative == "index.md"
  return "/404.html" if relative == "404.html"

  without_extension = relative.sub(/\.md\z/, "")
  if without_extension.end_with?("/index")
    "/#{without_extension.sub(%r{/index\z}, "")}/"
  else
    "/#{without_extension}/"
  end
end

def slugify_heading(text)
  slug = text.gsub(/<[^>]+>/, "")
  slug = slug.gsub(/[`*_~]/, "")
  slug = slug.downcase
  slug = slug.gsub(/[^\p{L}\p{N}\s-]/, "")
  slug.strip.gsub(/\s+/, "-").gsub(/-+/, "-")
end

def anchors_for(path)
  anchors = Set.new
  counts = Hash.new(0)
  path.read.each_line do |line|
    if (match = line.match(/^\s{0,3}\#{1,6}\s+(.+?)\s*#*\s*$/))
      base = slugify_heading(match[1])
      next if base.empty?

      count = counts[base]
      anchors << (count.zero? ? base : "#{base}-#{count}")
      counts[base] += 1
    end
    line.scan(/\bid=["']([^"']+)["']/).flatten.each { |id| anchors << id }
  end
  anchors
end

def internal_references(path)
  text = path.read
  references = []
  text.scan(/\{\{\s*["'](\/[^"']+)["']\s*\|\s*relative_url\s*\}\}/).flatten.each do |target|
    references << target
  end
  text.scan(/(?:href|src)=["'](\/[^"']+)["']/).flatten.each do |target|
    references << target
  end
  text.scan(/\]\((\/[^)\s]+)\)/).flatten.each do |target|
    references << target
  end
  references.uniq
end

def normalize_target(target)
  clean = target.sub(%r{\A#{Regexp.escape(BASEURL)}}, "")
  path, anchor = clean.split("#", 2)
  path = "/" if path.nil? || path.empty?
  [path, anchor]
end

def navigation_targets(surface, sections, entities)
  targets = []
  walk = lambda do |items|
    Array(items).each do |item|
      entity = entities.fetch(item.fetch("entity"))
      url = item["url"] || entity["url"]
      targets << [surface, item["entity"], url] if url && !entity["external"]
      walk.call(item["children"]) if item["children"]
    end
  end

  if surface == "sidebar"
    Array(sections).each { |section| walk.call(section["items"]) }
  else
    walk.call(sections)
  end
  targets
end

errors = []
pages = page_files
routes = {}
anchors = {}

pages.each do |path|
  route = route_for(path)
  if routes.key?(route)
    errors << "Duplicate page route #{route}: #{routes[route]} and #{path.relative_path_from(ROOT)}"
  else
    routes[route] = path.relative_path_from(ROOT).to_s
    anchors[route] = anchors_for(path)
  end
end

scan_files = pages + ROOT.glob("_includes/**/*.{html,md}") + ROOT.glob("_layouts/**/*.{html,md}")
scan_files.uniq.each do |path|
  internal_references(path).each do |target|
    target_path, anchor = normalize_target(target)
    next if target_path.start_with?("/assets/")
    next if target_path == "/404.html" && routes.key?(target_path)

    unless routes.key?(target_path)
      errors << "Missing internal page #{target} referenced by #{path.relative_path_from(ROOT)}"
      next
    end

    if anchor && !anchor.empty? && !anchors[target_path].include?(anchor)
      errors << "Missing anchor ##{anchor} on #{target_path}, referenced by #{path.relative_path_from(ROOT)}"
    end
  end
end

asset_example_documents = Set.new([
  "docs/WIKI_PAGE_TEMPLATES.md",
  "docs/REUSABLE_ARTICLE_COMPONENTS.md"
])
asset_scan_files = ROOT.glob("**/*.{md,html,yml,yaml,json,css,js}").reject do |path|
  path.to_s.include?("/.git/") || asset_example_documents.include?(path.relative_path_from(ROOT).to_s)
end
asset_scan_files.each do |path|
  path.read.scan(%r{/assets/[A-Za-z0-9_./-]+\.(?:png|jpe?g|svg|css|js|json)}).uniq.each do |asset|
    asset_path = ROOT.join(asset.sub(%r{\A/}, ""))
    errors << "Missing asset #{asset} referenced by #{path.relative_path_from(ROOT)}" unless asset_path.file?
  end
end

entities = YAML.safe_load(ROOT.join("_data/entities.yml").read, aliases: true)
navigation = YAML.safe_load(ROOT.join("_data/navigation.yml").read, aliases: true)

entities.each do |entity_id, entity|
  url = entity["url"]
  next unless url
  next if entity["external"]

  target_path, anchor = normalize_target(url)
  unless routes.key?(target_path)
    errors << "Entity #{entity_id} points to missing page #{url}"
    next
  end
  if anchor && !anchors[target_path].include?(anchor)
    errors << "Entity #{entity_id} points to missing anchor #{url}"
  end
end

navigation.each do |surface, sections|
  targets = navigation_targets(surface, sections, entities)
  grouped = targets.group_by { |entry| entry[2] }
  grouped.each do |url, entries|
    next if entries.length == 1

    ids = entries.map { |entry| entry[1] }.join(", ")
    errors << "Duplicate navigation target on #{surface}: #{url} (#{ids})"
  end

  targets.each do |_, entity_id, url|
    target_path, anchor = normalize_target(url)
    unless routes.key?(target_path)
      errors << "Navigation entity #{entity_id} points to missing page #{url}"
      next
    end
    if anchor && !anchors[target_path].include?(anchor)
      errors << "Navigation entity #{entity_id} points to missing anchor #{url}"
    end
  end
end

protected = {
  "/wiki/locations/arklune/" => ["the-grand-adventurer-guild"],
  "/wiki/factions/the-hive/" => ["the-rogue-hive", "zyrath-hive"],
  "/wiki/characters/" => ["founding-five", "beta-war"]
}
protected.each do |route, required|
  required.each do |anchor|
    errors << "Protected anchor missing: #{route}##{anchor}" unless anchors.fetch(route, Set.new).include?(anchor)
  end
end

walk_toc = lambda do |items, &block|
  Array(items).each do |item|
    block.call(item)
    walk_toc.call(item["children"], &block) if item["children"]
  end
end

pages.each do |path|
  data = front_matter(path)
  route = route_for(path, data)
  toc = data["toc"]
  if toc.is_a?(Array)
    walk_toc.call(toc) do |item|
      toc_id = item["id"]
      errors << "TOC item without id in #{path.relative_path_from(ROOT)}" unless toc_id
      if toc_id && !anchors.fetch(route, Set.new).include?(toc_id)
        errors << "TOC item ##{toc_id} is missing from #{route}"
      end
    end
  end

  tabs = data["tabs"]
  if tabs.is_a?(Array)
    tab_ids = tabs.map { |tab| tab["id"] }.compact
    errors << "Tab without id in #{path.relative_path_from(ROOT)}" if tab_ids.length != tabs.length
    errors << "Duplicate tab id in #{path.relative_path_from(ROOT)}" if tab_ids.uniq.length != tab_ids.length
  end
end

if errors.empty?
  puts "Validation passed"
  puts "Public URL count: #{routes.length}"
  puts "Protected anchors: #{protected.values.flatten.length}"
  puts "Internal links, anchors, assets, and navigation targets are valid"
  exit 0
end

warn "Validation failed with #{errors.length} error(s):"
errors.uniq.each { |error| warn "- #{error}" }
exit 1
