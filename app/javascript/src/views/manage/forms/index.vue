<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters 
        title="Registration Forms" 
        buttonAction="/manage/forms/new" 
        buttonName="New Form">
      </navigation-filters>

      <loading-widget title="Loading Forms" :isLoading="isLoading"></loading-widget>

      <div class="o-white-container" v-show="!isLoading">
        <data-table
          :rows="forms"
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
              <router-link :to="{ name: 'editForm', params: { id: justTheSlotScope.props.row.id }}" class="a-link-blue">
                {{ justTheSlotScope.props.row.name }}
              </router-link>
            </b-table-column>
            <b-table-column field="registration_questions" label="Questions">
              <span class="tag" :class="tag_type(justTheSlotScope.props.row.archived)">
                 {{ justTheSlotScope.props.row.registration_questions.length }}
               </span>
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
    name: 'ListForms',
    data(){
      return{
        forms: [],
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
    mixins: [messages],
    created (){
      this.fetchData()
    },
    methods: {
      tag_type(value) {
        if (value == "true") {
           return 'is-dark'
        } else{
           return 'is-light'
        }
      },
      // load data
      fetchData(sortParams) {        
        if(sortParams==undefined)
          sortParams=`&order_by=${this.sortField} desc`
        sortParams += '&team_id=' + Auth.currentUser().team
        this.isLoading = true
        this.$http.get("/registration_forms/?"+sortParams).then((response) => {
          this.forms        = response.data.data
          this.pagination   = response.data.pagination
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          this.isLoading = false
        })
      },
      onDeleteData(rowsToDelete){
        var teamParams = '?team_id=' + Auth.currentUser().team
        const loadingComponent = this.$loading.open()
        this.$http.post('/registration_forms/destroy_all' + teamParams, {
          registration_forms: rowsToDelete
        }).then((response) => {
          loadingComponent.close()
          this.fetchData()
          this.displaySuccessMessage(response);
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })

      }
    }
  }
</script>
