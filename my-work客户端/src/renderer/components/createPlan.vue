<template>
<div class="main">
<el-card >
<h3 style="color:#1E90FF">创建计划</h3>
  <el-form ref="form" :model="form" label-width="auto">
  <el-form-item style="margin-top:20px" label="计划名称">
    <el-input v-model="form.name"></el-input>
  </el-form-item>
  <el-form-item label="计划时间">
    <el-col :span="11">
      <el-date-picker  value-format="yyyy 年 MM 月 dd 日" type="date" placeholder="选择开始日期" v-model="form.startDate" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col style="margin-left:27px" :span="11">
      <el-time-picker value-format="HH:mm:ss" placeholder="选择开始时间" v-model="form.startTime" style="width: 100%;"></el-time-picker>
    </el-col>
    <el-col style="margin-top:15px" :span="11">
      <el-date-picker  value-format="yyyy 年 MM 月 dd 日" type="date" placeholder="选择结束日期" v-model="form.endDate" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col style="margin-top:15px;margin-left:27px" :span="11">
      <el-time-picker value-format="HH:mm:ss" placeholder="选择结束时间" v-model="form.endTime" style="width: 100%;"></el-time-picker>
    </el-col>
  </el-form-item>
  <el-form-item label="计划性质">
    <el-radio-group v-model="form.type">
      <el-radio label="小组计划"></el-radio>
      <el-radio label="个人计划"></el-radio>
    </el-radio-group>
  </el-form-item>
  
  <el-form-item label="计划执行人" v-if="form.type=='个人计划'">
    <el-input  v-model="form.excutor"></el-input>
  </el-form-item>
  
  <el-form-item label="小组负责人" v-if="form.type=='小组计划'">
    <el-input  v-model="form.manager"></el-input>
  </el-form-item>
  <el-form-item label="小组成员数" v-if="form.type=='小组计划'">
    <el-input  v-model="form.memCount"></el-input>
  </el-form-item>
  
  <div  v-if="form.type=='小组计划'">
  <el-form-item :label="'小组成员'+(i+1)"  v-for="(item,i) in form.member" :key="i">
    <el-input  v-model="form.member[i]"></el-input>
  </el-form-item>
  </div>

  <el-form-item label="计划描述">
    <el-input type="textarea" v-model="form.desc"></el-input>
  </el-form-item>
  <el-form-item>
    <el-button type="success" @click="createPlan">立即创建</el-button>
    <el-button type="info" @click="refresh">重置</el-button>
  </el-form-item>
</el-form>
</el-card>
<el-card class="process">
<h3 style="color:#1E90FF">添加任务</h3>


<el-form ref="process" :model="process" label-width="auto">
  <el-form-item label="任务序号">
    <el-input  v-model="process.steps[process.thisPage-1].id" :readonly="true"></el-input>
  </el-form-item>

  <el-form-item label="任务名称">
    <el-input  v-model="process.steps[process.thisPage-1].pro_name"></el-input>
  </el-form-item>

<el-form-item label="任务时间">
    <el-col :span="11">
      <el-date-picker value-format="yyyy 年 MM 月 dd 日" type="date" placeholder="选择开始日期" v-model="process.steps[process.thisPage-1].startDate" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col style="margin-left:27px" :span="11">
      <el-time-picker value-format="HH:mm:ss" placeholder="选择开始时间" v-model="process.steps[process.thisPage-1].startTime" style="width: 100%;"></el-time-picker>
    </el-col>
    <el-col style="margin-top:15px" :span="11">
      <el-date-picker value-format="yyyy 年 MM 月 dd 日" type="date" placeholder="选择结束日期" v-model="process.steps[process.thisPage-1].endDate" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col style="margin-top:15px;margin-left:27px" :span="11">
      <el-time-picker value-format="HH:mm:ss" placeholder="选择结束时间" v-model="process.steps[process.thisPage-1].endTime" style="width: 100%;"></el-time-picker>
    </el-col>
  </el-form-item>

  <el-form-item label="任务描述">
   <el-input type="textarea" v-model="process.steps[process.thisPage-1].pro_text"></el-input>
  </el-form-item>

<el-form-item>
  <el-pagination
    layout="prev, pager, next"
    :page-size="1"
     @current-change="changeProcess"
    :total="this.process.page">
  </el-pagination>
</el-form-item>

    <el-form-item>
    <el-button type="primary" @click="addProcess">新增任务</el-button>
    <el-button type="warning" @click="reduceProcess">移除任务</el-button>
  </el-form-item>
</el-form>


</el-card>

</div>
</template>

<script>
var database =require('nedb')
let db=[]
export default {
  inject:['reload'],
  created:function(){
   let that=this
      db=new database({
        filename:that.$store.state.dbName,
        autoload:true
        })
},
  data () {
    return {
      form: {
        name: '',
        startDate: '',
        startTime: '',
        endDate:'',
        endTime:'',
        type: '个人计划',
        desc: '',
        excutor:'',
        manager:'',
        memCount:0,
        member:[],
        informed:false
      },
      process:{
        page:1,
        thisPage:1,
        steps:[
          {
            id:1,
            status:0,
            pro_name:'',
            pro_text:'',
            startDate:'',
            startTime:'',
            endDate:'',
            endTime:''
          }
        ]
      }
    }
  },
  methods: {
    //比价日期前后
    compareDate(date1,date2){
            let arr1=date1.split(/\s*[^0-9]\s*/g)
            let arr2=date2.split(/\s*[^0-9]\s*/g)
            
            let year1=parseInt(arr1[0])
            let year2=parseInt(arr2[0])

            if(year1==year2){
                let month1=parseInt(arr1[1])
                let month2=parseInt(arr2[1])
                
                if(month1==month2){
                    let day1=parseInt(arr1[2])
                    let day2=parseInt(arr2[2])

                    return day1-day2

                }else{
                    return month1-month2
                }
            }else{
                return year1-year2
            }
    },
    
    //比较时间前后
    compareTime(time1,time2){
            let arr1=time1.split(/\s*:\s*/g)
            let arr2=time2.split(/\s*:\s*/g)
            
            let hour1=parseInt(arr1[0])
            let hour2=parseInt(arr2[0])

            if(hour1==hour2){
                let minute1=parseInt(arr1[1])
                let minute2=parseInt(arr2[1])

                if(minute1==minute2){
                    let second1=parseInt(arr1[2])
                    let second2=parseInt(arr2[2])

                    return second1-second2
                }else{
                    return minute1-minute2
                }
            }else{
                return hour1-hour2
            }
        },
    
    compare(date1,time1,date2,time2){
      let dateCompare=this.compareDate(date1,date2)
      if(dateCompare==0){
        return this.compareTime(time1,time2)
      }else{
        return dateCompare
      }
    },

    refresh(){
      this.process.steps=[
          {
            pro_name:'',
            pro_text:'',
            startDate:'',
            startTime:'',
            endDate:'',
            endTime:''
          }
        ]
        this.form={
        name: '',
        startDate: '',
        startTime: '',
        endDate:'',
        endTime:'',
        type: '',
        desc: '',
        excutor:'',
        manager:'',
        memCount:0,
        member:[]
      }
    },

    checkPlanIsEmpty(plan){
      if(plan.name==''||
         plan.startDate==''||
         plan.startTime==''||
         plan.endDate==''||
         plan.endTime==''||
         plan.type==''||
         plan.desc==''){
           return false
         }
      if(plan.type=='小组计划'&&plan.manager==''||
         plan.type=='个人计划'&&plan.excutor==''){
           return false
      }
      return true
    },

    checkProcessIsEmpty(step){
      let l=step.length
      for(let i=0;i<l;i++){
        let tmp=step[i]
        if(tmp.pro_name==''||
           tmp.pro_text==''||
           tmp.startDate==''||
           tmp.startTime==''||
           tmp.endDate==''||
           tmp.endTime==''){
             return false
           }
      }
      return true
    },

    addProcess(){
      this.process.page=this.process.page+1
    },

    reduceProcess(){
      if(this.process.page==1){
        this.$message({
          message:'至少保留一个任务',
          offset:100,
          type:'warning',
          showClose: true
        });
        return 
      }
       this.process.page=this.process.page-1
    },
    changeProcess(val){
      this.process.thisPage=val
    },
    createPlan(){
      
      if(!this.checkPlanIsEmpty(this.form)){
         this.$message({
          message:'计划属性不能为空',
          offset:100,
          type:'error',
          showClose: true
      })
      return 
      }

      if(!this.checkProcessIsEmpty(this.process.steps)){
         this.$message({
          message:'任务属性不能为空',
          offset:100,
          type:'error',
          showClose: true
      })
      return 
      }

      let startDate=this.form.startDate
      let startTime=this.form.startTime
      let endDate=this.form.endDate
      let endTime=this.form.endTime
      
      if(this.compare(startDate,startTime,endDate,endTime)>=0){
        this.$message({
          message:'计划结束时间必须在计划开始时间之后',
          type:'error'
        })
        return
      }
      

      for(let i=0;i<this.process.steps.length;i++){
        let pro_startDate=this.process.steps[i].startDate
        let pro_startTime=this.process.steps[i].startTime
        let pro_endDate=this.process.steps[i].endDate
        let pro_endTime=this.process.steps[i].endTime

        if(this.compare(pro_startDate,pro_startTime,pro_endDate,pro_endTime)>=0){
          this.$message({
            message:'任务'+(i+1)+'的结束时间必须在开始时间之后',
            type:'error'
          })
          return 
        }else if(this.compare(startDate,startTime,pro_startDate,pro_startTime)>0){
          this.$message({
            message:'任务'+(i+1)+'的开始时间不能在计划开始时间之前',
            type:'error'
          })
          return 
        }else if(this.compare(pro_endDate,pro_endTime,endDate,endTime)>0){
           this.$message({
            message:'任务'+(i+1)+'的结束时间不能在计划结束时间之后',
            type:'error'
          })
          return 
        }
      }


      this.process.steps.unshift({
            pro_name:'计划开始',
            pro_text:'好的开始是成功的一半！',
            startDate:startDate,
            startTime:startTime,
      })
      this.process.steps.push({
            pro_name:'计划结束',
            pro_text:'坚持就是胜利！',
            startDate:endDate,
            startTime:endTime,
      })
      db.insert({
        type:"planItemTest2",
        plan:this.form,
        process:this.process.steps,
      },function (err, newDoc){
      })

      
      let that=this
       //云同步代码
      if(this.$store.state.dbName=='./cloud.db'){
        
        let promise=new Promise(function(resolve,reject){
          let notes=[]
          db.find({type:'planItemNotes',plan:that.form.name},function(err,Docs){
                        if(Docs.length!=0){
                            notes.push(Docs[0])
                        }else{
                            notes=[{
                                type:'planItemNotes',
                                plan:that.form.name,
                                dailyNotes:{}
                            }]
                        }
                        resolve(notes)
                    })
        })

        promise.then(function(notes){
          
          
          if(notes==null){
            that.$message({
              message:'云同步失败',
              type:'error'
            })
          }
        
          that.$store.state.syncing=true
          that.$http.post(that.$store.state.contextUrl+'/uploadPlan',that.$qs.stringify({

          user_id:that.$store.state.user_id,
          plan:JSON.stringify([{
             type:"planItemTest2",
             plan:that.form,
             process:that.process.steps
          }]),
          planLog:JSON.stringify(notes)

        })).then(function(res){
          if(res.data=='fail'){
            that.$message({
              message:'云端同步失败，请检查网络设置',
              type:'error'
            })
          }
          that.$store.state.syncing=false
        })

        })
      }
      this.reload()
    },

    refreshPlan(){
      db.find({"plan.name":"test"},function(err,Docs){
        alert(JSON.stringify(Docs))
      })
    } 
  },
  
  watch:{
    "form.memCount":function(val){
      this.form.member=[]
      for(let i=0;i<val;i++){
        this.form.member.push("")
      }
    },
    "process.page":function(val){
      while(this.process.steps.length<val){
        this.process.steps.push({
            id:this.process.steps.length+1,
            status:0,
            pro_name:'',
            pro_text:'',
            excutors:[],
            startdate:'',
            startTime:'',
            endDate:'',
            endTime:''
        })
      }
      while(this.process.steps.length>val){
        this.process.steps.pop()
      }
    },

  }
}
</script>

<style scoped>
.el-card{
    width:48%;
    float: left;
    margin-left:10px;
    margin-top:5px;
}
.el-card >>> .el-card__body{
  padding: 12px;
}
.process{
    margin-left: 15px;
    height:100%
}
.main{
   height:100%;
   font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB",
    "Microsoft YaHei","微软雅黑",Arial,sans-serif;
}
</style>