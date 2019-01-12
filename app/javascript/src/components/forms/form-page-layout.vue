<template lang="html">
  <div>
    <form-widget subtitle="Mandatory information">
      <b-field label="Name" v-show="!hideName">
        <b-input v-model="template.name"></b-input>
      </b-field>

      <b-field label="Hide sidebar">
        <b-switch v-model="template.disable_sidebar">
          {{ template.disable_sidebar }}
        </b-switch>
      </b-field>
    </form-widget>

    <h5>Dynamic Preview</h5>
    <br>
    <div class="page--register editable-full">
      <registration-layout :disable-sidebar="template.disable_sidebar" :editable="true">
        <div slot="header" v-html="template.header"></div>
        <div slot="sidebar" v-html="template.sidebar"></div>
        <div v-html="template.body"></div>

        <modal-edit-layout
          slot="edit-header"
          title="Header"
          :text="template.header"
          @interface="template.header = $event">
          Edit Header
        </modal-edit-layout>
        <modal-edit-layout
          slot="edit-sidebar"
          title="Sidebar"
          :text="template.sidebar"
          @interface="template.sidebar = $event">
          Edit Sidebar
        </modal-edit-layout>

        <modal-edit-layout
          slot="edit-full-body"
          title="Body (full-page layout)"
          :text="template.body"
          @interface="template.body = $event">
          Edit Body
        </modal-edit-layout>
        <modal-edit-layout
          slot="edit-body"
          title="Body"
          :text="template.body"
          @interface="template.body = $event">
          Edit Body
        </modal-edit-layout>
      </registration-layout>

      <section class="form">
        <div class="container">
          <div class="columns">
            <div class="column is-8 is-offset-2">
              <h3 class="m-form__title">Event Registration Form</h3>
              <p>Your questions will be presented here.</p>
              <!-- <preview-registration-form></preview-registration-form> -->
            </div>
          </div>
        </div>
      </section>

      <footer-register :editable="true">
        <div v-html="template.footer"></div>
        <div slot="edit">
          <modal-edit-layout
            title="Footer"
            :text="template.footer"
            @interface="template.footer = $event">
            Edit Footer
          </modal-edit-layout>
        </div>
      </footer-register>
    </div>
  </div>
</template>

<script>
  // Advanced Use - Hook into Quill's API for Custom Functionality
  import { VueEditor, Quill } from 'vue2-editor'
  //from https://www.npmjs.com/package/quill-blot-formatter
  import BlotFormatter from 'quill-blot-formatter';
  import PreviewRegistrationForm from "./preview-registration"

  export default {
    props: {
      hideName:{
        type: Boolean,
        required: false,
        default: false
      },
      template: {
        type: Object,
        required: false,
        default: function(){
          return {
            body: "",
            disable_sidebar: false,
            footer: "",
            header: "",
            id: null,
            is_original: true,
            name: "",
            preview_image: null,
            sidebar: ""
          }
        }
      }
    },
    components: {
      VueEditor, PreviewRegistrationForm
    },
    methods: {
    },
    data() {
     return {
       customModulesForEditor: [
         { alias: 'blotFormatter', module: BlotFormatter }
       ],
       editorSettings: {
         modules: {
           blotFormatter: {}
         }
       },
       customToolbar: [
          [{ 'header': [false, 1, 2, 3, 4, 5, 6] }],
          ['bold', 'italic', 'underline', 'strike'],
          [{'align': ''}, {'align': 'center'}, {'align': 'right'}, {'align': 'justify'}],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          ['link', 'image', 'video'],
          ['clean'],
        ]
      }
    }
  }
</script>
