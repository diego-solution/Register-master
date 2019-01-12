<template>
  <div class="container top-menu">
    <div class="columns o-menu">
      <div class="column is-12">
        <div class="o-menu__logo">
          <b-dropdown class="m-form__type" hoverable>
            <button class="button is-big is-link" slot="trigger">
              <span>Register</span>
              <img class="arrow" src="~images/icons/arrow-drop-white.svg" alt="choose workplace">
            </button>
            <b-dropdown-item has-link>
              <a href="https://www.eventfuel.io/home">Create</a>
            </b-dropdown-item>
          </b-dropdown>
        </div>
       
        <a class="m-mobile__menu" v-on:click=" mobileMenu = !mobileMenu" v-bind:class="{ open: mobileMenu }">
          <span></span>
          <span></span>
          <span></span>
          <span></span>
        </a>
        
        <div class="o-menu__pages" v-bind:class="{ mobile: mobileMenu }">
          <ul class="o-menu__pages-pages">
            <li><router-link to="/manage/events">Events</router-link></li>
            <li><router-link to="/manage/forms">Forms</router-link></li>
            <li><router-link to="/manage/layouts">Layouts</router-link></li>
            <li><router-link to="/manage/groups">Groups</router-link></li>
            <li><router-link to="/manage/translations">Translations</router-link></li>
            <li v-if="currentUser.super_admin">
              <router-link to="/manage/teams">Team</router-link>
            </li>
            <li v-if="currentUser.admin">
              <router-link to="/manage/users">Users</router-link>
            </li>
          </ul>
        </div>
        <div class="o-menu__account">
          <b-dropdown class="m-form__type" position="is-bottom-left" hoverable>
            <button class="button a-button-image account" slot="trigger">
              <template><img src="~images/icons/feedback.svg" alt="feedback"></template>
            </button>
            <b-dropdown-item has-link>
              <a href="https://help.eventfuel.io/" target="_blank">Help <span class="icon is-small"><i class="mdi mdi-arrow-right"></i></span></a>
            </b-dropdown-item>
            <!-- <b-dropdown-item has-link><router-link to="">Feedback</router-link></b-dropdown-item> -->
          </b-dropdown>

          <b-dropdown class="m-form__type" position="is-bottom-left" hoverable>
            <button class="button a-button-image account" slot="trigger">
              <template><img src="~images/icons/account.svg" alt="account options"></template>
            </button>
            <b-dropdown-item class="info" custom v-if="currentUser">
              <p>{{ currentUser.name }}</p>
              <p class="small">{{ currentUser.role }} | {{ getTeamName(currentUser.team) }} </p>
            </b-dropdown-item>
            <template v-if="optionsTeam.length>0">
              <hr class="dropdown-divider">
              <b-dropdown-item custom>
                <b>Teams</b>
              </b-dropdown-item>
              <b-dropdown-item v-for="option in optionsTeam" 
                              :value="option.id" 
                              :key="option.id"
                              has-link>
                <a href="#" @click.prevent="onChangeContext(option)"> {{ option.name }}</a>
              </b-dropdown-item>
            </template>
            <hr class="dropdown-divider">
            <b-dropdown-item has-link><router-link to="/manage/account">Account</router-link></b-dropdown-item>
            <b-dropdown-item has-link><router-link to="/logout">Log out</router-link></b-dropdown-item>
          </b-dropdown>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Auth from '../../backend/auth'
  import { messages } from '../../mixins/messages'

  export default {
    data(){
      return {
        mobileMenu: false,
        currentTeam: null,
        teamName: "",
        optionsTeam: [],
        currentUser: Auth.currentUser()
      }
    },
    created (){
      this.fetchData()
    },
    mixins: [messages],
    methods: {
      // load data
      fetchData() {
        this.$http.get('/teams').then((response) => {
          this.optionsTeam = response.data.data
        }, (error) => {
          this.optionsTeam = []
          this.displayErrorMessage(error);
        })
      },
      onChangeContext(what){
        const loadingComponent = this.$loading.open()
        this.currentTeam = what.id
        Auth.changeTeamContext(what.id).then(response => {
          Auth.saveToken(response.data.data.token)
          // this.currentTeam = what
          loadingComponent.close()
          // this caused trouble if you tried to change context inside a edit event screen for example
          // this.$router.go("/manage/events")
          location.reload()
        }).catch(error => {
          // console.log("error authenticating")
          // console.error(error.message)
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      getTeamName(team_id){
        var valObj = this.optionsTeam.filter(function(elem){
          if(elem.id == team_id) return elem;
        });

        if(valObj.length > 0)
          return valObj[0].name
      }
    },

  }
</script>
