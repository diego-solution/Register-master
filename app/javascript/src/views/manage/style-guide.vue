<template>
  <div class="page--style-guide">
    <div class="row">
      <h3>Style Guide</h3>
      <br><br>
    </div>
    <div class="row">
      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Colours</p>
      <p class="small">Primary Colours</p>
      <div class="columns">
        <div class="column is-1" style="height: 7vw; background-color: #0067D0; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #0A3C73; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #000000; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #3C3C3C; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #636363; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #B2B2B2; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #D9D9D9; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #F5F5F5; margin-right: 15px"></div>
      </div>
      <br>
      <p class="small">Secondary Colours</p>
      <div class="columns">
        <div class="column is-1" style="height: 7vw; background-color: #E03121; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #FFCC33; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #67D058; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #E8F8E6; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #FFF9EA; margin-right: 15px"></div>
        <div class="column is-1" style="height: 7vw; background-color: #FBE0DE; margin-right: 15px"></div>
      </div>
    </div>
    <br><br>
    <div class="row">
      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Colours</p>
      <p class="small">Primary Buttons</p>
      <div class="columns">
        <a href="#" class="button is-link" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-link is-outlined" style="margin-right: 15px">Button</a>
        <br>
        <a href="#" class="button is-black" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-black is-outlined" style="margin-right: 15px">Button</a>
        <div style="background-color: #0067D0; padding: 10px; margin-right: 15px; margin-top: -10px; border-radius: 3px;">
          <a href="#" class="button is-white">Button</a>
        </div>
        <div style="background-color: #0067D0; padding: 10px; margin-right: 15px; margin-top: -10px; border-radius: 3px;">
          <a href="#" class="button is-white is-outlined">Button</a>
        </div>
      </div>
      <br>
      <p class="small">Secondary Buttons</p>
      <div class="columns">
        <a href="#" class="button is-danger" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-danger is-outlined" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-warning" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-warning is-outlined" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-success" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-success is-outlined" style="margin-right: 15px">Button</a>
      </div>
      <br>
      <p class="small">Dropdown Buttons</p>
      <div class="columns">
        <b-dropdown class="m-form__type" style="width: 150px; margin-right: 15px" hoverable>
          <button class="button is-link" slot="trigger">
            <span>Dropdown</span>
            <img src="~images/icons/add-white.svg" alt="add">
          </button>
          <b-dropdown-item>50%</b-dropdown-item>
          <b-dropdown-item>100%</b-dropdown-item>
        </b-dropdown>
        <b-dropdown class="m-form__type" style="width: 150px; margin-right: 15px" hoverable>
          <button class="button is-link is-outlined" slot="trigger">
            <span>Dropdown</span>
            <img src="~images/icons/add.svg" alt="add">
          </button>
          <b-dropdown-item>50%</b-dropdown-item>
          <b-dropdown-item>100%</b-dropdown-item>
        </b-dropdown>
        <b-dropdown class="m-form__type" style="width: 150px; margin-right: 15px" hoverable>
          <button class="button is-link" slot="trigger">
            <span>Dropdown</span>
            <img src="~images/icons/arrow-drop-white.svg" alt="dropdown">
          </button>
          <b-dropdown-item>50%</b-dropdown-item>
          <b-dropdown-item>100%</b-dropdown-item>
        </b-dropdown>
        <b-dropdown class="m-form__type" style="width: 150px" hoverable>
          <button class="button is-link is-outlined" slot="trigger">
            <span>Dropdown</span>
            <img src="~images/icons/arrow-drop.svg" alt="dropdown">
          </button>
          <b-dropdown-item>50%</b-dropdown-item>
          <b-dropdown-item>100%</b-dropdown-item>
        </b-dropdown>
      </div>

      <br>
      <p class="small">Image Buttons</p>
      <div class="columns">
        <a href="#" class="button a-button-image back" style="margin-right: 15px"></a>
        <a href="#" class="button a-button-image drop" style="margin-right: 15px"></a>
        <a href="#" class="button a-button-image sub" style="margin-right: 15px"></a>
        <a href="#" class="button a-button-image add" style="margin-right: 15px"></a>
      </div>
      <br>
      <p class="small">Small Buttons</p>
      <div class="columns">
        <a href="#" class="button is-small is-link" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-small is-link is-outlined" style="margin-right: 15px">Button</a>
        <a href="#" class="button is-small a-button-image back" style="margin-right: 15px"></a>
      </div>
    </div>
    <br><br>
    <div class="row">
      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Messages</p>
      <button class="button is-link" style="margin-right: 10px" @click="toast">Message</button>
      <button class="button is-success" style="margin-right: 10px" @click="success">Success Message</button>
      <button class="button is-danger" style="margin-right: 10px" @click="danger">Error Message</button>
    </div>
    <br><br>
    <div class="row">
      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Tags</p>
      <b-tag type="is-info">Tag label</b-tag>
      <b-tag type="is-success">Tag label</b-tag>
      <b-tag type="is-warning">Tag label</b-tag>
      <b-tag type="is-danger">Tag label</b-tag>
      <!-- <b-tag type="is-primary">Tag label</b-tag> -->
      <b-tag type="is-black">Tag label</b-tag>
      <b-tag type="is-dark">Tag label</b-tag>
      <b-tag type="is-light">Tag label</b-tag>
      <b-tag type="is-white">Tag label</b-tag>
    </div>
    <br><br>
    <div class="row">
      <div class="columns">
        <div class="column is-12">
          <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Typography</p>
          <h1>Random Title 1</h1>
          <h2>Random Title 2</h2>
          <h3>Random Title 3</h3>
          <h4>Random Title 4</h4>
          <h5>Random Title 5</h5>
          <h6>Random Title 6</h6>
          <br>
          <p class="big">Random Paragraph Big</p>
          <p>Random Paragraph</p>
          <p class="small">Random Paragraph Small</p>
        </div>
      </div>
    </div>
    <br><br>
    <br><br>
    <div class="row">
      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Form Section Header</p>

      <navigation-title title="New Layout" subtitle="Create a new page design layout">
        <!-- <button class="button is-link is-outlined">Preview</button> -->
        <button class="button is-link">Create</button>
      </navigation-title>

      <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Form content</p>

    </div>


    <div class="row">
      <div class="columns">

        <div class="column is-12" style="background:#eee;">
          <p class="small" style="font-weight: 600; letter-spacing: 2px; text-transform: uppercase;">Step</p>

          <form-with-step
          title = "Basic Info"
          subtitle = "Mandatory Information"
          :hideToggle = "false"
          :complete = "true"
          :open = "true">

            <template slot="preview">
              <p class="small preview">Name: Pedro Sousa</p>
              <p class="small preview">Group: Admins</p>
            </template>

            <form class="m-form" method="get">

              <b-field label="Name">
                <b-input v-model="name" placeholder="Name"></b-input>
              </b-field>

              <b-field class="is-grouped m-form_submit">
                <button class="button is-black">Save</button>
                <a class="button is-text">Cancel</a>
              </b-field>

            </form>
          </form-with-step>
        </div>
      </div>
    </div>

  </div>
</template>


<script>
  export default {
    data() {
      return {
        name: ""
      }
    },
    methods: {
      toast() {
        this.$toast.open('Something happened')
      },
      success() {
        this.$toast.open({
          message: 'Something happened correctly!',
          type: 'is-success'
        })
      },
      danger() {
        this.$toast.open({
          duration: 5000,
          message: `Something's not good, also I'm on bottom`,
          type: 'is-danger'
        })
      }
    }
  }
</script>
