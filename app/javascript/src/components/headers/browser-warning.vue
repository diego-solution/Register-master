<template>
  <div>
    <!--[if lte IE 9]>
      <div class="ieSupportMessage">
        <h2>{{ this.message }}</h2>
      </div>
    <![endif]-->
  </div>
</template>

<script>
  export default {
    props: {
      message: {type: String, required: false, default: "Browser not supported"},
    },
    data() {
      return {
      }
    }
  }
</script>
