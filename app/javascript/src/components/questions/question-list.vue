<!-- this lists all the questions for a registration form -->
<template lang="html">
  <div class="ignore-me-edit-question-list">
    <question 
      v-for="(question, index) in questions"
      :key="question.id"
      :question="question"
      @update-answer="onUpdateAnswer($event, index)">
    </question>
  </div>
</template>

<script>
  import Question from '../questions/question'
  export default {
    inject: ['$validator'],
    name: "QuestionsList",
    components: {Question},
    props: {
      questions: { default: [], type: Array}
    },
    data() {
      return {
        answers: []
      }
    },
    created () {
      this.buildAnswersObject()
    },
    methods:{
      onUpdateAnswer: function(value, index){
        if(index >= 0){
          this.answers[index]['value'] = value
        }
        this.$emit('updated-answers', this.answers)
      },
      // build a answers array with the same number of questions, populate with ids
      buildAnswersObject: function(){
        var list=[];
        if(this.questions.length == 0){
          return;
        }
        console.log("build answers");
        this.questions.map(function(question, key) {
          // console.log(question);
          var stuff = { 
            question_id: question.id, 
            question_text: question.question, 
            value: null };

          if(question.kind=="multiple_other"){
            console.log("its multiple other")
            stuff["value"]=[];
          }
          list.push(stuff);
        });
        this.answers = list;
      }
    }
  }
</script>
