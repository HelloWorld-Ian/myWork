import Vue from 'vue'
import Vuex from 'vuex'

import { createPersistedState, createSharedMutations } from 'vuex-electron'

import modules from './modules'

let state={
  dbName:'./local.db',
  login:false,

  //-1:本地用户  >0:云端用户
  user_id:-1,


  user:'HelloWorld',
  password:'',
  userCenterHeadIndex:0,
  contextUrl:'http://49.234.97.138',
  // contextUrl:'http://localhost',

  syncing:false


}

Vue.use(Vuex)

export default new Vuex.Store({
  modules,
  state,
  plugins: [
    createPersistedState(),
    createSharedMutations()
  ],
  strict: process.env.NODE_ENV !== 'production'
})
