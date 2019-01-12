<template>
  <div class="o-dashboard-menu" v-on:click="dashboardMobile = !dashboardMobile" v-bind:class=" { active: dashboardMobile }">
    <vue-headful :title="title"/>
    <div class="o-dashboard-menu__info">
      <h3>{{title}}</h3>
    </div>
    <a class="mobile-arrow">
      <img src="~images/icons/arrow.svg">
    </a>

    <slot></slot>

    <router-link v-bind:to="buttonAction" class="button is-link o-dashboard-button" v-if="buttonAction">
      {{ buttonName }}
    </router-link>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        dashboardMobile: false
      }
    },
    props: {
      links: {
        type: Array,
        required: false
      },
      showTitle: {
        type: Boolean,
        required: false,
        default: true
      },
      title: {
        type: String,
        required: false,
        default: 'Title'
      },
      buttonAction: {
        type: String,
        required: false,
        default: ''
      },
      buttonName: {
        type: String,
        required: false,
        default: 'Action Name'
      },
    }
  }
</script>
