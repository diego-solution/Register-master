/**
Mixin to implement translations for events
**/

import russian from 'vee-validate/dist/locale/ru'
import english from 'vee-validate/dist/locale/en'
import spanish from 'vee-validate/dist/locale/es'
import german from 'vee-validate/dist/locale/de'
import french from 'vee-validate/dist/locale/fr'
import italian from 'vee-validate/dist/locale/it'
import dutch from 'vee-validate/dist/locale/nl'
import polish from 'vee-validate/dist/locale/pl'
import portuguese from 'vee-validate/dist/locale/pt_PT'

export const translate = {
  created: function () {
    // set default locale for vee-validate
    this.$validator.localize('en')
    // this.hello()
  },
  data() {
    return {
      translations: {
        // "confirmation.button.confirm": "Confirm",
        // "confirmation.button.decline": "Decline",
        // "registration.error.message": "There was a unexpected error while processing your information. Please try again.",
        // "registration.error.missing_information": "Please review the registration form.",
        // "registration.error.title": "We couldn't submit your registration",
        // "registration.form.button": "Submit"
      }
    }
  },
  methods: {
    hello: function () {
      console.log('loaded translations mixin!')
    },
    loadTranslations: function (translations_obj) {
      this.translations = translations_obj
    },
    t: function (key) {
      return this.translations[key]
    },
    setLocale: function(locale){
      // needs more work....
      if(locale == "ru"){
        this.$validator.localize('ru', {
          messages: russian.messages
        })
      }else if (locale == "es") {
        this.$validator.localize('es', {
          messages: spanish.messages
        })
      }else if (locale == "pt") {
        this.$validator.localize('pt', {
          messages: portuguese.messages
        })
      }else if (locale == "fr") {
        this.$validator.localize('fr', {
          messages: french.messages
        })
      }else if (locale == "de") {
        this.$validator.localize('de', {
          messages: german.messages
        })
      }else if (locale == "it") {
        this.$validator.localize('it', {
          messages: italian.messages
        })
      }else if (locale == "nl") {
        this.$validator.localize('nl', {
          messages: dutch.messages
        })
      }else if (locale == "pl") {
        this.$validator.localize('pl', {
          messages: polish.messages
        })
      }else{
        this.$validator.localize('en', {
          messages: english.messages
        })
      }
    }
  }
}
