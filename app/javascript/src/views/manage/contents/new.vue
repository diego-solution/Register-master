<template>
  <div>
    <navigation-title title="Review your Design" subtitle="Review the page layout for your event">
      <button class="button is-link" @click="validateBeforeSubmit">Confirm</button>
    </navigation-title>

    <div class="a-margin-top"></div>
    <form-page-layout :template.sync="pageContent" :hideName="true"></form-page-layout>
  </div>
</template>


<script>
  import { messages } from '../../../mixins/messages'

  export default {
    name: "NewPageContent",
    mixins: [messages],
    props: ["eventId", "pageLayoutId"],
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
          page_layout_id: null
        }
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/events/"+this.eventId+"/page_contents/new?page_layout_id="+this.pageLayoutId).then((response) => {
          this.pageContent = response.data.data
        },(error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          loadingComponent.close()
        })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post("/events/"+this.eventId+"/page_contents", {
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
