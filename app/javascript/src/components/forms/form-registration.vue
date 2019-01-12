<template>
  <div class="ignore-me-registration-form">
    <transition class="fade">
      <form class="m-form" method="post" @submit.prevent="onValidateRegistrationInformation"  v-show="!isFinished">
        <h3 class="m-form__title">{{ this.formTitle }}</h3>

        <!-- start questions -->
        <QuestionList :questions="questions" 
                      @updated-answers="updateAnswers"
                      v-if="questions.length>0">
        </QuestionList>
        <!-- end questions -->
        <b-field class="is-grouped m-form_submit">
          <button class="button is-black">{{ this.formButton }}</button>
        </b-field>
      </form>
    </transition>
  </div>
</template>

<script>
  import { messages } from '../../mixins/messages'
  import { Validator } from 'vee-validate'
  import QuestionList from '../questions/question-list'

  export default {
    mixins: [messages],
    components: {QuestionList},
    props: {
      questions: { type: Array, required: true },
      eventId: { type: String, required: true},
      token: { type: String, required: false},
      successMsg: { type: String, required: true},
      formTitle: { type: String, required: true},
      formButton: { type: String, required: true}
    },
    data() {
      return {
        isFinished: false,
        answers: []
      }
    },
    methods:{
      updateAnswers: function(updatedAnswers){
        this.answers = updatedAnswers
      },
      onSubmitRegistration: function(){
        const loadingComponent = this.$loading.open()
        this.$http.post('/events/' + this.eventId + "/registrants",{
          token: this.token,
          registrant:{ serialized_answers: this.answers }
        }).then((response) => {
          loadingComponent.close()
          this.isFinished = true
          this.displaySuccessMessage({ data:{ message: this.successMsg }})
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      onValidateRegistrationInformation(){
        this.$validator.validate().then(result => {
          // this is not validating....
          if (result) {
            this.onSubmitRegistration()
            return;
          }
          const errorBag = validator.errors
          return false;
        });
      }
    }
  }
</script>
