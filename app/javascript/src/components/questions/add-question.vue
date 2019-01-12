<!-- adds a question -->
<template>
  <div class="ignore-me-list-add-question">
    <!--    
        <b-dropdown class="m-form__type" hoverable>
          <button class="button is-link" slot="trigger">
            <span>Dropdown</span>
            <img src="~images/icons/add-white.svg" alt="add">
          </button>
          <b-dropdown-item>50%</b-dropdown-item>
          <b-dropdown-item>100%</b-dropdown-item>
        </b-dropdown>
    -->

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('section')">
        <span>Section Title</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('single')">
        <span>Textfield</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('textarea')">
        <span>Text Area</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('multiple')">
        <span>Dropdown</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('multiple_other')">
        <span>Checkboxes</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('tickbox')">
        <span>Single Checkbox</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

    <div class="m-form__type">
      <button class="button is-link" @click="onAddQuestion('email')">
        <span>E-mail TextField</span>
        <img src="~images/icons/add-white.svg" alt="add">
      </button>
    </div>

  </div>
</template>


<script>
  export default {
    name: "AddQuestion",
    data() {
      return {
      }
    },
    methods:{
      // build a answers array with the same number of questions, populate with ids
      onAddQuestion: function(type){
        var newQuestion = {
          id: null,
          help_text: null,
          kind: "single",
          placeholder: "",
          question: "Question",
          registration_options: [],
          required: false,
          width: "100%",
          position: null,
          _destroy: false
        }
        switch (type) {
          case "text":
            newQuestion.question = "Question"
            newQuestion.placeholder = ""
            newQuestion.kind = "text"
            break; 
          case "section":
            newQuestion.question = "Section Title"
            newQuestion.placeholder = ""
            newQuestion.kind = "section"
            break; 
          case "email":
            newQuestion.question = "Your E-mail"
            newQuestion.placeholder = "peter.parker@eventfuel.io"
            newQuestion.kind = "email"
            break;
          case "tickbox":
            newQuestion.question = "Accept these terms"
            newQuestion.placeholder = "Yes I accept"
            newQuestion.kind = "tickbox"
            break; 
          case "multiple":
            newQuestion.question = "Choose"
            newQuestion.placeholder = "Choose an Option"
            newQuestion.kind = "multiple"
            newQuestion.registration_options.push({"id": null,
                                                   "position": 0,
                                                   "option": "Option One",
                                                   "value": "1",
                                                   "text_value": "",
                                                   "_destroy": false
                                                  })
            newQuestion.registration_options.push({"id": null,
                                                   "position": 1,
                                                   "option": "Option Two",
                                                   "value": "2",
                                                   "text_value": "",
                                                   "_destroy": false
                                                  })
            break; 
          case "multiple_other":
            newQuestion.question = "Choose"
            newQuestion.placeholder = "Choose an Option"
            newQuestion.kind = "multiple_other"
            newQuestion.registration_options.push({"id": null,
                                                   "position": 0,
                                                   "option": "Option One",
                                                   "value": "1",
                                                   "text_value": "",
                                                   "_destroy": false                                                   
                                                  })
            newQuestion.registration_options.push({"id": null,
                                                   "position": 1,
                                                   "option": "Option Two",
                                                   "value": "2",
                                                   "text_value": "",
                                                   "_destroy": false
                                                  })
            break; 
          default:
            break;
        }

        this.$emit('add-question', newQuestion)
      }
    }
  }
</script>