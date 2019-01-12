<template lang="html">
  <div class="column is-3 m-template-option" v-bind:class="{ active: isActive }">
    <router-link :to="{ name: 'NewPageContent', params: { eventId: eventId, pageLayoutId: item.id }}" class="m-template-option__image">
      <icon-check v-bind:class="{ complete: isActive }"  ></icon-check>
      <img class="layout" src="~images/templates/T3.png">
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
      eventId: {
        type: String,
        default: null,
        required: false
      },
      isActive: {
        type: Boolean,
        default: false
      },
      hidePreview: {
        type: Boolean,
        default: false
      }
    }
  }
</script>
