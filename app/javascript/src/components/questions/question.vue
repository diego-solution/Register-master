<template>
  <b-field
    @click.native="onEditQuestion"
    :class="{ edited: editMode }"
    :label="question.question"
    :key="question.question"
    :type="errors.has(question.question) ? 'is-danger': ''" 
    :message="errors.has(question.question) ? errors.first(question.question) : ''"
    >
    <b-input v-if="question.kind === 'single'"
      v-validate="question.required ? 'required': ''"
      v-model="answer"
      :name="question.question"
      :placeholder="question.placeholder"
      @input="onUpdate">
    </b-input>
    <b-input v-else-if="question.kind === 'text'"
      :name="question.question"
      v-validate="question.required ? 'required': ''"
      v-model="answer"
      @input="onUpdate"
      type="textarea"
      :placeholder="question.placeholder">
    </b-input>
    <b-input v-else-if="question.kind === 'email'"
      type="email"
      @input="onUpdate"
      v-validate="'required|email'"
      :name="question.question"
      :placeholder="question.placeholder"
      v-model="answer">
    </b-input>
     
    <div class="control" v-else-if="question.kind === 'single_other'">
      <div class="option" v-for="option in question.registration_options" 
        v-show="option._destroy!='1'"
        :key="option.option">
        <b-radio
          @input="onUpdate"
          :name="question.question"
          v-validate="question.required ? 'required': ''"
          v-model="answer"
          :native-value="option.value">
          {{ option.option }}
        </b-radio>
      </div>
    </div>
    <div class="block" v-else-if="question.kind === 'multiple_other'">
      <div class="option" v-for="option in question.registration_options" 
        v-show="option._destroy!='1'"
        :key="option.option">
        <b-checkbox
          @input="onUpdate"
          v-model="answer"
          :name="question.question"
          :native-value="option.value">
          {{ option.option }}
        </b-checkbox>
      </div>
    </div>
    <b-select v-else-if="question.kind === 'multiple'"
      @input="onUpdate"
      :name="question.question"
      :placeholder="question.placeholder"
      required="question.required ? 'required': ''"
      v-model="answer">
        <option v-for="option in question.registration_options"
          v-show="option._destroy!='1'"
          :value="option.value"
          :key="option.option">
          {{ option.option }}
        </option>
    </b-select>
    <b-checkbox v-else-if="question.kind === 'tickbox'"
      @input="onUpdate"
      class="is-small"
      :key="question.question"
      :name="question.question"
      v-model="answer">
      {{question.placeholder}}
    </b-checkbox>   
  </b-field>
</template>

<script>
export default {
  inject: ['$validator'],
  name: "RegistrationQuestion",
  props: {
    question: { type: Object },
    editMode: { default: false, required: false }
  },
  data() {
    return {
      answer: null,
      currentEdit: false
    }
  },
  created(){
    //FIX
    if(this.question != undefined && this.question.kind == "multiple_other"){
      this.answer=[]
    }
  },
  methods:{
    // build a answers array with the same number of questions, populate with ids
    onUpdate: function(val){
      // console.log(this.answer)
      this.$emit('update-answer', this.answer) 
    },
    onEditQuestion: function(event){
      if(this.editMode == false)
        return     
      // this.currentEdit = true
      this.$emit('set-current-question', this.question)   
    },
    onLeaveEditQuestion: function(event){
      console.log("leave edit "+this.question.id);
      if(this.editMode == false)
        return
      this.currentEdit = false
    }
  }
}
</script>