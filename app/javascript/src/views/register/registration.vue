<template>
  <div class="page--register t-template">
    <vue-headful :title="registration_event.public_name"/>

    <browser-warning :message="t('registration.error.browser')"></browser-warning>

    <section class="white">
      <transition name="loading">
        <loading-event v-if="isLoading"></loading-event>
        
        <registration-layout v-else :disableSidebar="registration_event.page_content.disable_sidebar">
          <div slot="header" v-html="registration_event.page_content.header_html"></div>
          <div slot="notification">
            <b-notification   :closable="true" v-show="previewMode">
              This is a preview of your event registration page. When you "Publish" this page will become visible to everyone.
            </b-notification>
          </div>
          <div slot="sidebar" v-html="registration_event.page_content.sidebar_html" v-if="registration_event.page_content.sidebar_html"></div>
          <div slot="add-to-calendar" v-if="registration_event.page_content.sidebar_html">
            <br>
            <b-dropdown hoverable>
              <button class="button is-black is-outlined is-small" slot="trigger">
                <span>{{ t('registration.calendar.title') }}</span>
              </button>
              <b-dropdown-item has-link>
                <a :href="this.registration_event.share_ical_url" target="_blank">iCal</a>
              </b-dropdown-item>
              <b-dropdown-item has-link>
                <a :href="this.registration_event.share_google_url" target="_blank">Google Calendar</a>
              </b-dropdown-item>
            </b-dropdown>
          </div>
          <div v-html="registration_event.page_content.body_html"></div>
        </registration-layout>
      </transition>
    </section>

    <section class="form" v-if="!isLoading">
      <div class="container">
        <div class="columns">
          <div class="column is-8 is-offset-2">

            <!-- TODO add to component -->
            <template v-if="registration_event.full_capacity">
              <b-notification type="is-info" :closable="false" v-if="registration_event.at_capacity_action=='stop'">
                {{this.t('registration.form.full')}}
              </b-notification>
              <b-notification type="is-info" :closable="false" v-else>
                {{this.t('registration.form.waitlist')}}
              </b-notification>
            </template>

            <template v-if="registration_event.registration_closed">
              <b-notification type="is-info" :closable="false">
                {{ this.t('registration.error.closed') }}
              </b-notification>
            </template>

            <form-registration v-if="registrationOpen"
              :questions="registration_event.registration_form.registration_questions"
              :eventId="registration_event.internal_name"
              :successMsg="this.t('registration.success.message')"
              :formTitle="this.t('registration.form.title')"
              :formButton="this.t('registration.form.button')">
            </form-registration>
          </div>
        </div>
      </div>
    </section>

    <footer-register v-if="!isLoading">
      <div v-html="registration_event.page_content.footer_html"></div>
    </footer-register>
  </div>
</template>

<script>
  import { translate } from '../../mixins/translations'
  import LoadingEvent from '../../components/loaders/loading-event'

  export default {
    name: 'ShowRegistrationEvent',
    props: ['id', 'token'],
    mixins: [translate],
    components: {"loading-event": LoadingEvent},
    data() {
      return {
        registration_event: {
          id: null,
          public_name: "",
          internal_name: null,
          header_html: "",
          footer_html: "",
          body_html: "",
          city: "",
          country: "",
          questions: [],
        },
        isLoading: true,
        previewMode: (this.$route.query.preview == "true")
      }
    },
    created () {
      // fetch the data when the view is created and the data is
      // already being observed
      var that = this
      setTimeout(function () {
        that.fetchData()
      }, 200);
    },
    watch: {
      // call again the method if the route changes
      '$route': 'fetchData'
    },
    methods: {
      fetchData: function () {
        var is_preview = ""
        if(this.previewMode == true){
          is_preview = "?preview=true"
        }
        this.$http.get('/events/' + this.id + "/public" + is_preview).then((response) => {
          this.registration_event = response.data.data;
          this.loadTranslations(this.registration_event.translations)
          this.setLocale(this.registration_event.language_key_abreviated)
          this.isLoading = false
        }, (server_response) => {
          this.isLoading = false
          this.$router.push("/event-not-found")
        })
      }
    },
    computed: {
      registrationOpen: function(){
        if(this.registration_event.registration_form == undefined)
          return false
        if(this.registration_event.registration_closed)
          return false
        if(!this.registration_event.full_capacity)
          return true
        if(this.registration_event.at_capacity_action == 'stop')
          return false
        return true
      }
    }
  }
</script>
