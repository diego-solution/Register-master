<template>
  <div> 
    <b-notification class="m-loading" 
      :closable="false" 
      v-show="isLoading">
      <b-loading 
        :is-full-page="false" 
        :active.sync="isLoading" 
        :canCancel="false"></b-loading>       
      <p>{{title}}</p>
    </b-notification>
  </div>
</template>

<script>
  export default {
    props: {
      isLoading: {
        type: Boolean,
        required: true,
        default: true
      },
      title: {
        type: String,
        required: false,
        default: 'Loading'
      }
    }
  }
</script>
