<template>
  <div class="">
    <navigation-title title="Edit Group">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <b-field label="Name">
          <b-input v-model="group.name" name="name" placeholder="Name"></b-input>
        </b-field>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Save</button-submit>
          <a-button color="is-text" href="/manage/groups">Cancel</a-button>
        </b-field>
      </form-widget>
    </form>
  </div>
</template>

<script>
  import { messages } from '../../../mixins/messages'

  export default {
    name: "EditGroup",
    mixins: [messages],
    props: ["id"],
    data() {
      return {
        group: {
          id: null,
          name: '',
          team_id: null,
        },
        options_team:[],
        title: "Edit Group",
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      goback () {
        this.$router.go(-1)
      },
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get('/groups/'+this.id).then((response) => {
          loadingComponent.close()
          this.group = response.data.data
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.put('/groups/'+this.id, {
          group: this.group
        }).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/groups")
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      validateBeforeSubmit() {
        this.submitData();
        // this.$validator.validateAll().then((result) => {
        //   if (result) {
        //     this.submitData();
        //     return;
        //   }
        //   // const errorBag = validator.errors;
        //   console.log('Correct them errors!');
        //   this.isLoading = this.isFinished = this.isDone = false
        //   return false;
        // });
      }
    }
  };
</script>
