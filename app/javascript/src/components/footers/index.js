import FooterRegister from './footer-register'
import NavigationFooter from './navigation-footer'

export default {
  install (vm) {
    vm.component('footer-register', FooterRegister)
    vm.component('navigation-footer', NavigationFooter)
  }
}
