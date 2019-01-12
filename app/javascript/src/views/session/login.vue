<template>
  <section>
    <div class="container">
      <div class="columns">
        <div class="column is-6 is-offset-3 t-login">
          <img src="~images/ef.png" width=35 alt="Eventfuel">
          <h2>Login</h2>
          <p v-if="$route.query.redirect">
            You need to login first.
          </p>
          <form class="m-form" @submit.prevent="login" autocomplete="off">
            <b-field label="Email">
              <b-input type="email" name="email" v-model="email" placeholder="Email" value="" required></b-input>
            </b-field>
            <b-field label="Password">
              <b-input type="password" name="password" v-model="pass" placeholder="Password" value="" password-reveal></b-input>
            </b-field>
            <b-field v-if="error" type="is-danger" message="Bad login information"></b-field>
            <button type="submit" class="button is-black">login</button>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import auth from '../../backend/auth'
export default {
  data () {
    return {
      email: '',
      pass: '',
      error: false
    }
  },
  methods: {
    login () {
      auth.login(this.email, this.pass, loggedIn => {
        if (!loggedIn) {
          this.error = true
        } else {
          this.$router.push(this.$route.query.redirect || '/manage')
        }
      })
    }
  }
}
</script>
