<template>
  <div class="o-option" v-show="option._destroy!='1'">
    <div class="o-option__form">
      <b-field grouped>
        <b-field label="Text" expanded>
          <b-input v-model="option.option"></b-input>
        </b-field>
        <b-field label="Value" expanded>
          <b-input v-model="option.value"></b-input>
        </b-field>
      </b-field>
    </div>
    <div class="o-option__actions">
      <a class="button a-button-image is-small sub" @click="onRemoveOption" v-if="option.position > 1"></a>
      <a class="button a-button-image is-small add" @click="onAddOption"></a>
    </div>
  </div>
</template>

<script>
export default {
  // inject: ['$validator'],
  name: "RegistrationOption",
  props: {
    option: { type: Object },
  },
  data() {
    return {
    }
  },
  methods:{
    // build a answers array with the same number of questions, populate with ids
    onAddOption: function(){
      console.log("adding")
      var newOption = {"id":null,
                       "position": this.option.position+1, 
                       "option": "",
                       "value":"",
                       "_destroy": null
                      }
      this.$emit('add-option', newOption)
    },
    onRemoveOption: function(){
      console.log("removing")
      this.option._destroy = "1"
      this.$emit('remove-option', this.option)
    }
  }
}
</script>