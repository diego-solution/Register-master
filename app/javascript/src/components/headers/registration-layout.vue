<template>
  <div class="container m-event">
    <div class="columns" v-bind:class="{ editable: editable }">
      <div class="column m-event__header is-10 is-offset-1">
        <slot name="notification"></slot>
        <slot name="header"></slot>
        <slot name="edit-header"></slot>
      </div>
    </div>
    <div class="columns m-event__content" v-if="!disableSidebar">
      <div class="column is-3 is-offset-1 information"  v-bind:class="{ editable: editable }">
        <slot name="sidebar"></slot>
        <slot name="add-to-calendar"></slot>
        <slot name="edit-sidebar"></slot>
      </div>
      <div class="column is-7"  v-bind:class="{ editable: editable }">
        <slot></slot>
        <slot name="edit-body"></slot>
      </div>
    </div>
    <div class="columns m-event__content" v-if="disableSidebar"  v-bind:class="{ editable: editable }">
      <slot></slot>
      <slot name="edit-full-body"></slot>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      title: {type: String, required: false, default: "Event Registration Form"},
      disableSidebar: {type: Boolean, required: false, default: false},
      editable: {type: Boolean, required: false, default: false}
    },
    data() {
      return {
      }
    },
    computed: {
      hasDefaultSlot () {
        return !!this.$slots.default
      },
      hasHeaderSlot () {
        return !!this.$slots['header']
      },
      hasSidebarSlot () {
        return !!this.$slots['sidebar']
      }
    }
  }
</script>
