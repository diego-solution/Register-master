<template>
  <section>
    <vue-headful title="Confirm Presence"/>

    <div class="t-template confirmation">

      <div class="container o-placeholders" v-if="isLoading">
        <div class="columns">
          <div class="column is-6 is-offset-3 o-placeholders__intro">
            <div class="a-placeholder title"></div>
            <div class="a-placeholder subtitle"></div>
            <div class="a-placeholder text"></div>
            <div class="a-placeholder reg-button"></div>
          </div>
        </div>
      </div>

      <transition name="loading">
        <div class="container m-event" v-if="!isLoading">
          <div class="columns">
            <div class="column is-6 is-offset-3 m-event__header has-text-centered">
              <div v-html="page_content.header_html"></div>

              <p>{{ t("confirmation.form.text") }}</p>

              <button class="button is-black is-outlined" @click.prevent="cancelRegistration">
                {{ t("confirmation.button.decline") }}
              </button>

            </div>
          </div>
        </div>
      </transition>

      <footer-register v-if="!isLoading">
        <div v-html="page_content.footer_html"></div>
      </footer-register>

    </div>
  </section>
</template>

<script>
import { messages } from '../../mixins/messages'
import { helpers } from '../../mixins/helpers'
import { translate } from '../../mixins/translations'

export default {
  name: 'ConfirmationRegistrant',
  mixins: [translate, messages, helpers],
  props: ['id', 'token', 'action'],
  data(){
    return{
      page_content: Object,
      isLoading: true
    }
  },
  created () {
    var that = this
    setTimeout(function () {
      that.fetchData()
    }, 500);
  },
  methods: {
    // load data
    fetchData() {
      this.finishRegistration("confirm")
    },
    fetchEvent(){
      this.isLoading = true
      this.$http.get('/events/' + this.id + "/public").then((response) => {
        var registration_event = response.data.data
        this.page_content = registration_event.page_content
        this.loadTranslations(registration_event.translations)
        this.isLoading = false
      }, (server_response) => {
        this.isLoading = false
        this.$router.push("/event-not-found")
        this.displayErrorMessage(server_response);
      })
    },
    cancelRegistration(){
      this.finishRegistration("cancel")
    },
    finishRegistration(action){
      const loadingComponent = this.$loading.open()
      this.$http.put('/events/' + this.id + "/registrants/" + this.token + "/confirm",{
        option: action
      }).then((response) => {
        loadingComponent.close()
        var status = response.data.message
        if(action=="cancel"){
          this.displaySuccessMessage({data:{message: status}})
        }
        this.fetchEvent()
      }, (error) => {
        loadingComponent.close()
        this.displayErrorMessage(error);
      })
    }
  }
}
</script>
