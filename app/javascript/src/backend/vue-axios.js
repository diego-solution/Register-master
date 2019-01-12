// Configure axios
import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'
import { shim } from "promise.prototype.finally";
shim()
import Cookies from 'js-cookie'

const API_BASE_URL = '/api/v1'
let token = document.getElementsByName('csrf-token')[0].getAttribute('content')

const defaultOptions = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    'Accept-Version': 'v1',
    'X-CSRF-Token': token,
    //'Accept': 'application/json'
  }
})

// Set the AUTH token for any request
defaultOptions.interceptors.request.use(function (config) {
  let authToken = Cookies.get('ev-token');
  // console.log("Setting interceptor cookie!");
  config.headers.Authorization = authToken ? `Bearer ${authToken}` : '';
  return config;
})

Vue.use(VueAxios, defaultOptions)
export default defaultOptions
