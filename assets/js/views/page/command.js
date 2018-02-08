import MainView from '../main';

export default class View extends MainView {
  mount() {
    super.mount();
    console.log('CommandView mounted');
  }

  unmount() {
    super.unmount();
    console.log('CommandView unmounted');
  }
}

