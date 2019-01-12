<template>
  <section v-bind:class="{ section: !this.$route.meta.fullPage }">
    <vue-headful title="Register"/>
    <navigation-menu v-if='!this.$route.meta.fullPage'></navigation-menu>
    <div class="container">
      <router-view></router-view>
    </div>
    <navigation-footer v-if='!this.$route.meta.fullPage'></navigation-footer>
  </section>
</template>

<script>
export default {
  name: 'Register'
}
</script>
