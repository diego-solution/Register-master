<template lang="html">
  <div>
    <b-field grouped>
      <b-field label="First Name" expanded>
        <b-input placeholder="John" v-model="user.first_name" required></b-input>
      </b-field>
      <b-field label="Last Name" expanded>
        <b-input placeholder="Doe" v-model="user.last_name" required></b-input>
      </b-field>
    </b-field>
    <b-field label="Email">
      <b-input placeholder="Email" v-model="user.email" type="email" required></b-input>
    </b-field>
    <b-checkbox v-model="team_membership.admin">Team Manager</b-checkbox>
  </div>
</template>

<script>
export default {
  props: {
    user: {type: Object},
    team_membership: { type: Object}
  },
}
</script>
