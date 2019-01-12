<template>
  <footer class="footer m-footer">
    <div class="container">
      <div class="content has-text-centered" v-bind:class="{ editable: editable }">
        <div v-if="hasDefaultSlot">
          <slot></slot>
        </div>
        <div v-else>
          <p>© Eventfuel 2018 All rights reserved.</p>
          <a href="https://www.eventfuel.io/about/our-mission" class="m-footer__link">About</a>
          <a href="https://www.eventfuel.io/privacy-policy" class="m-footer__link">Privacy</a>
          <a href="#/manage" class="m-footer__link">Manage</a>
        </div>
        <slot name="edit"></slot>
      </div>
    </div>
  </footer>
</template>


<script>
  export default {
    data() {
      return {
      }
    },
    props: {
      editable: {type: Boolean, required: false, default: false}
    },
    computed: {
      hasDefaultSlot () {
        return !!this.$slots.default
      }
    }
  }
</script>
