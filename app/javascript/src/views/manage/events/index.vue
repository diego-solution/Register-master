<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters
        title="Events"
        buttonAction="/manage/events/new"
        buttonName="New Event">
      </navigation-filters>

      <loading-widget title="Loading Events" :isLoading="isLoading"></loading-widget>
      <div v-show="!isLoading">
        <event-filters 
          :currentFilter="this.name"
          :currentGroup="this.$route.query.group_id"
          :groups="groups">
        </event-filters>
 
        <div class="o-event">
          <div class="o-white-container">
            <data-table
              :rows="registrationEvents"
              :total="pagination.total_count"
              :per-page="pagination.per_page"
              :current-page="pagination.current_page"
              :default-sort-field="sortField"
              :showDelete="true"
              :paginated="true"
              @fetchData="fetchData"
              @deleteData="onDeleteData">

              <template slot="insideTableBody" slot-scope="justTheSlotScope">
                <b-table-column field="registration_start_date" label="Registration Start Date" sortable>
                  {{ justTheSlotScope.props.row.registration_start_date | euro_date }}
                </b-table-column>
                <b-table-column field="public_name" label="Topic" sortable>
                  <router-link :to="{ name: 'editEvent', params: { id: justTheSlotScope.props.row.id }}" class="a-link-blue">
                    {{ justTheSlotScope.props.row.public_name | truncate(35, "...") }}
                  </router-link>
                </b-table-column>
                <b-table-column field="status" label="Status" sortable>
                  <span class="tag" :class="tag_type(justTheSlotScope.props.row.status)">
                    {{ justTheSlotScope.props.row.status }}
                  </span>
                </b-table-column>
                <b-table-column field="city" label="City" sortable>
                  {{ justTheSlotScope.props.row.city }}
                </b-table-column>
                <b-table-column field="group_id" sortable label="Group">
                  {{ justTheSlotScope.props.row.group_name }}
                </b-table-column>
                <b-table-column field="number_attendees" label="Attendees">
                  <b-tooltip :label="justTheSlotScope.props.row.number_canceled + ' canceled'" position="is-bottom" type="is-dark">
                    <div class="u-trigger">
                      {{ justTheSlotScope.props.row.number_attendees }}
                    </div>
                  </b-tooltip>
                </b-table-column>
                <b-table-column field="percent_filled" label="Filled">
                  <b-tooltip :label="justTheSlotScope.props.row.capacity + ' Max. Capacity'" position="is-bottom" type="is-dark">
                    <div class="u-trigger is-link-blue">
                      {{ justTheSlotScope.props.row.percent_filled }}
                    </div>
                  </b-tooltip>
                </b-table-column>
                <b-table-column label="Manage">
                  <b-dropdown position="is-bottom-left">
                    <button class="button is-small is-white" slot="trigger">
                      <b-icon icon="dots-horizontal"></b-icon>
                    </button>      
                    <b-dropdown-item has-link>
                      <a :href="justTheSlotScope.props.row.url" target="_blank">
                        Open Event Page
                      </a>
                    </b-dropdown-item>
                    <b-dropdown-item has-link>
                      <router-link :to="{ name: 'showReport', params: { id: justTheSlotScope.props.row.id }}" v-if="justTheSlotScope.props.row.status=='published'">
                        Read Report
                      </router-link>
                    </b-dropdown-item>
                    <hr class="dropdown-divider">
                    <b-dropdown-item has-link>
                      <router-link :to="{ name: 'editGroup', params: { id: justTheSlotScope.props.row.group_id }}">
                        Edit Group
                      </router-link>
                    </b-dropdown-item>
                  </b-dropdown>   
                </b-table-column>

              </template>
            </data-table>
          </div>
        </div>

      </div>


    </div>
  </div>
</template>

<script>

  import { helpers } from '../../../mixins/helpers'
  import { messages } from '../../../mixins/messages'
  import Auth from '../../../backend/auth'
  import EventFilters from '../../../components/filters/event-filters'

  export default {
    name: 'ListEvents',
    props: ['name'],
    components: { EventFilters},
    mixins: [helpers, messages],
    data: function() {
      return  {
        registrationEvents: [],
        groups: [],
        total: 0,
        isLoading: true,
        sortField: "registration_start_date",
        pagination: {
          current_page: 1,
          next_page: 2,
          total_count: 0,
          total_pages: 1,
          per_page: 20
        },
      }
    },
    created () {
      this.fetchGroups()
      this.fetchData()
    },
    watch: {
      '$route': 'fetchData'
    },
    methods: {
      tag_type(value) {
        if (value == "published") {
           return 'is-dark'
        } else{
           return 'is-light'
        }
      },
      onDeleteData(rowsToDelete){
        const loadingComponent = this.$loading.open()
        this.$http.post('/events/destroy_all', {
          events: rowsToDelete,
          team_id: Auth.currentUser().team
        }).then((response) => {
          loadingComponent.close()
          this.fetchData()
          this.displaySuccessMessage(response);
        }, (error) => {
          loadingComponent.close()
          // this.fetchData()
          this.displayErrorMessage(error);
        })
      },
      fetchGroups() {
        var sortParams=`&order_by=name asc`
        sortParams += '&team_id=' + Auth.currentUser().team
        this.$http.get(`/groups?${sortParams}`).then((response) => {
          this.groups = response.data.data
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          // this.isLoading = false
        })
      },
      fetchData (sortParams) {
        console.log("fetching data");
        this.isLoading = true

        if(sortParams==undefined)
          sortParams=`&order_by=${this.sortField} desc`

        if(this.name)
          sortParams += "&filter="+this.name

        var group_filter = this.$route.query.group_id
        if(group_filter != undefined){
          console.log("added group filter")
          sortParams += "&group_id="+group_filter
        }

        sortParams += '&team_id=' + Auth.currentUser().team
        
        this.$http.get("/events?"+sortParams).then((response) => {
          this.registrationEvents = response.data.data
          this.pagination = response.data.pagination
        }, (error) => {
          this.registrationEvents = []
          this.displayErrorMessage(error);
        }).finally((response) => {
          this.isLoading = false
        })
      }
    }
  }
</script>
