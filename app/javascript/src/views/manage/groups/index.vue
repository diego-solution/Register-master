<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters
        title="Groups" 
        buttonAction="/manage/groups/new" 
        buttonName="New Group">
      </navigation-filters>

      <loading-widget title="Loading Groups" :isLoading="isLoading"></loading-widget>
 
      <div v-show="!isLoading" class="o-white-container">
        <data-table
          :rows="data"
          :total="pagination.total_count"
          :per-page="pagination.per_page"
          :current-page="pagination.current_page"
          :default-sort-field="sortField"
          :showDelete="true"
          :paginated="true"
          @fetchData="fetchData"
          @deleteData="onDeleteData">
          <template slot="insideTableBody" slot-scope="justTheSlotScope">
            <b-table-column field="name" label="Name" sortable>
              <router-link :to="{ name: 'editGroup', params: { id: justTheSlotScope.props.row.id }}" class="a-link-blue">{{ justTheSlotScope.props.row.name }}</router-link>
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
    name: 'ListGroups',
    mixins: [messages],
    data(){
      return{
        data: [],
        sortField: "name",
        pagination: {
          current_page: 1,
          next_page: 2,
          total_count: 0,
          total_pages: 1,
          per_page: 20
        },       
        isLoading: true
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
        if(sortParams==undefined)
          sortParams=`&order_by=${this.sortField} desc`
        sortParams += '&team_id=' + Auth.currentUser().team

        this.$http.get(`/groups?${sortParams}`).then((response) => {
          this.data = response.data.data
          this.pagination = response.data.pagination
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          this.isLoading = false
        })
      },
      onDeleteData(rowsToDelete){
        const loadingComponent = this.$loading.open()
        this.$http.post('/groups/destroy_all', {
          groups: rowsToDelete,
          team_id: Auth.currentUser().team
        }).then((response) => {
          loadingComponent.close()
          this.fetchData()
          // this.$toast.open("Deleted")
          this.displaySuccessMessage(response);
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      }
    }
  }
</script>
