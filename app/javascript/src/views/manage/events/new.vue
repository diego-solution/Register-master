<template>
  <div class="page--create-event">

    <navigation-title title="Create Event" subtitle="Let's get started.">
      <button class="button is-link" disabled>Publish</button>
    </navigation-title>

    <form-with-step
    title = "Basic Info"
    subtitle = "Mandatory Information"
    :hideToggle = "false"
    :complete.sync = "isFinished['step2']"
    :open.sync = "isOpen['step2']">

      <template slot="preview">
        <p class="small preview">Name: {{ registration_event.public_name }}</p>
        <p class="small preview">Group: {{ registration_event.group_name }}</p>
      </template>

      <form class="m-form" action="/api/v1/events/create" method="post" @submit.prevent="validateForm('step2')">

        <b-field label="Public Name*" data-v-step="1">
          <b-input v-model="registration_event.public_name" name="event['public_name']" placeholder="Name" required></b-input>
        </b-field>

        <b-field label="Event Group*" message="Organize your events using groups">
          <b-select v-model="registration_event.group_id" placeholder="Select a Group" name="group" required>
            <option v-for="option in groups" v-bind:value="option.id">
              {{ option.name }}
            </option>
          </b-select>
        </b-field>

        <b-field class="is-grouped m-form_submit">
          <button class="button is-black" data-v-step="2">Save</button>
          <a class="button is-text" @click="onCancelEdit('step2')">Cancel</a>
        </b-field>

      </form>
    </form-with-step>

    <v-tour name="newEventTour" :steps="steps"></v-tour>

  </div>
</template>

<script>
import { messages } from '../../../mixins/messages'
import { tour } from '../../../mixins/tour_manager'
import Auth from '../../../backend/auth'

export default {
  name: 'NewEvent',
  mixins: [messages, tour],
  data: function() {
    return  {
      registration_event: {
        id: null,
        group_id: null,
        public_name: null,
        internal_name: null,
      },
      groups: [],
      isFinished:{
        step2: false,
        step3: false,
        step4: false,
        step5: false,
        step6: false,
        step7: false,
      },
      isOpen:{
        step2: true,
        step3: true,
        step4: false,
        step5: false,
        step6: false,
        step7: false,
      },
      step2: Object,
      event_id: Number,
      steps: [
        {
          target: '[data-v-step="1"]',
          content: 'Start by adding a title and group for your event.'
        },
        {
          target: '[data-v-step="2"]',
          content: 'Save to see more options for your event.',
          params: {
            placement: 'top'
          }
        }
      ]

    }
  },
  created () {
    this.fetchData()
  },
  mounted: function () {
    this.startTour('newEventTour');
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      this.fetchGroups();
    },
    fetchGroups(){
      const loadingComponent = this.$loading.open()

      this.$http.get('/groups'+'?team_id='+Auth.currentUser().team).then((response) => {
        this.groups = response.data.data
        loadingComponent.close()
      }, (server_response) => {
        this.displayErrorMessage(server_response);
        loadingComponent.close()
      })
    },
    onSubmitEvent: function(scope){
      var params = this.registration_event
      const loadingComponent = this.$loading.open()

      this.$http.post('/events'+'?team_id='+Auth.currentUser().team,{
        event: params
      }).then((response) => {
        this.isFinished[scope] = true
        this.registration_event = response.data.data
        this.$router.push({ name: 'editEvent', params: { id: this.registration_event.id }})
        loadingComponent.close()
      }, (server_response) => {
        this.displayErrorMessage(server_response);
        loadingComponent.close()
      })
    },
    onCancelEdit(){
      this.$router.go(-1)
    },
    validateForm(scope){
      // TODO validate
      this.onSubmitEvent(scope);
    }
  }
}
</script>
