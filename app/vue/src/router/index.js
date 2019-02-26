import Vue from 'vue'
import Router from 'vue-router'
import ISBN from "@/components/ISBN"

Vue.use(Router)

export default new Router({
  routes: [
    { path: "/", name: "ISBN", component: ISBN },
  ]
})
