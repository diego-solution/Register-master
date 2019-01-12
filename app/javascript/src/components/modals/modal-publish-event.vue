<template>
  <div>
      <b-modal
        :active="isComponentModalActive"
        :width="800" scroll="keep"
        :onCancel="closeModal">
        <div class="card o-success-modal">
          <div class="card-image o-success-modal__image">
            <div class="m-success">
              <svg class="m-success__icon" viewBox="0 0 800 1200">
                <path class="m-success__icon-circle1" d="M400 850c-138.071 0-250-111.929-250-250s111.929-250 250-250 250 111.929 250 250-111.929 250-250 250z" fill="#FF7B80"/>
                <path class="m-success__icon-circle2" d="M400 850c-138.071 0-250-111.929-250-250s111.929-250 250-250 250 111.929 250 250-111.929 250-250 250z" fill="#007B80"/>
                <!-- <path class="m-success__icon-check" d="M393.4,124.43,179.6,338.21a40.57,40.57,0,0,1-57.36,0L11.88,227.84a40.56,40.56,0,0,1,57.36-57.36l81.7,81.7L336,67.06a40.56,40.56,0,0,1,57.36,57.36Z"/> -->
                <path class="m-success__icon-check" d="M269.5 592.875l92.5 89.5 169.5-163.75" stroke="#FFF" stroke-width="40" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
              </svg>
            </div>
          </div>
          <div class="card-content o-success-modal__content">
            <h2>Your event is published</h2>
            <p>You can share the following link for your registration page:</p>
            <a :href="eventURL" target="_blank" class="a-link-blue">
              {{eventURL}}
            </a>
            <p class="small">You can now check the event report to see your registrants.</p>
          </div>
        </div>
      </b-modal>
    </div>
</template>

<script>
export default {
  props: {
    eventURL: "",
    isOpen: false
  },
  methods:{
    closeModal: function () {
      this.$emit('update:isOpen', false)
    }
  },
  computed: {
    isComponentModalActive () {
      return this.isOpen
    }
  }
}
</script>
