<template>
  <div class="page--create-event">
    <navigation-title
      v-bind:title="registration_event.public_name"
      v-bind:subtitle="registration_event.registration_start_date | euro_date">

      <a v-bind:href="registration_event.url" target="_new" class="button is-link is-outlined">Open Page</a>

      <button class="button"
        :class="{ 'is-link': canPublish, 'is-danger': canCancel }"
        @click.prevent="onPublish" data-v-step="2">
        {{ publishButtonText }}
      </button>
    </navigation-title>

    <!-- <p class="small" style="color: #0067D0">Todos os campos são de preenchimento obrigatório!</p> -->

    <form-with-step
      title = "Basic Info"
      subtitle = "Mandatory Information"
      :complete.sync = "isFinished['step2']"
      :open.sync = "isOpen['step2']"
      @cancelEdit = "onCancelEdit('step2')"
      identifier = "step2">

      <template slot="preview">
        <p class="small preview">Name: {{ registration_event.public_name }}</p>
        <p class="small preview">Group: {{ registration_event.group_name }}</p>
      </template>

      <form class="m-form" @submit.prevent="validateForm('step2')" data-vv-scope="step2">
        <b-field label="Name*">
          <b-input v-model="step2.public_name" name="public_name" placeholder="Name as will appear on page title" required v-validate></b-input>
        </b-field>

        <b-field label="Group*" :type="errors.has('step2.group') ? 'is-danger': ''" :message="errors.has('step2.group') ? errors.first('step2.group') : ''">
         <b-select v-model="step2.group_id" placeholder="Select a Group" name="group">
            <option v-for="option in groups" :key="option.id" :value="option.id">
              {{ option.name }}
            </option>
          </b-select>
        </b-field>

        <b-field class="is-grouped m-form_submit">
          <button class="button is-black">Save</button>
          <a class="button is-text" @click="onCancelEdit('step2')">Cancel</a>
        </b-field>
      </form>
    </form-with-step>

    <form-with-step
      title="Event Information"
      subtitle="Specify venue, location and date for your event"
      :complete.sync = "isFinished['step3']"
      :open.sync = "isOpen['step3']"
      @cancelEdit = "onCancelEdit('step3')"
      identifier = "step3">

      <template slot="preview">
        <p class="small preview">City: {{ registration_event.city }}</p>
        <p class="small preview">Dates: {{ registration_event.event_start_date | euro_date }} to {{ registration_event.event_end_date | euro_date }}</p>
        <p class="small preview">Time Zone: {{registration_event.time_zone}}</p>
      </template>

      <form class="m-form" @submit.prevent="validateForm('step3')"  >
        <b-field label="City*" data-v-step="3">
          <b-input v-model="step3.city" name="city" placeholder="Lisbon, Portugal" required v-validate></b-input>
        </b-field>

        <b-field label="Location*">
          <b-input v-model="step3.location" name="location" placeholder="Thunderdome Theater" required v-validate></b-input>
        </b-field>

        <b-field label="Time Zone">
          <b-select v-model="step3.time_zone" placeholder="Choose a Time Zone" name="time_zone">
            <option v-for="option in time_zones" v-bind:key="option.label" v-bind:value="option.value">
              {{ option.label }}
            </option>
          </b-select>
        </b-field>

        <b-field grouped>
          <b-field label="Event Start Date*" message="Tell your visitors when the event is set to start" expanded>
            <b-datepicker
              v-model="step3.event_start_date"
              :min-date="minDate"
              :max-date="maxDate"
              placeholder="Click to select..."
              icon="calendar-today">
            </b-datepicker>
          </b-field>
          <b-field label="Select time*" expanded>
            <b-timepicker
              placeholder="Type or select a time"
              icon="clock"
              v-model="step3.event_start_date"
              :readonly="false">
            </b-timepicker>
          </b-field>
        </b-field>

        <b-field grouped>
          <b-field label="Event End Date*" message="Tell your visitors when the event is set to end " expanded>
            <b-datepicker
              v-model="step3.event_end_date"
              :min-date="minDate"
              :max-date="maxDate"
              placeholder="Click to select..."
              icon="calendar-today">
            </b-datepicker>
          </b-field>
          <b-field label="Select time*" expanded>
            <b-timepicker
              placeholder="Type or select a time"
              icon="clock"
              v-model="step3.event_end_date"
              :readonly="false">
            </b-timepicker>
          </b-field>
        </b-field>

        <b-field label="When*" message="Additional information about date for registration emails">
          <b-input v-model="step3.when" name="when" placeholder="ex: registration opens at" required v-validate></b-input>
        </b-field>

        <b-field class="is-grouped m-form_submit">
          <button class="button is-black">Save</button>
          <a class="button is-text" @click="closeForm('step3')">Cancel</a>
        </b-field>
      </form>
    </form-with-step>


    <form-with-step
      title="Registration and Attendees"
      subtitle="Setup what information to collect from attendees, what is event capacity and date to close registration"
      :complete.sync = "isFinished['step4']"
      :open.sync = "isOpen['step4']"
      @cancelEdit = "onCancelEdit('step4')"
      identifier = "step4">

      <template slot="preview">
        <p class="small preview">Capacity: {{ registration_event.capacity }}</p>
        <p class="small preview">When full: {{ registration_event.at_capacity_action }}</p>
        <p class="small preview">Close Registration: {{ registration_event.registration_close_date | euro_date }}</p>
      </template>

      <form class="m-form" @submit.prevent="validateForm('step4')">

        <b-field label="Max. Capacity" data-v-step="4">
          <b-input v-model="step4.capacity" name="capacity" placeholder="20" type="number" min="0" required v-validate></b-input>
        </b-field>

        <b-field label="On full capacity do">
          <b-select v-model="step4.at_capacity_action" placeholder="When the capacity is full.." required>
            <option value="stop">Stop new registrations</option>
            <option value="waitlist">Add to waitlist</option>
          </b-select>
        </b-field>

        <b-field grouped>
          <b-field label="Registration Start Date" expanded>
            <b-datepicker
              v-model="step4.registration_start_date"
              :min-date="minDate"
              :max-date="maxDate"
              placeholder="Click to select..."
              icon="calendar-today">
            </b-datepicker>
          </b-field>
          <b-field label="Registration End Date" expanded>
            <b-datepicker
              v-model="step4.registration_close_date"
              :min-date="step4.registration_start_date"
              :max-date="maxDate"
              placeholder="Click to select..."
              icon="calendar-today">
            </b-datepicker>
          </b-field>
        </b-field>

        <b-field label="Attendee Registration Profile" message="Choose a form to collect information from attendees">
          <b-select v-model="step4.registration_form_id" placeholder="Select a Profile" name="registration_form_id">
            <option v-for="option in registration_forms" :key="option.id" :value="option.id">
              {{ option.name }}
            </option>
          </b-select>
        </b-field>

        <b-field class="is-grouped m-form_submit">
          <button class="button is-black">Save</button>
          <a class="button is-text" @click="closeForm('step4')">Cancel</a>
        </b-field>
      </form>
    </form-with-step>


  <form-with-step
    title="Page Options"
    subtitle="Customize layout and design options for your registration page"
    :complete.sync = "isFinished['step5']"
    :open.sync = "isOpen['step5']"
    @cancelEdit = "onCancelEdit('step5')"
    identifier = "step5">

    <template slot="preview">
      <p v-if="registration_event.language" class="small preview">Language: {{ registration_event.language.english_name }}</p>
      <p class="small preview">URL: {{ registration_event.url }}</p>
    </template>

    <form class="m-form" @submit.prevent="validateForm('step5')">

      <b-field label="URL Pretty Link" message="Your event URL contains 2 parts. You can edit the subject part of the URL path here." data-v-step="5">
        <b-input v-model="step5.internal_name" name="internal_name" placeholder="Some pretty title, no spaces or special characters."></b-input>
      </b-field>

      <b-field label="Page Language">
        <b-select v-model="step5.language_id" placeholder="Select a Language" name="language_id">
          <option v-for="option in languages" :key="option.id" :value="option.id">
            {{ option.english_name }}
          </option>
        </b-select>
      </b-field>

      <b-field label="Event Description *">
        <b-input
          v-model="step5.description"
          type="textarea"
          placeholder="What is this about? Say something about your event that will entice your visitors."
          required v-validate>
        </b-input>
      </b-field>

      <div v-if="registration_event.page_content" label="Page Design">
        <b-field label="Page Design">
        </b-field>
        <div class="m-template-option column is-4">
          <b-tooltip label="Edit the page design" position="is-right" animated>
            <router-link :to="{ name: 'EditPageContent', params: { eventId: this.id, id: registration_event.page_content.id }}" class="m-template-option__image">
              <img class="layout" src="~images/templates/T1.png">
            </router-link>
          </b-tooltip>
          <p class="small">{{ registration_event.page_content.name }}</p>
        </div>
      </div>
      <div v-else>
        <b-field label="Page Design">
          <router-link :to="{ name: 'chooseEventLayout', params: { eventId: this.id }}" class="button is-link">
            <b-icon icon="page-layout-header"></b-icon>
            <span>Choose a design layout</span>
          </router-link>
        </b-field>
      </div>

      <b-field class="is-grouped m-form_submit">
        <button class="button is-black">Save</button>
        <a class="button is-text" @click="closeForm('step5')">Cancel</a>
      </b-field>
    </form>
  </form-with-step>


<!--
  <form-with-step
    title="Report Schedule"
    subtitle="Configure report and send options"
    :complete.sync = "isFinished['step6']"
    :open.sync = "isOpen['step6']"
    @cancelEdit = "onCancelEdit('step6')">

    <template slot="preview">
      <p class="small preview" data-v-step="6">TODO</p>
    </template>

    <form class="m-form" @submit.prevent="validateForm('step6')" data-vv-scope="step6">

      <b-field label="Recipient emails">
        <b-input name="recipients"></b-input>
      </b-field>

      <b-field label="Start Date">
        <b-datepicker
          placeholder="Click to select..."
          icon="calendar-today">
        </b-datepicker>
      </b-field>

      <b-field label="When">
        <div class="block">
          <b-radio native-value="Flint">Hourly</b-radio>
          <b-radio native-value="Flint">Daily</b-radio>
        </div>
      </b-field>

      <b-field class="is-grouped m-form_submit">
        <button class="button is-black">Save</button>
        <a class="button is-text" @click="closeForm('step6')">Cancel</a>
      </b-field>
    </form>
  </form-with-step>
-->

  <form-with-step
    title="E-mail Options"
    subtitle="Customize options like e-mail sender and text for registrants"
    :complete.sync = "isFinished['step7']"
    :open.sync = "isOpen['step7']"
    @cancelEdit = "onCancelEdit('step7')"
    identifier = "step7">

    <template slot="preview">
      <p class="small preview">Sending from: {{ registration_event.from_name_email }}</p>
    </template>

    <form class="m-form" @submit.prevent="validateForm('step7')" data-vv-scope="step7">

      <b-field grouped>
        <b-field label="Sender Name for emails (From Name)">
          <b-input v-model="step7.from_name" name="from_name" placeholder="Ex: Peter Parker" required v-validate></b-input>
        </b-field>
        <b-field label="Address @eventacc.es" message="Please do not use special characters" expanded>
          <b-input v-model="step7.from_address" name="from_address" placeholder="Ex: peter" required v-validate="'required|alpha_num'"></b-input>
        </b-field>
      </b-field>

      <b-field class="is-grouped m-form_submit">
        <button class="button is-black">Save</button>
        <a class="button is-text" @click="closeForm('step7')">Cancel</a>
      </b-field>
    </form>
  </form-with-step>

  <div class="columns" v-if="registration_event.status=='published'">
    <div class="column">
      <div class="m-statistics">
        <h2>Add a referrer to your event</h2>
        <p class="small" data-v-step="7">Create a trackable link that you can share with attendees.</p>
        <modal-referral :event_id="registration_event.id">
          Send referral link
        </modal-referral>
      </div>
    </div>

    <div class="column">
      <div class="m-statistics">
        <h2>Report</h2>
        <p class="small" data-v-step="8">View event statistics and who signed up in the report.</p>
        <router-link :to="{ name: 'showReport', params: { id: registration_event.id }}" class="button is-small is-link">Open Report</router-link>
      </div>
    </div>
  </div>



<!--
    <form-with-step title="Event Layout" subtitle="Mandatory Information"  v-bind:finished="finished" v-bind:open="false">
      <div slot="formContent">
        <router-link to="/manage/events/event-layout" class="button is-link">Choose Layout</router-link>
      </div>
    </form-with-step>

    <form-with-step title="Email Options" subtitle="Mandatory Information"  v-bind:finished="finished" v-bind:open="false">

    </form-with-step>

    <form-with-step title="Other Options" subtitle="Mandatory Information"  v-bind:finished="finished" v-bind:open="false">
      <div slot="formContent">
      </div>
    </form-with-step>
-->

  <v-tour name="editEventTour" :steps="steps"></v-tour>
  <modal-publish-event
    :eventURL="registration_event.url"
    :isOpen.sync="isSuccessModalActive">
  </modal-publish-event>

  </div>
</template>

<script>

import { messages } from '../../../mixins/messages'
import { helpers } from '../../../mixins/helpers'
import { tour } from '../../../mixins/tour_manager'
import { Validator } from 'vee-validate'
import Auth from '../../../backend/auth'
import moment from 'moment'

export default {
  name: 'EditEvent',
  mixins: [helpers, messages, tour],
  props: ['id'],
  data: function() {
    return  {
      isSuccessModalActive: false,
      registration_event: Object,
      groups: [],
      registration_forms: [],
      languages: [],
      time_zones: [],
      isFinished:{
        step2: false,
        step3: false,
        step4: false,
        step5: false,
        step6: false,
        step7: true,
        step8: true,
      },
      isOpen:{
        step2: false,
        step3: false,
        step4: false,
        step5: false,
        step6: false,
        step7: false,
        step8: false,
      },
      step2: Object,
      step3: Object,
      step4: Object,
      step5: Object,
      step6: Object,
      step7: Object,
      step8: Object,
      steps: [
        {
          target: '[data-v-step="2"]',
          content: 'Before you can publish, we need more information about the event.'
        },
        {
          target: '[data-v-step="3"]',
          content: 'Setup the start and end dates for the event and location.',
          params: {
            placement: 'bottom'
          }
        },
        {
          target: '[data-v-step="4"]',
          content: 'Define what happens when the event hits max capacity and what information is required from attendees.'
        },
        {
          target: '[data-v-step="5"]',
          content: 'Customize the design and information for the public event page.',
          params: {
            placement: 'bottom'
          }
        },
        // {
        // target: '[data-v-step="6"]',
        //  content: 'This step is optional. You can send a report with the attendee registrations bye email until the event is finished.'
        // },
        // {
        //   target: '[data-v-step="7"]',
        //   content: 'Create a referral link to track where your attendees came from.'
        // },
      ]
    }
  },
  created () {
    // fetch the data when the view is created and the data is
    // already being observed
    this.fetchData()
  },
  mounted: function () {
    this.startTour('editEventTour');
  },
  watch: {
    // call again the method if the route changes
    '$route': 'fetchData'
  },
  methods: {
    fetchData () {
      const loadingComponent = this.$loading.open()
      this.$http.get("/events/"+this.id+'?team_id='+Auth.currentUser().team).then((response) => {
        this.populateEvent(response.data.data);
        return this.$http.get('/groups'+'?team_id='+Auth.currentUser().team)
      }).then((response) => {
        this.groups = response.data.data
        return this.$http.get('/registration_forms'+'?team_id='+Auth.currentUser().team)
      }).then((response) => {
        this.registration_forms = response.data.data
        return this.$http.get('/languages'+'?team_id='+Auth.currentUser().team)
      }).then((response) => {
        this.languages = response.data.data
        return this.$http.get('/locales/time_zones')
      }).then((response) => {
        this.time_zones = response.data.data
      }).catch((error) => {
        this.displayErrorMessage(error);
      }).finally(function () {
        loadingComponent.close()
      })
    },
    populateEvent(event){
      this.registration_event = event
      //divide in steps
      this.fillStep2(event)
      this.fillStep3(event)
      this.fillStep4(event)
      this.fillStep5(event)
      this.fillStep6(event)
      this.fillStep7(event)
      this.markAsFinished("step2")
      this.markAsFinished("step3")
      this.markAsFinished("step4")
      this.markAsFinished("step5")
      this.markAsFinished("step6")
      this.markAsFinished("step7")

      if(!this.isFinished["step2"])
        this.isOpen["step2"] = true

      if(!this.isFinished["step3"])
        this.isOpen["step3"] = true

      if(!this.isFinished["step4"])
        this.isOpen["step4"] = true

      if(!this.isFinished["step5"])
        this.isOpen["step5"] = true

      if(!this.isFinished["step6"])
        this.isOpen["step6"] = true

      return true;
    },
    fillStep2(event){
      this.step2 = { public_name: event.public_name, group_id: event.group_id }
    },
    fillStep3(event){
      this.step3 = {
        city: event.city,
        location: event.location,
        event_start_date: new Date(event.event_start_date),
        event_end_date: new Date(event.event_end_date),
        time_zone: event.time_zone,
        when: event.when
      }
    },
    fillStep4(event){
      this.step4 = { capacity: event.capacity, at_capacity_action: event.at_capacity_action,
                     registration_form_id: event.registration_form_id,
                     registration_start_date: new Date(event.registration_start_date),
                     registration_close_date: new Date(event.registration_close_date)
      }
    },
    fillStep5(event){
      this.step5 = {
        slug: event.slug,
        language_id: event.language_id,
        internal_name: event.internal_name,
        description: event.description
        // header_content_id: event.header_content_id,
        // footer_content_id: event.footer_content_id
      }
    },
    fillStep6(event){
      // this.step6 = {signup_notification_recipients: signup_notification_recipients}
      // this.step6 = {
      //   additional_data: event.additional_data
      // }
    },
    fillStep7(event){
      this.step7 = {
        from_name: event.from_name,
        from_address: event.from_address,
        from_name_email: event.from_name_email
      }
    },
    onCancelEdit(scope){
      const event = this.registration_event

      if(scope=="step2")
        this.fillStep2(event)

      if(scope=="step3")
        this.fillStep3(event)

      if(scope=="step4")
        this.fillStep4(event)

      if(scope=="step5")
        this.fillStep5(event)

      if(scope=="step6")
        this.fillStep6(event)

      if(scope=="step7")
        this.fillStep7(event)

      return this.closeForm(scope);
    },
    closeForm: function(scope){
      this.isOpen[scope] = !this.isOpen[scope];
    },
    markAsFinished(scope){
      function checkPropertiesForNull(obj) {
        for (var key in obj) {
          if (obj[key] == null || obj[key] == "" || obj[key]==undefined)
            return true;
        }
        return false;
      }
      const isFinished = checkPropertiesForNull(this.$data[scope])
      this.isFinished[scope] = !isFinished
      return;
      //return console.log("mark as finished? " + scope + " " + !isFinished);
    },
    submitEventData: function(scope){      
      var params = this.$data[scope];
      const loadingComponent = this.$loading.open()
      this.$http.put('/events/'+this.id+'?team_id='+Auth.currentUser().team, {
        event: params
      }).then((response) => {
        this.populateEvent(response.data.data)
        this.markAsFinished(scope)
        this.closeForm(scope)
        loadingComponent.close()
      }, (server_response) => {
        loadingComponent.close()
        this.displayErrorMessage(server_response);
      })
    },
    validateForm(scope){
      console.log(scope)
      this.$validator.validateAll(scope).then(result => {
        // this is not validating....
        if (result) {
          return this.submitEventData(scope)
        }
        return false;
      })
    },
    onPublish: function(){
      if(this.canPublish){
        this.publish()
      }else{
        this.cancel()
      }
    },
    publish: function(){
      var result = true;

      for(var key in this.$data["isFinished"]){
        if (this.$data["isFinished"][key] == false){
          this.scrollToElement("#"+key)
          this.isOpen[key] = true
          this.displayErrorMessage({ request:{ statusText: "Please review all mandatory fields." }})
          return false;
        }
      }

      const loadingComponent = this.$loading.open()
      this.$http.put('/events/'+this.id+"/publish"+'?team_id='+Auth.currentUser().team).then((response) => {
        this.$confetti.start()
        this.populateEvent(response.data.data)
        loadingComponent.close()
        this.isSuccessModalActive = true
      }, (server_response) => {
        loadingComponent.close()
        this.displayErrorMessage(server_response);
      })
      const that = this;
      setTimeout(function(){ that.$confetti.stop() }, 2000);
    },
    cancel: function(){
      const loadingComponent = this.$loading.open()

      this.$http.put('/events/'+this.id+"/cancel"+'?team_id='+Auth.currentUser().team).then((response) => {
        // Pedro: This is cumbersome...
        this.populateEvent(response.data.data)
        loadingComponent.close()
        this.displaySuccessMessage(response)
      }, (server_response) => {
        this.displayErrorMessage(server_response);
        loadingComponent.close()
      })
    },
    scrollToElement: function(key){
      let el = this.$el.querySelector(key)
      // Get the bounding rectangle so we can get the element position position
      let rect = el.getBoundingClientRect()
      // Scroll to the element (using x and y axis)
      window.scrollTo(rect.left, rect.top)
    }
  },
  computed: {
    publishButtonText: function(){
      if(this.registration_event.status == "draft"){
        return "Publish"
      }else if(this.registration_event.status == "published"){
        return "Cancel"
      }
    },
    minDate: function(){
      var to = moment().subtract(2, 'years').toDate();
      return to;
    },
    maxDate: function(){
      var to = moment().add(5, 'years').endOf('week').startOf('day').toDate();
      return to;
    },
    canCancel: function(){
      if(this.registration_event.status != "draft"){
        return true
      }else{
        return false
      }
    },
    // a computed getter
    canPublish: function () {
      if(this.registration_event.status == "published")
        return false

      return true;
    }
  }
}
</script>
