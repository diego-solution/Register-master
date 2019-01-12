import Button from './a-button'
import ButtonSubmit from './button-submit'

export default {
  install (vm) {
    vm.component('a-button', Button)
    vm.component('button-submit', ButtonSubmit)
  }
}
