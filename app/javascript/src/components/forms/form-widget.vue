<template>
  <div class="o-white-container">
    <div class="columns o-step-layout">
      <div class="column is-10">
        <h3>{{ title }}</h3>
        <p class="small">{{ subtitle }}</p>
      </div>
      <div class="column is-2 has-text-right">
        <slot name="buttons"></slot>
      </div>
    </div>
    <div class="columns">
      <div class="column is-12">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
      }
    },
    props: {
      title: {type: String},
      subtitle: {type: String}
    }
  }
</script>
