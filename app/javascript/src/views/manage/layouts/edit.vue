<template>
  <div>
    <navigation-title title="Edit Layout" subtitle="Edit existing design template">
      <button class="button is-link" @click="validateBeforeSubmit">Save</button>
    </navigation-title>

    <div class="a-margin-top"></div>
    <form-page-layout :template.sync="page_layout">
    </form-page-layout>
  </div>
</template>


<script>

  import { messages } from '../../../mixins/messages'

  export default {
    name: "EditPageLayout",
    mixins: [messages],
    props: ['id'],
    data() {
      return {
        page_layout: {
          name: '',
          team_id: null,
          disable_sidebar: false,
          header: "",
          sidebar: "",
          body: "",
          footer: "",
        },
        options_team: [],
        title: "Edit Layout"
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/page_layouts/"+this.id).then((response) => {
          this.page_layout = response.data.data
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.put("/page_layouts/" + this.id, {
          page_layout: this.page_layout}
        ).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/layouts")
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
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
