<template>
  <div class="page">
    <navigation-title
      title="Account Info"
      subtitle="Change your account information">
    </navigation-title>


    <div class="t-account a-margin-top">
      <form class="m-form" action="" method="post" @submit.prevent="validateBeforeSubmit()">
        <form-widget>
          <b-tabs v-model="activeTab">
            <b-tab-item label="Account Info">
              <b-field grouped>
                <b-field label="First Name" expanded>
                  <b-input placeholder="John" v-model="account.first_name"></b-input>
                </b-field>
                <b-field label="Last Name" expanded>
                  <b-input placeholder="Doe" v-model="account.last_name"></b-input>
                </b-field>
              </b-field>
              <b-field label="Email">
                <b-input placeholder="Email" v-model="account.email" type="email"></b-input>
              </b-field>
            </b-tab-item>
            <b-tab-item label="Password">
              <b-field label="New Password">
                <b-input v-model="password" placeholder="New Password" type="password" password-reveal></b-input>
              </b-field>
              <b-field label="Confirm New Password">
                <b-input v-model="confirm_password" placeholder="Confirm New Password" type="password" password-reveal></b-input>
              </b-field>
            </b-tab-item>
          </b-tabs>

          <b-field class="is-grouped m-form_submit">
            <button class="button is-black">Save</button>
          </b-field>

        </form-widget>
      </form>

    </div>
  </div>
</template>

<script>

  import { messages } from '../../../mixins/messages'
  import axios from '../../../backend/vue-axios'
  import Auth from '../../../backend/auth'

  export default {
    name: 'EditAccount',
    mixins: [messages],
    data: function() {
      return  {
        account: Object,
        activeTab: 0,
        password: "",
        confirm_password: ""
      }
    },
    created () {
      this.fetchData()
    },
    watch: {
      '$route': 'fetchData'
    },
    methods: {
      fetchData () {
        const loadingComponent = this.$loading.open()
        axios.get('/account/current').then((response) => {
          this.account = response.data.data
          // Auth.saveToken(response.data.data.token)
          //location.reload()
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error)
        })
      },
      validateBeforeSubmit() {
        if(this.activeTab == 0){
          this.submitData();
        }else{
          this.updatePassword();
        }
        return
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        const params = this.account

        axios.put('/account/current', {
          account: params
        }).then((response) => {
          loadingComponent.close()
          this.displaySuccessMessage(response)
          location.reload()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      updatePassword(){
        const loadingComponent = this.$loading.open()
        const params = {password: this.password}

        axios.put('/account/current', {
          account: params
        }).then((response) => {
          loadingComponent.close()
          this.displaySuccessMessage(response)
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
    }


  }
</script>
