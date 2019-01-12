<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters
        title="Users" buttonAction="/manage/users/new" buttonName="New User">
      </navigation-filters>

      <loading-widget title="Loading users for team" :isLoading="isLoading"></loading-widget>

      <div v-show="!isLoading" class="o-white-container">
        <data-table
          :rows="users"
          :total="pagination.total_count"
          :per-page="pagination.per_page"
          :current-page="pagination.current_page"
          :paginated="true"
          :default-sort-field="sortField"
          :showDelete="true"
          @fetchData="fetchData"
          @deleteData="onDeleteData">
          
          <template slot="insideTableBody" slot-scope="justTheSlotScope">
            <b-table-column field="email" label="E-mail" sortable>
              <router-link :to="{ name: 'editUser', params: { id: justTheSlotScope.props.row.id }}" class="a-link-blue">{{ justTheSlotScope.props.row.email }}</router-link>
            </b-table-column>
            <b-table-column field="first_name" label="First Name" sortable>
              {{ justTheSlotScope.props.row.first_name }}
            </b-table-column>
            <b-table-column field="last_name" label="Last Name" sortable>
              {{ justTheSlotScope.props.row.last_name }}
            </b-table-column>

            <b-table-column label="Action" v-if="currentUser.super_admin">
              <b-dropdown hoverable>
                <button class="button is-small is-link is-outlined" slot="trigger">
                    <span>Manage</span>
                    <b-icon icon="menu-down"></b-icon>
                </button>
                <b-dropdown-item @click="onSendWelcomeEmail(justTheSlotScope.props.row)">Resend Invitation</b-dropdown-item>
              </b-dropdown>            
            </b-table-column>
          </template>
        </data-table>
      </div>

    </div>
  </div>
</template>

<script>
  import { messages } from '../../../mixins/messages'
  import Auth from '../../../backend/auth'

  export default {
    name: 'ListUsers',
    mixins: [messages],
    data(){
      return{
        users: [],
        isLoading: true,
        sortField: "created_at",
        currentUser: Auth.currentUser(),
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
      // load data
      fetchData(sortParams) {
        // const loadingComponent = this.$loading.open()
        if(sortParams==undefined)
          sortParams=`&order_by=${this.sortField} desc`
        sortParams += '&team_id=' + this.currentUser.team
        this.$http.get(`/users?${sortParams}`).then((response) => {
          this.users = response.data.data
          this.pagination    = response.data.pagination
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          this.isLoading = false
        })
      },
      onDeleteData(rowsToDelete){
        const loadingComponent = this.$loading.open()
        this.$http.post('/users/destroy_all', {
          users: rowsToDelete,
          team_id: this.currentUser.team
        }).then((response) => {
          loadingComponent.close()
          this.fetchData()
          this.displaySuccessMessage(response);
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      onSendWelcomeEmail(row){
        const loadingComponent = this.$loading.open()
        
        this.$http.put("/users/" + row.id + "/resend_welcome_email",{
          team_id: this.currentUser.team
        }).then((response) => {
          loadingComponent.close()
          this.displaySuccessMessage(response);
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      }
    }
  }
</script>
