<template>
  <div id="app" v-bind:class="{ white: this.$route.meta.fullPage }">
    <template v-if="$route.matched.length">
      <router-view></router-view>
    </template>
    <!-- <template v-else>
      <p>You are logged {{ loggedIn ? 'in' : 'out' }}</p>
    </template> -->
  </div>
</template>

<script>
  import Auth from './backend/auth'
  import { messages } from './mixins/messages'
  
  export default {
    name: 'app',
    data () {
      return {
        loggedIn: Auth.loggedIn()
      }
    },
    created () {
      Auth.onChange = loggedIn => {
        this.loggedIn = loggedIn
      }
      this.setupAxios()
    },
    methods: {
      logoutPerson () {
        Auth.logout()
        this.$router.push({ path: '/' })
      },
      setupAxios () {
        const that = this
        this.$http.interceptors.response.use(function (response) {
          // we could use this to always show a generic loader
          return response;
        }, function (error) {
          // we could use this to auto refresh token
          if (error.response.status === 401) {
            //that.displayErrorMessage({ request:{ statusText: "For security reasons, we've signed you out. Please enter your details again" }})
            console.log("its a 401 so lets logout this person")
            that.logoutPerson()
          }
          return Promise.reject(error)
        })
      }
    }
  }
</script>
