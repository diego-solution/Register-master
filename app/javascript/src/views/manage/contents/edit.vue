<template>
  <div>
    <navigation-title title="Edit your page content" 
                      subtitle="Edit and preview the layout for your event registration page">      
      <router-link :to="{ name: 'chooseEventLayout', params: { eventId: this.eventId }}" class="button is-link is-outlined">
        Replace with another Design
      </router-link>

      <button class="button is-link" @click="validateBeforeSubmit">Save</button>
    </navigation-title>

    <div class="a-margin-top"></div>
    <form-page-layout :template.sync="pageContent" 
                      :hideName="true">
    </form-page-layout>
  </div>
</template>

<script>
  import { messages } from '../../../mixins/messages'

  export default {
    name: "EditPageContent",
    mixins: [messages],
    props: ["eventId", "id"],
    data() {
      return {
        pageContent: {
          name: '',
          team_id: null,
          disable_sidebar: false,
          header: "",
          sidebar: "",
          body: "",
          footer: "",
          page_layout_id: null,
          event_id: null
        }
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/events/"+this.eventId+"/page_contents/"+this.id).then((response) => {
          this.pageContent = response.data.data
        },(error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          loadingComponent.close()
        })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.put("/events/"+this.eventId+"/page_contents/"+this.id, {
          page_content: this.pageContent
        }).then((response) => {
          this.$router.push({ name: 'editEvent', params: { id: this.eventId }})
          this.displaySuccessMessage(response)
        }, (error) => {
          this.displayErrorMessage(error)
        }).finally((response) => {
          loadingComponent.close()
        })
      },
      validateBeforeSubmit() {
        // alert("sup!")
        this.submitData();
        return;
      }
    }
  };
</script>