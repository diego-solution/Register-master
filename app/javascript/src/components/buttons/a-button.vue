<template>
  <a :href="href"
     :class='determineClass'
     @click.prevent="gotoRoute">
    <slot>Button</slot>
  </a>
</template>

<script>
  export default {
    props: {
      showLoader: {
        type: Boolean,
        required: false,
        default: false
      },
      href: {
        type: String,
        required: false,
        default: '#'
      },
      type: {
        type: String,
        required: false,
        default: 'is-text'
      },
      color: {
        type: String,
        required: false,
        default: 'black'
      }
    },
    methods: {
      gotoRoute (event) {
        if(this.type === "back"){
          this.$router.go(-1)
        }else{
          console.log(event.target.pathname);
          this.$router.push(event.target.pathname)
        }
      }
    },
    computed: {
      determineClass: function () {
        return 'button' + ' ' + this.color + ' ' + this.type
      }
    }
  }
</script>
