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
          path:'/',
          name:'create-plan',
          component:require('@/components/createPlan').default
        },
        {
          path:'/workbench',
          name:'workbench',
          component:require('@/components/workbench').default
        },
        {
          path:'/showPlan',
          name:'showPlan',
          component:require('@/components/showPlanDetail').default
        },
        {
          path:'/planLog',
          name:'planLog',
          component:require('@/components/planLog').default
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
        }
      ]
    },
    {
      path:'/pdf',
      name:'pdf',
      component:require('@/components/pdf').default
    }
  ]
})
