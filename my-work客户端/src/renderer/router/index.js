import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  
  routes: [
    {
      path: '/',
      name: 'main-frame',
      component: require('@/components/mainFrame').default,
      children:[
        {
          path:'/createPlan',
          name:'create-plan',
          component:require('@/components/createPlan_').default
        },
        {
          path:'/workbench',
          name:'workbench',
          component:require('@/components/workbench_').default
        },
        {
          path:'/showPlan',
          name:'showPlan',
          component:require('@/components/showPlanDetail').default
        },
        {
          path:'/planLog',
          name:'planLog',
          component:require('@/components/planLog_').default
        },
        {
          path:'/userCenter',
          name:'userCenter',
          component:require('@/components/userCenter').default
        },
        {
          path:'/myPlan',
          name:'myPlan',
          component:require('@/components/myPlan').default
        },
        {
          path:'/myPlanDisplay',
          name:'myPlanDisplay',
          component:require('@/components/myPlanDisplay').default
        },
        {
          path:'/planNote',
          name:'planNote',
          component:require('@/components/planNote').default
        },
        {
          path:'/markdown',
          name:'markdown',
          component:require('@/components/markdown').default
        },
        {
          path:'/workbenchPlan',
          name:'workbenchPlan',
          component:require('@/components/workbench_plan').default
        },
        {
          path:'/message',
          name:'message',
          component:require('@/components/message').default
        },
        {
          path:'/cowork',
          name:'cowork',
          component:require('@/components/cowork').default
        },
        {
          path:'/coworkDisplay',
          name:'coworkDisplay',
          component:require('@/components/coworkDisplay').default
        }
      ]
    },
    {
      path:'/pdf',
      name:'pdf',
      component:require('@/components/pdf').default
    },
    {
      path:'/todayWorkComponent',
      name:'todayWorkComponent',
      component:require('@/components/todayWorkList').default
    },
    {
      path:'/calendarComponent',
      name:'calendarComponent',
      component:require('@/components/calendar').default
    },
    {
      path:'/clockComponent',
      name:'clockComponent',
      component:require('@/components/FlipClock').default
    },
    {
      path:'/noteBookComponent',
      name:'noteBookComponent',
      component:require('@/components/index_book').default
    }
  ]
})
