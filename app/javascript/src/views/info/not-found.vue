<template>
  <div class="t-template">
    <vue-headful title="The page is not found"/>

    <section>
      <div class="container m-event">
        <div class="columns">
          <div class="column is-8 is-offset-2 has-text-centered m-event__not-found">
            <img src="~/images/not-found.svg" alt="not found">
            <h1>Not found</h1>
            <p>The page you are looking for is missing.</p>
          </div>
        </div>
      </div>
      <footer-register></footer-register>
    </section>
  </div>
</template>

<script>

export default {
  name: 'NotFound',
  data() {
    return {
    }
  }
}
</script>
