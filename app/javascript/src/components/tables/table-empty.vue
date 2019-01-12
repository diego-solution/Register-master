<template>
  <section>
    <div class="content has-text-grey has-text-centered">
      <p><b-icon v-bind:icon="icon" size="is-large"></b-icon></p>
      <p>{{ title }}</p>
    </div>
  </section>
</template>

<script>
  export default {
    props:{
      title: {
        type: String,
        required: false,
        default: "No information to display."
      },
      icon: {
        type: String,
        required: false,
        default: "file"
      },
    },
  }
</script>
