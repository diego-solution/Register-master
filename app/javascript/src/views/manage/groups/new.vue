<template>
  <div class="">
    <navigation-title title="New Group" subtitle="Add a group that represents a set of events">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <b-field label="Name">
          <b-input v-model="group.name" name="name" placeholder="Name"></b-input>
        </b-field>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Create</button-submit>
          <a-button color="is-text" href="/manage/groups">Cancel</a-button>
        </b-field>
      </form-widget>
    </form>
  </div>
</template>

<script>
  // import { Validator } from 'vee-validate';
  import { messages } from '../../../mixins/messages'
  import Auth from '../../../backend/auth'

  export default {
    name: "CreateGroup",
    mixins: [messages],
    data() {
      return {
        group: {
          name: '',
          team_id: Auth.currentUser().team,
        },
        options_team:[],
        title: "Create Group"
      };
    },
    methods: {
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post('/groups', {
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
