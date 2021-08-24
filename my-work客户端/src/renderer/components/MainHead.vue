<template>
  <div class="header">
    <h3 class='h3'>MyWork</h3>
    <div class="rightBox">
      <img @click="closeWindow" class="icon rightIcon" style="width:30px;height:30px;float:right" src="../assets/close.svg" />
      <img @click="fullWindow" class="icon rightIcon" style="width:20px;height:30px;float:right;margin-right:0.5%" src="../assets/full.svg" />
      <img @click="hideWindow" class="icon rightIcon" style="width:20px;height:30px;float:right;margin-right:1%" src="../assets/min.svg" />
      
      
      <el-popover
         placement="bottom-end"
         :title="userType"
         width="200"
         trigger="hover">
      <img class="icon rightIcon" slot="reference" style="width:25px;height:25px;float:right;margin-top:0.2%;margin-right:2%" src="../assets/userHead.svg" />
      <img class="icon" style="width:50px;height:50px;float:left" src="../assets/userHead.svg" />
      <span style="margin-top:0.6%;margin-left:6%">{{user.length>=15?user.substr(0,15)+"...":user}}</span>
      <el-button @click="loginVisible=true" type="success" size="mini" style="margin-left:6%" v-if="userType=='本地用户'">登录</el-button>
      <el-button type="success" size="mini" style="margin-left:6%" v-if="userType=='云端用户'">同步</el-button>
      <el-button @click="cancleLogin" type="warning" size="mini" style="margin-left:6%" v-if="userType=='云端用户'">退出</el-button>
      </el-popover>

   <span style="color:white;float:right;margin-top:0.6%;margin-right:1%">{{user}}</span>

   <div v-if="$store.state.syncing">
   <img class="icon" style="width:25px;height:25px;float:right;margin-top:0.2%;margin-right:2%" src="../assets/loading.svg" />
   <span style="color:white;font-size:10px;float:right;margin-top:1%;margin-right:0.5%">{{'同步中...'}}</span>
   </div>

 <el-dialog title="用户登录" :visible.sync="loginVisible" >
 <el-form :model="userForm" label-width="auto">
 <el-form-item label="登录邮箱">
 <el-input v-model="userForm.email" placeholder="请输入登录邮箱"></el-input>
 </el-form-item>
 <el-form-item label="登录密码">
 <el-input v-model="userForm.password" placeholder="请输入登录密码" show-password></el-input>
 </el-form-item>
 </el-form>
 <el-button @click="login" type="success" :loading="logining">登录</el-button>
 <el-button @click="registerVisible=true" type="warning" :loading="logining">注册</el-button>
 </el-dialog>


 <el-dialog title="用户注册" :visible.sync="registerVisible" >
 <el-form :model="userRigister" label-width="auto">
 <el-form-item label="注册邮箱">
 <el-input v-model="userRigister.email" placeholder="请输入登录邮箱"></el-input>
 </el-form-item>
 <el-form-item label="输入密码">
 <el-input v-model="userRigister.pwd" placeholder="请输入登录密码" show-password></el-input>
 </el-form-item>

 <el-form-item label="重复密码">
 <el-input v-model="userRigister.pwd_repeat" placeholder="请重复登录密码" show-password></el-input>
 </el-form-item>

 </el-form>
 <el-button @click="register" type="warning" :loading="logining">确认注册</el-button>
 </el-dialog>
     

    </div>
  </div>
</template>

<script>
import { remote } from 'electron'
var database =require('nedb')
var  db=new database({
        filename:'./cloud.db',
        autoload:true
        })
export default {
   inject:['reload'],
   data () {
     return {
        isMaximized:false,
        user:'HelloWorld',
        userType:'本地用户',

        loginVisible:false,
        logining:false,

        registerVisible:false,
        userRigister:{
          email:'',
          pwd:'',
          pwd_repeat:''
        },

        userForm:{
          email:'',
          password:''
        }
     }
   },
  name: 'mainHead',
  methods: {

    //检查注册和登录时的邮箱格式
    emailFormatMatch(str){
      if(!str.match(/^[0-9,A-Z,a-z]+@[0-9,A-Z,a-z]+\.com|cn|net $/g)){
        return false
      }else{
        return true
      }
    },

    check(){
      alert(this.$store.state.dbName)
    },
    closeWindow () {
      remote.app.quit()
    },

    //退出登录
    cancleLogin(){
      db=new database({
        filename:'./cloud.db',
        autoload:true
      })
      let that=this
      db.remove({}, { multi: true }, function (err, numRemoved) {
      that.userType="本地用户"
      that.user='HelloWorld'
      that.$store.state.dbName='./test.db'
      that.$store.state.login=false
      that.$store.state.user='HelloWorld'
      that.$store.state.password=''
      that.$store.state.user_id=-1
      that.reload()
       });
    },

    //进行登录
    async login(){
      
      let that=this
      if(!this.emailFormatMatch(that.userForm.email)){
        this.$message({
          message:'请输入正确邮箱格式',
          type:'error'
        })
        return
      }

      db=new database({
        filename:'./cloud.db',
        autoload:true
      })
      this.logining=true
      let params={
        email:that.userForm.email,
        password:that.userForm.password
      }
      this.$http.defaults.adapter = require('axios/lib/adapters/http')
      await this.$http.post(that.$store.state.contextUrl+'/login',that.$qs.stringify(params)).then(function(res){
        if(res.data!="fail"){
          that.$message({
            message:'登录成功',
            type:'success'
          })
          that.userType="云端用户"
          that.user=that.userForm.email
          that.loginVisible=false
          that.$store.state.dbName='./cloud.db'
          that.$store.state.login=true
          that.$store.state.user=that.userForm.email
          that.$store.state.password=that.userForm.password
          that.$store.state.user_id=parseInt(res.data)
        }else{
           that.$message({
            message:'登录失败',
            type:'error'
          })
          that.logining=false
        }
      })

      if(this.$store.state.login){
        this.$http.post(that.$store.state.contextUrl+'/downloadPlan',that.$qs.stringify({
          user_id:that.$store.state.user_id
        })).then(function(res){
          db.remove({}, { multi: true }, function (err, numRemoved) {
          let cloudPlanArray=res.data
          let planArr=[]
          let planLog=[]
          for(let i=0;i<cloudPlanArray.length;i++){
             planArr.push(JSON.parse(cloudPlanArray[i].plan_text))
             planLog.push(JSON.parse(cloudPlanArray[i].planLog_text)) 
          }
          db.insert(planArr)
          db.insert(planLog)
          that.logining=false
          that.reload()
          })
        })
      }
    },

    //注册用户
    register(){
      if(this.userRigister.pwd!=this.userRigister.pwd_repeat){
        this.$message({
          message:'两次密码输入不一致',
          type:'error'
        })
      }
      let that=this
      this.$http(that.$store.state.contextUrl+'/register',that.$qs.stringify({
        email:that.userRigister.email,
        password:that.userRigister.pwd
      })).then(function(res){
        if(res.data=='success'){
          that.$message({
            message:'注册成功',
            type:'success'
          })
          that.registerVisible=false
          that.userRigister={
            email:'',
            pwd:'',
            pwd_repeat:''
          }
        }else{
          that.$message({
            message:'注册失败',
            type:'error'
          })
        }
      })
    },


    fullWindow () {
      let win = remote.getCurrentWindow()
       if(this.isMaximized){ 
          this.isMaximized=false
          win.unmaximize()
        }else{ 
          this.isMaximized=true
          win.maximize(); 
      } 
    },


    hideWindow () {
      let win = remote.getCurrentWindow()
      if (win.isMinimized()) {
        win.restore()
      } else {
        win.minimize()
      }
    },
    gotoHome () {
      this.$store.dispatch('changeTransition', 'flip')
      this.$router.push('/login')
    }
  },
}
</script>


<style scoped>
  .subHead{
    margin-top:10px
  }
  .header {
    height: 28px;
    padding: 2px;
    background-color:rgb(90,40,250);
    -webkit-app-region: drag
}
.rightIcon {
    -webkit-app-region: no-drag;
}

.icon:hover {
    color: #ff001a;
    cursor: pointer;
}


.rightBox{
  width: 100%;
}

.h3{
  float:left;
  margin-top:5px;
  margin-left:45%;
  color:azure
}
</style>
