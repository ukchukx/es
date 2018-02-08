import MainView from '../main';

export default class View extends MainView {
  mount() {
    super.mount();
    this.accountSelect = document.querySelector('#account_select');
    this.accountSelect.addEventListener('change', this.handleSelect.bind(this), false);
    document
    .querySelectorAll('.timestamp')
    .forEach(t => {
    	t.innerHTML = new Date(parseInt(t.innerHTML)).toString();
    });
    console.log('DetailView mounted');
  }

  unmount() {
    super.unmount();
    console.log('DetailView unmounted');
  }

  handleSelect(e) {
    e.preventDefault();
    const { target: { value } } = e;
    if (value.length) window.location.href = `/details?account=${value}`;
  }
}

