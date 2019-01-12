import RegistrationLayout from './registration-layout'
import BrowserWarning from './browser-warning'
// these were only used to prototype
// import HeaderQ1 from './o-header-q1'
// import HeaderQ2 from './o-header-q2'
// import HeaderQ3 from './o-header-q3'

export default {
  install (vm) {
    vm.component('browser-warning', BrowserWarning)
    vm.component('registration-layout', RegistrationLayout)
    // vm.component('o-header-q1', HeaderQ1)
    // vm.component('o-header-q2', HeaderQ2)
    // vm.component('o-header-q3', HeaderQ3)
  }
}
