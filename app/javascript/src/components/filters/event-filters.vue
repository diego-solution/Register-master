<template>
  <div class="o-group_menu">
    <div class="o-group_menu-tabs">
      <ul class="m-dashboard__pages" v-if="menuLinks">
        <li class="m-dashboard__pages-link" v-for="link in menuLinks" :key="link.name">
          <a href="#" :class="{ 'router-link-active': link.slug==currentFilter }"
            @click.prevent="onChangeFilter(link.slug)">
            {{ link.name }}
          </a>
        </li>
      </ul>
    </div>
    <div class="o-group_menu-edit">
      <b-dropdown hoverable position="is-bottom-left" @change="onChangeContext">
        <button class="button is-white" :class="{ 'router-link-active': currentGroup }" slot="trigger">
          <b-icon icon="filter-variant" size="is-small"></b-icon>
          <span>Filter</span>
        </button>
        <b-dropdown-item v-for="group in groups" 
                          :value="group.id" 
                          :key="group.id" 
                          >
          {{ group.name }}
        </b-dropdown-item>
      </b-dropdown>          
    </div>
  </div>
</template>

<script>
  export default {
    name: 'EventFilters',
    props: ['groups', "currentFilter", "currentGroup"],
    created(){
      this.groupId = this.currentGroup
    },
    data: function() {
      return  {
        groupId: null,
        menuLinks:[
          {
            name: "Recent",
            slug: "recent"
          },
          {
            name: "All",
            slug: "all"
          },
          {
            name: "Past",
            slug: "past"
          },
          {
            name: "Upcoming",
            slug: "upcoming"
          },
          {
            name: "Drafts",
            slug: "draft"
          }
        ]
      }
    },
    methods: {
      onChangeContext(value){
        if(this.currentFilter==undefined){
          this.$router.push({ name: 'listEvents', query: { group_id: value }})
        }else{
          this.$router.push({ name: 'filterEvents', params: { name: this.currentFilter }, query: { group_id: value }})
        }
      },
      onChangeFilter(value){
        if(value=="recent"){
          this.$router.push({name: "listEvents", query: { group_id: this.currentGroup } })
        }else{
          this.$router.push({ name: 'filterEvents', params: { name: value }, query: { group_id: this.currentGroup }})
        }
      },
    }
  }
</script>
