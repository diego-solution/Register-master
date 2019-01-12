<template lang="html">
  <div class="column is-3 m-template-option">
    <router-link :to="{ name: 'editLayout', params: { id: item.id }}" class="m-template-option__image">
      <img class="layout" src="~images/templates/T1.png">
    </router-link>
    <p class="small">{{ item.name }}</p>
    <router-link to="#" class="button is-small is-link is-outlined" v-if="!hidePreview">Preview</router-link>
  </div>
</template>

<script>
  export default {
    props:{
      item: {
        id: null,
        name: null
      },
      hidePreview: {
        type: Boolean,
        default: false
      }
    }
  }
</script>
