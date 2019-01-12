<template>
  <div class="t-secondary-page">
      <navigation-title
        title="Choose a Layout"
        subtitle="Select a existing Design Layout for your page">
       </navigation-title>

      <p class="o-event-title">Saved Layouts</p>
      <div class="columns">
        <page-layout-picker
          v-for="item in savedLayouts"
          :hidePreview="true"
          :item="item"
          :eventId="eventId"
          :isActive="item.id==(event.page_content || {}).id"
          :key="item.id">
        </page-layout-picker>
      </div>
      <p class="o-event-title">Default Layouts</p>
      <div class="columns">
        <page-layout-picker
          v-for="item in defaultLayouts"
          :hidePreview="true"
          :item="item"
          :eventId="eventId"
          :isActive="item.id==(event.page_content || {}).id"
          :key="item.id">
        </page-layout-picker>
      </div>
    </div>
</template>


<script>
  import { messages } from '../../../mixins/messages'
  import Auth from '../../../backend/auth'

  export default {
    name: 'ChooseLayout',
    props: ['eventId'],
    mixins: [messages],
    data: function() {
      return  {
        title: "Choose Layout",
        savedLayouts: [],
        defaultLayouts: [],
        event: Object
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
        const loadingComponent = this.$loading.open()

        this.$http.get("/events/"+this.eventId+'?team_id='+Auth.currentUser().team).then((response) => {
          this.event = response.data.data
          return this.$http.get("/page_layouts?page_layout_type=original"+'&team_id='+Auth.currentUser().team, sortParams)
        }).then((response) => {
          this.defaultLayouts = response.data.data
          return this.$http.get("/page_layouts"+'?team_id='+Auth.currentUser().team, sortParams)
        }).then((response) => {
          this.savedLayouts = response.data.data
        }).catch((error) => {
          this.defaultLayouts = []
          this.savedLayouts = []
          this.displayErrorMessage(error);
        }).finally(function () {
          loadingComponent.close()
        })
      }
    }
  }
</script>
