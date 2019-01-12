<template>
  <div class="page--events-list">
    <div class="container t-secondary-page">
      <div class="row">
        <h3>The company “bla” upcoming events</h3>
        <p>Um subitulo introdutório para esta página.</p>
      </div>
      <div class="o-events-list">
        <div class="o-white-container m-event-list">
          <div class="columns">
            <div class="column is-1 m-event-list_date">
              <h2>9</h2>
              <h6>jun</h6>
            </div>
            <div class="column is-6 m-event-list__info">
              <h3>A very very long event title for something really really big</h3>
              <h6>Location</h6>
              <div class="m-event-list__info-text">
                <p class="small">Lorem ipsum lorem something Lorem ipsum lorem something big. Lorem ipsum lorem something Lorem ipsum lorem something bigLorem ip. Lorem ipsum lorem something Lorem ipsum loreeeem something big. Lorem ipsum lorem something Lorem ipsum loreeeem something bigLorem ip.</p>
              </div>
              <a href="#" class="button is-black is-small is-outlined">see event</a>
            </div>
            <div class="column is-5 m-event-list__image">
              <img src="~images/image.png" alt="image">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'EventsList',
  data: function() {
    return  {
    }
  }
}
</script>
