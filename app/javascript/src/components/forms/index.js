import FormWithStep from './form-with-step'
import FormWidget from './form-widget'
import FormRegistration from './form-registration'
import FormPageLayout from './form-page-layout'
import FormUser from './form-user'

export default {
  install (vm) {
    vm.component('form-with-step', FormWithStep)
    vm.component('form-widget', FormWidget)
    vm.component('form-registration', FormRegistration)
    vm.component('form-page-layout', FormPageLayout)
    vm.component('form-user', FormUser)
  }
}
