
import Vue from 'vue'
import App from './ctldApp'

let vm = new Vue({
    render: h => h(App)
}).$mount('#app')
