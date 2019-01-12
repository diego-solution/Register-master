<template>
  <div>
    <button class="button is-small is-link"
    @click="isComponentModalActive = true">
      <slot></slot>
    </button>

    <b-modal :active.sync="isComponentModalActive" has-modal-card>
      <form-referral v-bind="formProps"></form-referral>
    </b-modal>
  </div>
</template>

<script>
import FormReferral from '../forms/form-referral'
export default {
  props: ["event_id"],
  components: {FormReferral},
  data() {
    return {
      isComponentModalActive: false,
      formProps: {
        event_id: this.event_id
      }
    }
  }
}
</script>
