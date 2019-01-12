<template>
  <div class="">
    <navigation-title title="Edit Team">
    </navigation-title>

    <div class="a-margin-top"></div>

    <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
      <form-widget>
        <b-field label="Name">
          <b-input v-model="team.name" name="name" placeholder="Name"></b-input>
        </b-field>
        <b-field class="is-grouped m-form_submit">
          <button-submit color="is-black">Save</button-submit>
          <a-button color="is-text" href="/manage/teams">Cancel</a-button>
        </b-field>
      </form-widget>
    </form>
  </div>
</template>

<script>
  import { messages } from '../../../mixins/messages'

  export default {
    name: "EditTeam",
    mixins: [messages],
    props: ["id"],
    data() {
      return {
        team: {
          id: null,
          name: ''
        },
        title: "Edit Team",
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      fetchData(){
        const loadingComponent = this.$loading.open()
        this.$http.get('/teams/'+this.id).then((response) => {
          loadingComponent.close()
          this.team = response.data.data
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.put('/teams/'+this.id, {
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
