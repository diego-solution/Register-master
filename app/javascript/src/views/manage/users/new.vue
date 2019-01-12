<template>
  <div class="">
    <navigation-title title="New User" subtitle="Add a user to manage events in your team">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <form-user
          :user.sync="user"
          :team_membership.sync="team_membership">
        </form-user>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Create</button-submit>
          <a-button color="is-text" href="/manage/users">Cancel</a-button>
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
    name: "CreateUser",
    mixins: [messages],
    data() {
      return {
        checkbox: false,
        user: {
          first_name: "",
          last_name: "",
          email: ""
        },
        team_membership: {
          team_id: Auth.currentUser().team,
          admin: false,
          team: null
        },
        title: "Create User"
      };
    },
    methods: {
      fetchData(){
        // const loadingComponent = this.$loading.open()
        // axios.get('/users/'+this.'/team_membership'+this.id).then((response) => {
        //   loadingComponent.close()
        //   this.group = response.data.data
        // }, (error) => {
        //   loadingComponent.close()
        //   this.displayErrorMessage(error);
        // })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post('/users', {
          user: this.user,
          team_membership: {
            team_id: this.team_membership.team_id,
            admin: this.team_membership.admin
          }
        }).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/users")
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
