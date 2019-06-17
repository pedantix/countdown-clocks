import './scss/app.scss';
import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import ClockDisplay from './vue-components/clock-display.vue';
import ClockForm from './vue-components/clock-form.vue';

const components = { ClockDisplay, ClockForm };

Vue.use(BootstrapVue);


window.addEventListener('DOMContentLoaded', () => {
  if (window.vueapp != null) {
    // in case of PJAX in the future clean up vueapps
    window.vueapp.map(app => {
      app.$destroy();
    });
  }
  window.vueapp = [];

  const vueNodes = document.querySelectorAll('.vue-container');
  vueNodes.forEach(node => {
    if (node != null) {
      var vueapp = new Vue({
        el: node,
        components: components
      });
      window.vueapp.push(vueapp);
    }
  });
  console.log(`Initialized ${vueNodes.length} Vue Containers`);
});
