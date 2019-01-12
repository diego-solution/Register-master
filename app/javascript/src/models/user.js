/**
  A user model
**/
/* eslint-disable camelcase */
import JwtDecode from 'jwt-decode'
import axios from '../backend/vue-axios'

const basePath = Symbol('basePath')

export default class User {
  constructor ({ sub, slug, name, email, locale, time_zone, intercom_hash, team, admin, super_admin }) {
    //this.uid = id
    this.name = name
    this.email = email
    //this.locale = locale
    // this.time_zone = time_zone
    // this.intercom_hash = intercom_hash
    this.admin = admin
    this.team = team
    this.super_admin = super_admin
    if(this.admin == true){
      this.role  = "Admin"
    }else{
      this.role = "Manager"
    }
  }
  //  Creates a basic local User object from a stored token
  static create (token) {
    try {
      return new User(JwtDecode(token))
    } catch (e) {
      return null
    }
  }

  //  Send out a ping to the backend
  ping () {
    return axios.get('/users/ping')
  }

}
