<template lang="html">
  <form action="" @submit.prevent="validateForm()">
    <div class="modal-card" style="width: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">Send Referral Link</p>
      </header>
      <section class="modal-card-body">
        <b-field label="Name">
          <b-input
          type="text"
          v-model="name"
          name="name"
          placeholder="Name of the referrer"
          required>
        </b-input>
      </b-field>

      <b-field label="Email">
        <b-input
        type="email"
        v-model="email"
        email="email"
        placeholder="E-mail for the referrer"
        required>
      </b-input>
    </b-field>
  </section>
  <footer class="modal-card-foot">
    <button class="button is-primary">Send</button>
  </footer>
</div>
</form>
</template>

<script>

import { messages } from '../../mixins/messages'

export default {
  name: "NewReferralForm",
  props: ['event_id'],
  mixins: [messages],
  data() {
    return {
      email: "",
      name: ""
    }
  },
  methods:{
    validateForm() {
      // alert("submitted!")
      // $parent.close()
      var params = {name: this.name, email: this.email}
      const loadingComponent = this.$loading.open()
      var that = this.$parent
      this.$http.post("/events/"+this.event_id+"/referrers",{
        referrer: params
      }).then((response) => {
        that.close()
        loadingComponent.close()
        this.displaySuccessMessage(response)
      }, (server_response) => {
        loadingComponent.close()
        this.displayErrorMessage(server_response);
      })

    },
  }
}
</script>
