<template>
  <div class="columns">
    <div class="column is-12">
      <navigation-filters
        title="Layouts"
        buttonAction="/manage/layouts/new"
        buttonName="New Layout">
      </navigation-filters>

      <loading-widget title="Loading Layouts" :isLoading="isLoading"></loading-widget>
 
      <div v-show="!isLoading" class="o-white-container">
        <p class="o-event-title">Saved Layouts</p>
        <div class="columns">
          <page-layout-item
            v-for="(item, index) in saved_layouts"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:isActive="true"
            v-bind:key="item.id"
            v-bind:hidePreview="true">
          </page-layout-item>
          <div v-if="saved_layouts.length == 0">
            <div class="column is-12">
              <p class="small">No data here. Your custom layouts will appear here.</p>
            </div>
          </div>
        </div>
        <p class="o-event-title">Default Layouts</p>
        <div class="columns">
          <page-layout-item
            v-for="(item, index) in default_layouts"
            v-bind:item="item"
            v-bind:index="index"
            v-bind:isActive="false"
            v-bind:key="item.id"
            v-bind:hidePreview="true">
          </page-layout-item>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import { messages } from '../../../mixins/messages'
import Auth from '../../../backend/auth'

export default {
  name: 'ManageLayouts',
  mixins: [messages],
  data: function() {
    return  {
      title: "Page Layouts",
      saved_layouts: [],
      default_layouts: [],
      isLoading: true
    }
  },
  created () {
    this.fetchData()
  },
  watch: {
    '$route': 'fetchData'
  },
  methods: {
    fetchData(sortParams) {
      if(sortParams==undefined)
        sortParams=""

      this.$http.get("/page_layouts/?page_layout_type=original"+'&team_id='+Auth.currentUser().team, sortParams).then((response) => {
        this.default_layouts = response.data.data
        return this.$http.get("/page_layouts"+'?team_id='+Auth.currentUser().team, sortParams)
      }).then((response) => {
        this.saved_layouts = response.data.data
      }).catch((error) => {
        this.displayErrorMessage(error);
      }).finally((response) => {
        this.isLoading = false
      })
    }
  }
}
</script>
