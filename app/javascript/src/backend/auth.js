import axios from './vue-axios'
// import JwtDecode from 'jwt-decode'
import User from '../models/user'
import Cookies from 'js-cookie'

export default {
  login (email, pass, cb) {
    cb = arguments[arguments.length - 1]
    return axios.post('/authentication', {
      email: email,
      password: pass
    }).then(response => {
      if (response.status === 200) {
        // console.log("Storing Token:")
        //console.log(response.data.data.token);
        // localStorage.token = response.data.data.token
        this.saveToken(response.data.data.token);
        //console.log(this.getToken())
        if (cb) cb(true)
        this.onChange(true)
      }
    }).catch(error => {
      // console.log("error authenticating");
      // console.error(error.message)
      if (cb) cb(false)
      this.onChange(false)
    })
  },
  getToken () {
    // return localStorage.token
    return Cookies.get('ev-token')
  },
  currentUser(){
    try {
      return User.create(this.getToken())
    } catch (e) {
      console.log("error fetching current user");
      return null
    }
  },
  changeTeamContext(team_id){
    return axios.put('/authentication/change_team_context', {
      team_id: team_id
    })
  },
  saveToken(token){
    if (process.env.NODE_ENV != "development") {
      Cookies.set('ev-token', token, {
        domain: "eventacc.es", secure: true
      })
    }else{
      Cookies.set('ev-token', token)
    }
  },
  logout (cb) {
    // TODO should we make a call and delete the token from DB?
    // return authClient.signOut()
    //delete localStorage.token
    Cookies.remove('ev-token')

    if (cb) cb()
    this.onChange(false)
    return true
  },
  loggedIn () {
    return !!this.getToken()
  },
  onChange () {
  }
}
