
<template>
<el-menu  class="el-menu-demo" mode="horizontal">
  <el-menu-item @click="reLocate('/')" index="1" >创建计划</el-menu-item>
  <el-menu-item @click="reLocate('/workbench')" index="2" >计划工作台</el-menu-item>
  <el-menu-item @click="reLocate('/myPlan')" index="3" >我的计划</el-menu-item>
  <el-menu-item @click="reLocate('/userCenter')" index="4" >个人中心</el-menu-item>
</el-menu>
</template>

<script>
export default {
  methods:{
    reLocate(path){
      this.$router.push(path)
    }
  }
}
</script>

<style>

</style>