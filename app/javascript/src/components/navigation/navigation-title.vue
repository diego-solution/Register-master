<template lang="html">
  <div class="columns t-secondary-page__header">
    <vue-headful :title="title"/>
    <div class="column is-6 t-secondary-page__header-info">
      <h2>{{ title }}</h2>
      <p>{{ subtitle }}</p>
      <div class="columns">
        <div class="column is-two-fifths"><slot name="below"></slot></div>
      </div> 
    </div>
    <div class="column is-6 t-secondary-page__header-actions">
      <a-button color="a-button-image" type="back" v-if="!hideBackButton">
        <span class="sr-only">Back</span>
      </a-button>
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: {type: String},
    subtitle: {type: String},
    hideBackButton: {type: Boolean, default: false}
  },
  methods: {
    // goback () {
    //   this.$router.go(-1)
    // },
  }
}
</script>
