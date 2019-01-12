import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'

Vue.use(Router)

// we need the auth lib
import Auth from '../backend/auth'

// Style Guide
import StyleGuide from '../views/manage/style-guide'

// Frontend Stuff
import Registration from '../views/register/registration'
import EventNotFound from '../views/register/event-not-found'
import NotFound from '../views/info/not-found'
import ConfirmRegistration from '../views/register/confirmation'
import EventsList from '../views/register/events-list'

import Login from '../views/session/login'

// Manager
import Manage from '../views/manage/manage'

import ShowReport from '../views/manage/reports/show'
import ListEvents from '../views/manage/events/index'
import NewEvent from '../views/manage/events/new'
import EditEvent from '../views/manage/events/edit'

import ChooseLayout from '../views/manage/contents/choose-layout'
import NewPageContent from '../views/manage/contents/new'
import EditPageContent from '../views/manage/contents/edit'

import ManageForms from '../views/manage/forms/index'
import ManageEditForm from '../views/manage/forms/edit'
import ManageCreateForm from '../views/manage/forms/new'


import ManageTeams from '../views/manage/teams/index'
import ManageEditTeam from '../views/manage/teams/edit'
import ManageCreateTeam from '../views/manage/teams/new'

import ManageUsers from '../views/manage/users/index'
import ManageCreateUser from '../views/manage/users/new'
import ManageEditUser from '../views/manage/users/edit'

import ManageGroups from '../views/manage/groups/index'
import ManageCreateGroup from '../views/manage/groups/new'
import ManageEditGroup from '../views/manage/groups/edit'

import EditAccount from '../views/manage/account/edit'

import ManageLayouts from '../views/manage/layouts/index'
import ManageCreateLayout from '../views/manage/layouts/new'
import ManageEditLayout from '../views/manage/layouts/edit'

import ManageEditTranslation from '../views/manage/translations/edit'
import ManageLanguages from '../views/manage/translations/index'

// check if route needs auth
function requireAuth (to, from, next) {
  if (!Auth.loggedIn()) {
    console.log("Not logged in");
    next({
      path: '/login',
      query: { redirect: to.fullPath }
    })
  } else {
    console.log("Logged in");
    next()
  }
}

export default new Router({
  //mode: 'history',
  // mode: 'history',
  routes: [
    {
      path: '/manage', component: Manage, beforeEnter: requireAuth,
      children: [
        { path: '', redirect: "events" },
        { path: 'events', name: "listEvents",component: ListEvents },
        { path: 'events/report/:id', name: "showReport", component: ShowReport,  meta: { fullPage: true }, props: true },
        { path: 'events/filter/:name', name:"filterEvents", component: ListEvents, props: true },
        { path: 'events/new', component: NewEvent },
        { path: 'events/edit/:id', name: "editEvent", component: EditEvent, props: true },

        { path: 'events/:eventId/choose-layout', name: "chooseEventLayout", component: ChooseLayout, meta: { fullPage: true }, props:true },
        { path: 'events/:eventId/contents/new/:pageLayoutId', name: "NewPageContent", component: NewPageContent, props: true },
        { path: 'events/:eventId/contents/edit/:id', name: "EditPageContent", component: EditPageContent, props: true },

        // forms
        { path: 'forms', component: ManageForms },
        { path: 'forms/new', component: ManageCreateForm },
        { path: 'forms/edit/:id', name: "editForm", component: ManageEditForm, props: true },
        // teams
        { path: 'teams', component: ManageTeams },
        { path: 'teams/new', component: ManageCreateTeam },
        { path: 'teams/edit/:id', name: "editTeam", component: ManageEditTeam, props: true },
        // translations
        { path: 'translations', component: ManageLanguages },
        { path: 'translations/edit/:id', name: "editTranslation", component: ManageEditTranslation, props: true },
        // groups
        { path: 'groups', component: ManageGroups },
        { path: 'groups/new', component: ManageCreateGroup  },
        { path: 'groups/edit/:id', name: "editGroup", component: ManageEditGroup, props: true },
        // users
        { path: 'users', component: ManageUsers },
        { path: 'users/new', component: ManageCreateUser  },
        { path: 'users/edit/:id', name: "editUser", component: ManageEditUser, props: true },
        // manage your account
        { path: 'account', component: EditAccount },
        // manage layouts
        { path: 'layouts', component: ManageLayouts },
        { path: 'layouts/new', component: ManageCreateLayout},
        { path: 'layouts/edit/:id', name: "editLayout", component: ManageEditLayout, props: true },
        // style guide
        { path: 'style-guide', component: StyleGuide, meta: { fullPage: true }, props:true },
      ]
    },
    { path: '/', redirect: "login" },
    { path: '/event-not-found', component: EventNotFound },
    { path: '/events-list', component: EventsList },
    { path: '/confirmation/:id/:token/:action', component: ConfirmRegistration, meta: { fullPage: true }, props: true },
    { path: '/login', name:"login", component: Login },
    { path: '/logout',
      beforeEnter (to, from, next) {
        Auth.logout()
        next('/')
      }
    },
    {
      path: '/:token/:id',
      name: 'registration',
      component: Registration,
      // meta: { fullPage: true },
      props: true
    },
    { path: '/404', component: NotFound },
    { path: '*', redirect: '/404' },
  ]
})
