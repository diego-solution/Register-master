// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue/dist/vue.esm'
import VeeValidate from 'vee-validate'
import VueTour from 'vue-tour'
import VueConfetti from 'vue-confetti'
import VueCookie from 'vue-cookie'
import Buefy from 'buefy'
import vueHeadful from 'vue-headful'
import AirbrakeClient from 'airbrake-js'
import router from '../src/backend/router'
import axios from '../src/backend/vue-axios'
import App from '../src/app.vue'

// import css
import '../stylesheets/app'

Vue.config.devtools = true
Vue.config.productionTip = false

// import external libs
Vue.use(Buefy, { defaultIconPack: 'mdi'})
Vue.use(axios)
Vue.use(VeeValidate)
Vue.use(VueTour)
Vue.use(VueConfetti)
Vue.use(VueCookie)
Vue.component('vue-headful', vueHeadful)

// import global available stuff from components
import RegisterButtons from '../src/components/buttons'
import RegisterFooters from '../src/components/footers'
import RegisterForms from '../src/components/forms'
import RegisterIcons from '../src/components/icons'
import RegisterLists from '../src/components/lists'
import RegisterModals from '../src/components/modals'
import RegisterNavigation from '../src/components/navigation'
import RegisterTables from '../src/components/tables'
import RegisterHeaders from '../src/components/headers'
import RegisterLoaders from '../src/components/loaders'

Vue.use(RegisterLoaders)
Vue.use(RegisterButtons)
Vue.use(RegisterFooters)
Vue.use(RegisterForms)
Vue.use(RegisterIcons)
Vue.use(RegisterLists)
Vue.use(RegisterModals)
Vue.use(RegisterNavigation)
Vue.use(RegisterTables)
Vue.use(RegisterHeaders)


const app = window.app
// Setup error catching
if(process.env.NODE_ENV != "development"){
  var airbrake = new AirbrakeClient({
    host: process.env.AIRBRAKE_HOST,
    projectId: 1,
    projectKey: process.env.AIRBRAKE_PROJECT_KEY
  });
  Vue.config.errorHandler = function (err, vm, info) {
    airbrake.notify({
      error: err,
      params: {info: info}
    });
  }
}
document.addEventListener('DOMContentLoaded', () => {
  /* eslint-disable no-new */
  app.vm = new Vue({
    el: '#app',
    router,
    axios,
    components: { App },
    template: '<App/>'
  })
})
