<template>
  <div class="page--create-event">
    <navigation-title :title="pageTitle" :subtitle="pageSubtitle">
      <button class="button is-link" @click="onSaveRegistrationQuestions">Save</button>
    </navigation-title>

    <div class="columns">
      <div class="column is-4">
        <div class="u-sticky u-stick-it-top">
          <div class="o-white-container sidebar-edit-questions">
          <b-tabs v-model="activeTab">
            <b-tab-item label="Add">
              <add-question
                @add-question="addFormQuestion">
              </add-question>
            </b-tab-item>
            <b-tab-item label="Edit">
              <transition name="slide-fade" mode="out-in">
                <edit-question
                  :question="currentQuestion"
                  :key="currentQuestion.position"
                  @remove-question="removeFormQuestion">
                </edit-question>
              </transition>
            </b-tab-item>
          </b-tabs>
        </div>
        </div>
      </div>
      <div class="column is-8">
        <div class="o-white-container">
          <b-dropdown class="m-form__type" position="is-bottom-left" v-model="language" v-if="languages.length>0">
            <button class="button is-link is-outlined" slot="trigger">
              <span>{{ language.english_name }} </span>
              <img class="arrow" src="~images/icons/arrow-drop.svg" alt="choose team">
            </button>
            <b-dropdown-item v-for="option in languages"
              :value="option"
              @click="onChangeLanguage" v-bind:key="option.id">
              {{ option.english_name }}
            </b-dropdown-item>
          </b-dropdown>
          <b-tooltip label="Changing languages will not save your current content." position="is-bottom" animated>
            <small class="small help">This will change the language for this Form's translations.</small>
          </b-tooltip>
        </div>
        <div class="o-white-container">
          <div class="m-form">
            <b-field
              label="Name"
              :type="errors.has(registration_form.name) ? 'is-danger': ''"
              :message="errors.has(registration_form.name) ? errors.first(registration_form.name) : ''">
              <b-input v-model="registration_form.name" :name="registration_form.name" required></b-input>
            </b-field>
            <hr>
            <h3 class="m-form__title">Questions</h3>

            <draggable :list="questions">
              <transition-group>
                <question
                  v-for="question in questions"
                  v-show="question._destroy!='1'"
                  :key="question.question"
                  :question="question"
                  :editMode="true"
                  @set-current-question="setCurrentQuestion">
                </question>
              </transition-group>
            </draggable>
          </div>
        </div>


      </div>
    </div>
  </div>
</template>

<script>
  import Auth         from '../../../backend/auth'
  import { messages } from '../../../mixins/messages'
  import AddQuestion  from '../../../components/questions/add-question'
  import EditQuestion from '../../../components/questions/edit-question'
  import QuestionList from '../../../components/questions/question-list'
  import Question     from '../../../components/questions/question'
  import draggable from 'vuedraggable'

  export default {
    name: "EditRegistrationForm",
    mixins: [messages],
    components: {draggable, AddQuestion, EditQuestion, Question, QuestionList},
    props: ['id'],
    created(){
      this.$validator.pause()
      this.fetchData()
    },
    data() {
      return {
        registration_form: Object,
        questions: [],
        languages: [],
        language: Object,
        currentQuestion: {
          help_text: null,
          id: null,
          kind: null,
          name: null,
          placeholder: null,
          question: null,
          registration_options: [],
          required: false,
          width: "100%"
        },
        activeTab: 1
      };
    },
    computed:{
      // Rails needs the attributes named in a specific way
      registration_forms_params(){
        var questions_attributes = this.questions.slice()
        questions_attributes.forEach(function(question, i) {
          var options = question.registration_options.slice()
          options.forEach(function(option, i) { option.position = i })
          question.position = i
          question.registration_options_attributes = options
        })
        return {"id": this.registration_form.id,
                "name": this.registration_form.name,
                "registration_questions_attributes": questions_attributes }
      },
      pageTitle(){
        if(this.registration_form){
          return this.registration_form.name + ' form'
        }else{
          return "Loading"
        }
      },
      pageSubtitle(){
        if(this.language){
          return "Editing in " + this.language.english_name
        }else{
          return "Loading"
        }
      }
    },
    methods: {
      onChangeLanguage(){
        this.fetchQuestions()
        this.displaySuccessMessage({ data:{ message:"Changed to "+this.language.english_name }})
      },
      prepareData(registrationForm){
        this.registration_form = registrationForm
        if(this.registration_form.registration_questions.length>0){
          this.questions = this.registration_form.registration_questions
          this.setCurrentQuestion(this.questions[0])
        }else{
          this.activeTab = 0
        }
      },
      fetchData(){
        this.fetchLanguage()
      },
      fetchLanguages(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/languages").then((response) => {
          this.languages = response.data.data
        }, (error) => {
          this.displayErrorMessage(error);
        }).finally((response) => {
          loadingComponent.close()
          this.fetchQuestions()
        })
      },
      fetchLanguage(){
        const loadingComponent = this.$loading.open()
        var language_chosen = this.$route.query.language_id
        if(language_chosen == undefined){
          language_chosen = "en"
        }
        this.$http.get("/languages/"+language_chosen).then((response) => {
          this.language = response.data.data
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        }).finally((response) => {
          loadingComponent.close()
          this.fetchLanguages()
        })
      },
      fetchQuestions(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/registration_forms/" + this.id + '?language_id='+this.language.key+'&team_id='+Auth.currentUser().team + "&edit=true").then((response) => {
          this.prepareData(response.data.data)
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      setCurrentQuestion(question){
        this.currentQuestion = question
      },
      addFormQuestion(new_question){
        new_question.position = this.questions.length
        this.setCurrentQuestion(new_question)
        this.questions.push(new_question)
        this.activeTab = 1
      },
      removeFormQuestion(edited_question){
        this.setCurrentQuestion(this.questions[0])
      },
      onSaveRegistrationQuestions(){
        const loadingComponent = this.$loading.open()

        this.$http.put('/registration_forms/' + this.id + '?language_id='+this.language.key+'&team_id='+Auth.currentUser().team,{
          registration_form: this.registration_forms_params
        }).then((response) => {
          this.prepareData(response.data.data)
          loadingComponent.close()
          this.displaySuccessMessage(response);
        }, (server_response) => {
          loadingComponent.close()
          this.displayErrorMessage(server_response);
        })
      }
    }
  };
</script>
