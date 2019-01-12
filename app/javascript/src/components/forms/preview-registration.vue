<template>
<form class="m-form" action="#">
  <h3 class="m-form__title">Event Registation Form</h3>
  <h4 class="m-form__section-title">Form Section Title</h4>
  <div class="columns">
    <div class="column is-6">
      <b-field label="First Name">
        <b-input placeholder="First Name"></b-input>
      </b-field>
    </div>
    <div class="column is-6">
      <b-field label="Last Name">
        <b-input placeholder="Last Name"></b-input>
      </b-field>
    </div>
  </div>
  <b-field label="Email"
    type="is-danger"
    message="A small error message">
    <b-input class="is-danger" placeholder="Your Email"></b-input>
  </b-field>
  <b-field label="Company Name"
    type="is-success"
    message="This username is available">
    <b-input placeholder="Company Name"></b-input>
  </b-field>
  <h4 class="m-form__section-title">Form Section Title</h4>
  <div class="columns">
    <div class="column is-6">
      <b-field label="Job Title">
        <b-input placeholder="Job Title"></b-input>
      </b-field>
    </div>
    <div class="column is-6">
      <b-field label="Devices Owned">
        <div class="select">
          <select>
            <option>Select dropdown</option>
            <option>With options</option>
          </select>
        </div>
      </b-field>
    </div>
  </div>
  <b-field>
    <b-checkbox class="is-small">I agree to the <a href="#">terms and conditions</a></b-checkbox>
  </b-field>
  <b-field class="is-grouped m-form_submit">
    <button class="button is-black">Submit</button>
  </b-field>
</form>
</template>

<script>
  export default {
    name: "preview-registration-form"
  }
</script>
