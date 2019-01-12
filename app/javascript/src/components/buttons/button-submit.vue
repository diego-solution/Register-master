<template>
    <button :class="determineClass">
        <b-icon v-show="isLoading" pack="fas" icon="spinner" custom-class="fa-spin"></b-icon>
        <b-icon v-show="isDone" pack="fas" icon="check"></b-icon>
        <span><slot>Button</slot></span>
    </button>
</template>

<script>
  export default {
    props: {
      isLoading: {
        type: Boolean,
        required: false,
        default: false
      },
      isDone: {
        type: Boolean,
        required: false,
        default: false
      },
      color: {
        type: String,
        required: false,
        default: 'primary'
      }
    },
    methods: {
      greet() {
        console.log("ehllo?")
      }
    },
    computed: {
      determineClass: function () {
        return 'button' + ' ' + this.color
      }
    }
  }
</script>