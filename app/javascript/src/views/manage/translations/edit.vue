<template>
  <div>
    <navigation-title :title="title" subtitle="Edit static content used in your event pages">
      <button class="button is-link" @click="validateBeforeSubmit">Save</button>
    </navigation-title>

    <div class="a-margin-top"></div>

    <form-widget title="Translations" subtitle="Mandatory information" v-if="translations">
      <b-tabs v-model="activeTab">
        <b-tab-item :label="key" v-for="(grouped, key) in translations" :key="grouped.key">
          <div v-for="translation in grouped" :key="translation.key">
            <h5>{{translation.key}}</h5>
            <b-field grouped>
              <b-field label="Original" expanded>
                <b-input placeholder="Key" disabled   :value="translationByKey(translation.key)"></b-input>
              </b-field>
              <b-field label="Translation" expanded>
                <b-input placeholder="Translation for language"  v-model="translation.text"></b-input>
              </b-field>
            </b-field>
          </div>
        </b-tab-item>
      </b-tabs>
    </form-widget>
  </div>
</template>


<script>
  import Auth from '../../../backend/auth'
  import { messages } from '../../../mixins/messages'

  export default {
    name: "EditTranslations",
    mixins: [messages],
    // components:{
    // },
    props: ['id'],
    data() {
      return {
        language: Object,
        translations: [],
        originalTranslations: [],
        activeTab: 0,
        title: "Edit Translations"
      };
    },
    created(){
      this.fetchData();
    },
    methods: {
      fetchTranslations(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/translations/?language_id="+this.id+'&team_id='+Auth.currentUser().team).then((response) => {
          this.translations = response.data.data
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      fetchLanguage(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/languages/"+this.id).then((response) => {
          this.language = response.data.data
          this.title = this.title + " for "+ this.language.english_name
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      fetchOriginalTranslations(){
        const loadingComponent = this.$loading.open()
        this.$http.get("/translations/original").then((response) => {
          this.originalTranslations = response.data.data
          loadingComponent.close()
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      fetchData(){
        this.fetchLanguage()
        this.fetchTranslations()
        this.fetchOriginalTranslations()
      },
      submitData(){
        const loadingComponent = this.$loading.open()
        this.$http.post("/translations/", {
          translations: this.filteredTranslations,
          team_id: Auth.currentUser().team,
          language_id: this.id
        }).then((response) => {
          loadingComponent.close()
          this.$router.push("/manage/translations")
        }, (error) => {
          loadingComponent.close()
          this.displayErrorMessage(error);
        })
      },
      validateBeforeSubmit() {
        this.submitData();
        return;
      },
      translationByKey(key){
        var result = this.originalTranslations.filter(function (original) { 
          return original.key == key
        })
        if(result == undefined)
          return "missing "+key
        return result[0].text
      }
    },
    computed:{
      filteredTranslations(){
        var contents = [];
        var namespaces = ["Confirmation", "Share", "Messages", "Registration"]
        var temp1 = this.translations
        for (var group_name of namespaces) {
          for (var translation of temp1[group_name]) {
            contents.push({key: translation.key, namespace: translation.namespace, text: translation.text})
          }
        }
        return contents;
      }
    }
  };
</script>
