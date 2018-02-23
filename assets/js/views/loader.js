import MainView from './main';
import PageIndexView from './page/command';
import PageDetailView from './page/detail';

// Collection of specific view modules
const views = {
  PageIndexView,
  PageDetailView
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}

