<template>
  <div>
    <navigation-title title="Edit User">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="put" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <form-user
          :user.sync="user"
          :team_membership.sync="team_membership">
        </form-user>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Save</button-submit>
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
    name: "UpdateUser",
    mixins: [messages],
    props: ["id"],
    created(){
      this.fetchData();
    },
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
        title: "Update User"
      };
    },
    methods: {
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get('/users/'+this.id).then((response) => {
          loadingComponent.close()
          this.user = response.data.data
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })

        this.$http.get('/team_memberships/'+Auth.currentUser().team+"?user_id="+this.id).then((response) => {
          loadingComponent.close()
          this.team_membership = response.data.data
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })

      },
      submitData(){
        const loadingComponent = this.$loading.open()

        this.$http.put('/team_memberships/'+Auth.currentUser().team+"?user_id="+this.id, {
          team_membership: {
            // user_id: this.team_membership.user_id,
            // id: this.team_membership.id,
            // team_id: this.team_membership.team_id,
            admin: this.team_membership.admin
          }
        }).then((response) => {
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })

        this.$http.put('/users/'+this.id, {
          user: this.user
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
