import ModalReferral from './modal-referral'
import ModalEditLayout from './modal-edit-layout'
import ModalPublishEvent from './modal-publish-event'

export default {
  install (vm) {
    vm.component('modal-referral', ModalReferral)
    vm.component('modal-edit-layout', ModalEditLayout)
    vm.component('modal-publish-event', ModalPublishEvent)
  }
}
