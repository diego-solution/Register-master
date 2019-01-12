<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters title="Translations">
      </navigation-filters>

      <loading-widget title="Loading Translations" :isLoading="isLoading"></loading-widget>
 
      <div v-show="!isLoading" class="o-white-container">
        <data-table 
        :rows="data"
        :total="pagination.total_count"
        :per-page="pagination.per_page"
        :current-page="pagination.current_page"
        :paginated="true"
        :default-sort-field="sortField"
        @fetchData="fetchData">
          <template slot="insideTableBody" slot-scope="justTheSlotScope">
            <b-table-column field="english_name" label="Name">
              <router-link :to="{ name: 'editTranslation', params: { id: justTheSlotScope.props.row.id }}" class="a-link-blue">
                {{ justTheSlotScope.props.row.english_name }}
              </router-link>
            </b-table-column>
            <b-table-column field="key" label="Key">
              {{ justTheSlotScope.props.row.key }}
            </b-table-column>
          </template>
        </data-table>
      </div>
    </div>
  </div >
</template>


<script>
  import {messages} from '../../../mixins/messages'

  export default {
    name: 'ListLanguages',
    data(){
      return {
        data: [],
        isLoading: true,
        sortField: "name",
        pagination: {
          current_page: 1,
          next_page: 2,
          total_count: 0,
          total_pages: 1,
          per_page: 20
        }
      }
    },
    mixins: [messages],
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
        this.$http.get("/languages")
        .then((response) => {
          this.data          = response.data.data
          this.pagination    = response.data.pagination
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          this.isLoading = false
        })
      }
    }
  }
</script>
