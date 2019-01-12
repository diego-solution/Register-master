<template>
  <form @submit.prevent="onRemoveQuestion" class="ignore-me-edit-question">
    <b-field label="Label">
      <b-input placeholder="Label / Question" name="question" v-model="editedQuestion.question" v-validate="'required'"></b-input>
    </b-field>
    <b-field label="Placeholder (optional)" v-if="editedQuestion.kind!='section'">
      <b-input placeholder="Placeholder" v-model="editedQuestion.placeholder"></b-input>
    </b-field>
    <!--
    <b-field label="Help Text (optional)">
      <b-input placeholder="Descrition"  v-model="editedQuestion.help_text"></b-input>
    </b-field>
    -->
    <div class="field">
      <b-switch size="is-small" v-model="editedQuestion.required">Required</b-switch>
    </div>
    <Option v-for="(reg_option, index) in editedQuestion.registration_options"
      :option.sync="reg_option"
      :key="reg_option.id"
      @add-option="onAddOption($event, index)"
      @remove-option="onRemoveOption($event, index)">
    </Option>
    <p>
      <br>
      <button class="button is-danger is-small" v-if="editedQuestion.kind!='email'">Remove</button>
    </p>
   
  </form>
</template>

<script>
  import { Validator } from 'vee-validate'
  import Option from '../questions/option'

  export default {
    name: "EditQuestion",
    components: { Option },
    props: {
      //question: Object
      question: {
        type: Object,
        default: function () { 
          return {
          help_text: null,
          id: null,
          kind: null,
          name: null,
          placeholder: null,
          question: null,
          _destroy: null,
          registration_options: [],
          required: false,
          width: "100%"
          }
        }
      }
    },
    watch: { 
      // if prop changed (someone picked another question), update this
      question: function(newVal, oldVal) {        
        this.editedQuestion =  newVal //;JSON.parse(JSON.stringify(newVal))
      }
    },
    data: function () {
      return {
        editedQuestion: this.question
      }
    },
    methods: {      
      onRemoveQuestion: function(){
        this.editedQuestion._destroy="1"
        this.$emit('remove-question', this.editedQuestion)
      },
      onAddOption: function(edited_option, index){
        console.log("adding a option "+ index)
        this.editedQuestion.registration_options.splice(index+1, 0, edited_option)
      },
      onRemoveOption: function(edited_option, index){
        console.log("removing a option "+ index)
        edited_option._destroy = "1"
      },
    },
  }
</script>


            