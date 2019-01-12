import PageLayoutItem from './page-layout-item'
import PageLayoutPicker from './page-layout-pick'

export default {
  install (vm) {
    vm.component('page-layout-item', PageLayoutItem)
    vm.component('page-layout-picker', PageLayoutPicker)
  }
}
