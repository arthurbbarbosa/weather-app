const locate_search = document.querySelector('#locate_search');
const locate_input = document.querySelector('#locate_input');

const search_button = document.querySelector('#search');
const locate = document.querySelector('#locate');
const nav = document.querySelector('#nav');

search_button.addEventListener('click', () => {
  const isHidden = locate.classList.contains('hidden');

  locate.classList.toggle('hidden', !isHidden);
  locate.classList.toggle('block', isHidden);
  locate_search.classList.toggle('hidden', isHidden);
  locate_search.classList.toggle('block', !isHidden);

  nav.classList.toggle('max-lg:flex-col', !isHidden);
  nav.classList.toggle('max-lg:gap-5', !isHidden);
  search_button.classList.toggle('max-lg:hidden', !isHidden);
});

locate_search.addEventListener('submit', (e) => {
  e.preventDefault();

  window.location = `/?location=${encodeURIComponent(locate_input.value)}`;

  locate.classList.replace('hidden', 'block');
  locate_search.classList.replace('block', 'hidden');

  nav.classList.remove('max-lg:flex-col', 'max-lg:gap-5');
  search_button.classList.remove('max-lg:hidden');
});
