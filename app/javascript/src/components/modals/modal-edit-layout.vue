<template>
  <div>
    <button class="button a-margin-top a-margin-bottom is-link is-outlined" @click="openEditorModal">
      <slot></slot>
    </button>

    <b-modal
      :active.sync="isComponentModalActive"
      :width="960" scroll="keep">
      <div class="modal-card modal-editor" style="width: auto">
        <header class="modal-card-head">
          <p class="modal-card-title">{{ title }}</p>
        </header>
        <section class="modal-card-body">
          <vue-editor
           id="modal-editor"
           v-model="htmlForEditor"
           :customModules="customModulesForEditor"
           :editorOptions="editorSettings"
           :editorToolbar="customToolbar">
          </vue-editor>

          <br>
          <p><small>Use these tags in the editor to show data from your event in the layout:</small></p>
          <b-taglist>
            <b-tag rounded v-for="tagName in eventTags" v-bind:key="tagName">
              {{ tagName }}
            </b-tag>
          </b-taglist>
        </section>
        <footer class="modal-card-foot">
          <button class="button is-primary" @click="handleDataFromEditor">Save</button>
        </footer>
      </div>
    </b-modal>
  </div>
</template>

<script>
// Advanced Use - Hook into Quill's API for Custom Functionality
import { VueEditor, Quill } from 'vue2-editor'
//from https://www.npmjs.com/package/quill-blot-formatter
import BlotFormatter from 'quill-blot-formatter'


export default {
  props: ["text", "title"],
  components: {
    VueEditor
  },
  methods:{
    openEditorModal: function () {
      // Copy prop to local variable
      this.htmlForEditor = this.text
      // open modal
      this.isComponentModalActive = true
    },
    handleDataFromEditor: function () {
      // handle data and give it back to parent by interface
      this.$emit('interface', this.htmlForEditor)
      this.isComponentModalActive = false
    },
  },
  data() {
    return {
      eventTags: [
        "{{event.name}}", 
        "{{event.description}}", 
        "{{event.location}}",
        "{{event.city}}",
        "{{event.registration_start_date}}",
        "{{event.registration_close_date}}",
        "{{event.start_date}}",
        "{{event.end_date}}",
        "{{event.start_time}}",
        "{{event.end_time}}"
      ],
      htmlForEditor: this.text,
      isComponentModalActive: false,
      customModulesForEditor: [
        { alias: 'blotFormatter', module: BlotFormatter },
      ],
      editorSettings: {
        formats: ['header','align','bold','underline','italic','color','strike','link','list','blockquote','image','indent'],
        modules: {
          blotFormatter: {},
          clipboard: {
            matchVisual: false
          }
        }
      },
      customToolbar: [
         [{ 'header': [false, 1, 2, 3, 4, 5, 6] }],
         ['bold', 'italic', 'underline', 'strike'],
         [{'align': ''}, {'align': 'center'}, {'align': 'right'}, {'align': 'justify'}],
         [{ 'list': 'ordered'}, { 'list': 'bullet' }],
         [{ 'color': [] }],
         ['link', 'image'],
         ['clean'],
       ]
    }
  }
}
</script>
