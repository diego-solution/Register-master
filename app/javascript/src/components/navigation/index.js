import NavigationTitle from './navigation-title'
import NavigationFilters from './navigation-filters'
import NavigationMenu from './navigation-menu'

export default {
  install (vm) {
    vm.component('navigation-title', NavigationTitle)
    vm.component('navigation-filters', NavigationFilters)
    vm.component('navigation-menu', NavigationMenu)
  }
}
