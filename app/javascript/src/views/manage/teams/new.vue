<template>
  <div class="">
    <navigation-title title="New Team" subtitle="Add new team">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <b-field label="Name">
          <b-input v-model="team.name" name="name" placeholder="Name"></b-input>
        </b-field>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Create</button-submit>
          <a-button color="is-text" href="/manage/teams">Cancel</a-button>
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
    name: "CreateTeam",
    mixins: [messages],
    data() {
      return {
        checkbox: false,
        team: {
          name: ""
        },
        title: "Create Team"
      };
    },
    methods: {
      fetchData(){

      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post('/teams', {
          team: this.team
        }).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/teams")
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      validateBeforeSubmit() {
        this.submitData();

      }
    }
  };
</script>
