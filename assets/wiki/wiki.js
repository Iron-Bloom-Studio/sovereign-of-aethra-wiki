(()=>{const script=document.currentScript;const base=script.src.replace('/assets/wiki/wiki.js','');const b=document.querySelector('.menu-toggle'),n=document.querySelector('.site-nav');if(b)b.onclick=()=>{const open=n.classList.toggle('open');b.setAttribute('aria-expanded',String(open))};document.querySelectorAll('[data-lightbox]').forEach(a=>a.addEventListener('click',e=>{e.preventDefault();const box=document.createElement('div');box.className='lightbox';box.setAttribute('role','dialog');box.setAttribute('aria-modal','true');box.innerHTML='<button aria-label="Close enlarged image">Close</button><figure><img alt="" src="'+a.href+'"><figcaption>'+a.dataset.caption+'</figcaption></figure>';const close=()=>box.remove();box.onclick=event=>{if(event.target===box||event.target.tagName==='BUTTON')close()};document.addEventListener('keydown',function esc(event){if(event.key==='Escape'){close();document.removeEventListener('keydown',esc)}});document.body.append(box);box.querySelector('button').focus()}));const input=document.querySelector('#wiki-search'),out=document.querySelector('#search-results');if(!input||!out)return;const show=items=>{const q=input.value.toLowerCase().trim();const matched=items.filter(x=>(x.title+' '+x.tags+' '+x.description).toLowerCase().includes(q)).slice(0,8);out.innerHTML=q?(matched.length?matched.map(x=>'<a href="'+x.url+'" role="option">'+x.title+'<small>'+x.type+' · '+x.description+'</small></a>').join(''):'<span class="no-results">No public entries found.</span>'):'';out.classList.toggle('open',Boolean(q))};fetch(new URL('search.json',script.src),{cache:'no-store'}).then(response=>{if(!response.ok)throw new Error('Search index unavailable');return response.json()}).then(items=>{input.addEventListener('input',()=>show(items));input.addEventListener('keyup',()=>show(items));input.addEventListener('keydown',event=>{if(event.key==='Enter'){event.preventDefault();window.location.href=base+'/search/?q='+encodeURIComponent(input.value)}})}).catch(()=>{out.innerHTML=''});})();

(() => {
  document.querySelectorAll('[data-tabs]').forEach((tabs) => {
    const buttons = Array.from(tabs.querySelectorAll('[role="tab"]'));
    const panels = Array.from(tabs.querySelectorAll('[role="tabpanel"]'));
    const enabled = buttons.filter((button) => !button.disabled);

    const select = (button) => {
      buttons.forEach((candidate) => {
        const selected = candidate === button;
        candidate.setAttribute('aria-selected', String(selected));
        candidate.tabIndex = selected ? 0 : -1;
      });
      panels.forEach((panel) => {
        panel.hidden = panel.id !== button.getAttribute('aria-controls');
      });
    };

    enabled.forEach((button, index) => {
      button.addEventListener('click', () => select(button));
      button.addEventListener('keydown', (event) => {
        if (!['ArrowLeft', 'ArrowRight', 'Home', 'End'].includes(event.key)) return;
        event.preventDefault();
        let next = index;
        if (event.key === 'ArrowLeft') next = (index - 1 + enabled.length) % enabled.length;
        if (event.key === 'ArrowRight') next = (index + 1) % enabled.length;
        if (event.key === 'Home') next = 0;
        if (event.key === 'End') next = enabled.length - 1;
        enabled[next].focus();
        select(enabled[next]);
      });
    });

    const selected = enabled.find((button) => button.getAttribute('aria-selected') === 'true') || enabled[0];
    if (selected) select(selected);
  });
})();
