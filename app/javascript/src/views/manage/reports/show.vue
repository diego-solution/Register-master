<template>
  <div class="t-secondary-page">
    <!-- <div class="container"> -->
      <navigation-title
      :title="'Report for ' + registration_event.public_name"
      :subtitle="registration_event.registration_start_date | euro_date">
        <button class="button is-link" @click.prevent="fetchFile">Download</button>
      </navigation-title>

      <div class="columns">
        <div class="column">
          <div class="m-statistics report">
            <h2>{{ registration_event.number_attendees }}</h2>
            <p class="small">Registered</p>
          </div>
        </div>
        <div class="column">
          <div class="m-statistics report">
            <h2>{{ registration_event.number_canceled }}</h2>
            <p class="small">Canceled</p>
          </div>
        </div>
        <div class="column">
          <div class="m-statistics report">
            <h2>{{ registration_event.number_confirmed }}</h2>
            <p class="small">Confirmed</p>
          </div>
        </div>
        <div class="column">
          <div class="m-statistics report">
            <h2>{{ registration_event.capacity }} <small>({{ registration_event.percent_filled }})</small></h2>
            <p class="small">Max. Capacity</p>
          </div>
        </div>
      </div>
      <div class="columns">
        <div class="column is-12">
          <data-table
            :rows="registrants"
            :total="pagination.total_count"
            :per-page="pagination.per_page"
            :current-page="pagination.current_page"
            :default-sort-field="sortField"
            :paginated="true"
            :show-details="true"
            @fetchData="fetchRegistrants">

            <template slot="insideTableBody" slot-scope="justTheSlotScope">
              <b-table-column field="registration_status" label="Status" sortable>
                <span class="tag" :class="tag_type(justTheSlotScope.props.row.registration_status)">
                  {{ justTheSlotScope.props.row.registration_status }}
                </span>
              </b-table-column>
              <b-table-column field="referrer_id" label="Referrer" sortable>
                {{ justTheSlotScope.props.row.referrer_name}}
              </b-table-column>
              <b-table-column field="created_at" label="Registered in" sortable>
                {{ justTheSlotScope.props.row.created_at | euro_date}}
              </b-table-column>
              <b-table-column :label="answer['question_text']" :key="answer['question_id']" v-for="(answer) in justTheSlotScope.props.row.serialized_answers.slice(0,4)">
                {{ answer["value"] }}
              </b-table-column>
            </template>
            <template slot="insideDetailBody" slot-scope="justTheSlotScope">
              <div class="content">
                <div v-for="(answer) in justTheSlotScope.props.row.serialized_answers" :key="answer['question_id']">
                  <h6><strong>{{ answer["question_text"] }}</strong></h6>
                  <p>{{ answer["value"] }}</p>
                </div>
              </div>
            </template>
          </data-table>

        </div>
      </div>
    <!-- </div> -->
  </div>
</template>


<script>
import { messages } from '../../../mixins/messages'
import { helpers } from '../../../mixins/helpers'
import Auth from '../../../backend/auth'

export default {
  name: 'ShowReport',
  mixins: [helpers, messages],
  props: ['id'],
  data(){
    return{
      registrants: [],
      registration_event: Object,
      sortField: "created_at",
      pagination: {
        current_page: 1,
        next_page: 2,
        total_count: 0,
        total_pages: 1,
        per_page: 20
      }
    }
  },
  created (){
    this.fetchData()
  },
  watch: {
    // call again the method if the route changes
    '$route': 'fetchData'
  },
  methods: {
    tag_type(value) {
      if (value == "confirmed") {
         return 'is-success'
      } else{
         return 'is-light'
      }
    },
    // load data
    fetchData() {
      const loadingComponent = this.$loading.open()
      this.$http.get("/events/" + this.id + '?team_id='+Auth.currentUser().team).then((response) => {
        this.registration_event = response.data.data;
        loadingComponent.close()
        this.fetchRegistrants()
      }, (server_response) => {
        loadingComponent.close()
        this.displayErrorMessage(server_response);
      })
    },
    fetchRegistrants(sortParams){

      if(sortParams==undefined)
        sortParams=`&order_by=${this.sortField} desc`
      sortParams += '&team_id=' + Auth.currentUser().team

      const loadingComponent = this.$loading.open()
      this.$http.get(`/events/${this.id}/reports?${sortParams}`).then((response) => {
        this.registrants   = response.data.data
        this.pagination    = response.data.pagination
        loadingComponent.close()
      }, (error) => {
        loadingComponent.close()
        this.displayErrorMessage(error);
      })
    },
    fetchFile(){
      const source = "/events/" + this.id + "/reports/download" + "?team_id=" + Auth.currentUser().team
      const loadingComponent = this.$loading.open()
      //this.$http.get(source)
      this.$http({
        url: source,
        method: 'GET',
        responseType: 'blob', // important
        headers: { 'Accept': 'application/vnd.ms-excel' }
      }).then((response) => {
        loadingComponent.close()
        this.download(response)
      }, (error) => {
        loadingComponent.close()
        this.displayErrorMessage(error)
      })
    },
    download(response){
      if (!window.navigator.msSaveOrOpenBlob){
        //BLOB NAVIGATOR
        const url = window.URL.createObjectURL(new Blob([response.data]))
        const link = document.createElement('a')
        link.href = url
        link.setAttribute('download', 'download.xlsx')

        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
        window.URL.revokeObjectURL(url)
      }else{
        // BLOB FOR EXPLORER 11
        const url = window.navigator.msSaveOrOpenBlob(new Blob([response.data]), "download.xlsx");
      }
    }
  }
}
</script>
