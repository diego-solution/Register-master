<template>
  <div class="t-template">
    <vue-headful title="Event not found"/>

    <section>
      <div class="container m-event">
        <div class="columns">
          <div class="column is-8 is-offset-2 has-text-centered m-event__not-found">
            <img src="~/images/not-found.svg" alt="">
            <h1>Event not found</h1>
            <p>I'm sorry, the event you are looking for doesn't exist or has expired.</p>
          </div>
        </div>
      </div>
      <footer-register></footer-register>
    </section>
  </div>
</template>

<script>

export default {
  name: 'EventNotFound',
  data() {
    return {
    }
  }
}
</script>
