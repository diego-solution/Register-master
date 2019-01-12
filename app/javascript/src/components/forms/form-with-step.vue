<template>
  <div class="o-white-container m-step" v-bind:id="identifier" v-bind:class="{ active: open }">
    <div class="columns">
      <div class="column is-1 m-step__icon">
        <icon-check v-bind:class="{ complete: complete }"></icon-check>
      </div>
      <div class="column is-8 m-step__info">
        <h3>{{ title }}</h3>
        <p class="small">{{ subtitle }}</p>
        <slot name="preview" v-bind:class="{ active: open }"></slot>
      </div>
      <div class="column is-3 has-text-right m-step__action">
        <slot name="actions"></slot>
        <a class="button a-button-image is-small drop" v-on:click="toggle" v-show="hideToggle"></a>
      </div>
    </div>
    <div class="u-clearfix"></div>
    <div class="columns">
      <div class="column is-9 is-offset-1 m-step__form">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      identifier: { type: String },
      title: {type: String},
      subtitle: {type: String},
      // scope: {type: String, required: false },
      open: {type: Boolean, default: false},
      complete: {type: Boolean, default: false},
      hideToggle: {type: Boolean, default: true}
    },
    methods: {
      toggle(){
        this.$emit('cancelEdit')
      },
    }
  }
</script>
