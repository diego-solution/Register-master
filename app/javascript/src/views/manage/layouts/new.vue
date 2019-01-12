<template>
  <div class="">
    <navigation-title title="New Layout" subtitle="Create a new page design layout">
      <button class="button is-link" @click="validateBeforeSubmit">Create</button>
    </navigation-title>

    <div class="a-margin-top"></div>
    <form-page-layout :template.sync="page_layout">
    </form-page-layout>

  </div>
</template>


<script>
  import { messages } from '../../../mixins/messages'
  import Auth from '../../../backend/auth'

  export default {
    name: "NewLayout",
    mixins: [messages],
    data() {
      return {
        page_layout: {
          name: '',
          team_id: Auth.currentUser().team,
          disable_sidebar: false,
          header: "<h1>{{event.name}}</h1><h2>{{event.city}}</h2>",
          sidebar: "<h6>Date</h6><p>{{event.event_start_date}} at {{event.start_time}}</p><h6>Other info</h6><p>{{event.start_time}}</p><h6>Location</h6><p>{{event.location}}</p>",
          body: "<p>Add some text explaining what the event is all about.</p>",
          footer: "<p>© Company 2018 All rights reserved.</p><a href='https://www.eventfuel.io/about/our-mission' class='m-footer__link'>About</a><a href='https://www.eventfuel.io/privacy-policy' class='m-footer__link'>Privacy</a>"
        },
        options_team: [],
        title: "New Layout"
      };
    },
    methods: {
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post("/page_layouts", {
          page_layout: this.page_layout
        }).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/layouts")
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      validateBeforeSubmit() {
        // alert("sup!")
        this.submitData();
        return;
      }
    }
  };
</script>
