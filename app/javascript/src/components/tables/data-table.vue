<template>
  <div>
    <b-table
      :data="rows"
      :checked-rows.sync="checkedRows"
      :checkable="showDelete"
      :paginated="paginated"
      :detailed="showDetails"
      :total="total"
      :per-page="perPage"
      :pagination-simple="true"
      :current-page="currentPage"
      backend-sorting
      backend-pagination
      :default-sort-direction="defaultSortOrder"
      :default-sort="sortField"
      @sort="onSort"
      @page-change="onPageChange"
      >

      <template slot-scope="props">
        <slot name="insideTableBody" :props="props">
        </slot>
      </template>
      <template slot="empty" v-if="isEmpty">
        <table-empty></table-empty>
      </template>
      <template slot="bottom-left">
        <table-footer
          :checked-rows.sync="checkedRows"
          v-on="$listeners">
        </table-footer>
      </template>
      <template slot="detail" slot-scope="props">
        <slot name="insideDetailBody" :props="props">
        </slot>
      </template>

    </b-table>
  </div>
</template>

<script>
  export default {
    data(){
      return {
        checkedRows: [],
        page: 1,
      }
    },
    created(){
      this.sortField = this.defaultSortField
      this.sortOrder = this.defaultSortOrder
    },
    props:{
      title: {
        type: String,
        required: false,
        default: 'Title'
      },
      rows: {
        type: Array,
        required: true,
        default: []
      },
      total: {
        type: Number,
        required: true,
        default: 0
      },
      defaultSortField: {
        type: String,
        required: false,
        default: 'name'
      },
      defaultSortOrder: {
        type: String,
        required: false,
        default: 'desc'
      },
      perPage: {
        type: Number,
        required: false,
        default: 20
      },
      currentPage: {
        type: Number,
        required: false,
        default: 1
      },
      paginated: {
        type: Boolean,
        required: false,
        default: false
      },
      showDelete: {
        type: Boolean,
        required: false,
        default: false
      },
      showDetails: {
        type: Boolean,
        required: false,
        default: false
      },
    },
    computed: {
      isEmpty: function () {
        return this.rows.length == 0
      }
    },
    methods: {
      // handle page-change event
      onPageChange(page) {
        this.page = page
        // console.log(this.sortParams());
        this.$emit("fetchData", this.sortParams())
      },
      onSort(field, order) {
        this.sortField = field
        this.sortOrder = order
        // console.log(this.sortParams());
        this.$emit("fetchData", this.sortParams())
      },
      sortParams(){
        var params = [
          `order_by=${this.sortField} ${this.sortOrder}`,
          `page=${this.page}`,
          `per_page=${this.perPage}`,
        ].join('&')
        return params
      }
    }
  }
</script>
