webpackJsonp([3],{10:function(e,t,a){"use strict";function i(e,t){if(!/^javas/.test(e)&&e){"object"===(void 0===e?"undefined":s()(e))||t&&"string"==typeof e&&!/http/.test(e)?"object"===(void 0===e?"undefined":s()(e))&&!0===e.replace?t.replace(e):"BACK"===e?t.go(-1):t.push(e):window.location.href=e}}t.a=i;var n=a(17),s=a.n(n)},105:function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=a(1),n=a(77),s=a.n(n);new i.a({render:function(e){return e(s.a)}}).$mount("#app")},110:function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=a(10);t.default={name:"form-preview",props:["headerLabel","headerValue","bodyItems","footerButtons","name"],methods:{onButtonClick:function(e,t){e&&e(this.name),t&&a.i(i.a)(t,this.$router)}}}},119:function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=a(5),n=a(16),s=a.n(n),r=a(226),o=a.n(r);t.default={components:{HbHead:s.a,FormPreview:o.a},data:function(){return{ajaxResult:{}}},mounted:function(){this.ajax()},methods:{ajax:function(){var e=this;this.$vux.loading.show({text:"Loading"}),i.a.M.ajax({url:"api/Getdata/vue2_multipage_getajax_demo",success:function(t){e.ajaxResult=t,setTimeout(function(){e.$vux.loading.hide()},1e3)}})}}}},183:function(e,t){},188:function(e,t){},219:function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"vux-form-preview weui-form-preview"},[a("div",{staticClass:"weui-form-preview__hd"},[a("label",{staticClass:"weui-form-preview__label",domProps:{innerHTML:e._s(e.headerLabel)}}),e._v(" "),a("em",{staticClass:"weui-form-preview__value",domProps:{innerHTML:e._s(e.headerValue)}})]),e._v(" "),a("div",{staticClass:"weui-form-preview__bd"},e._l(e.bodyItems,function(t){return a("div",{staticClass:"weui-form-preview__item"},[a("label",{staticClass:"weui-form-preview__label"},[e._v(e._s(t.label))]),e._v(" "),a("span",{staticClass:"weui-form-preview__value"},[e._v(e._s(t.value))])])})),e._v(" "),a("div",{staticClass:"weui-form-preview__ft"},e._l(e.footerButtons,function(t){return a("a",{staticClass:"weui-form-preview__btn",class:{"weui-form-preview__btn_default":"default"===t.style,"weui-form-preview__btn_primary":"primary"===t.style},attrs:{href:"javascript:"},on:{click:function(a){e.onButtonClick(t.onButtonClick,t.link)}}},[e._v(e._s(t.text))])}))])},staticRenderFns:[]}},224:function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"mainWarp"},[a("hb-head",{attrs:{headfont:"图片"}}),e._v(" "),e._m(0),e._v(" "),e.ajaxResult.status?a("div",{staticClass:"martop10"},[a("form-preview",{attrs:{"header-label":"付款金额","header-value":"¥2400.00","body-items":e.ajaxResult.goodslist}})],1):e._e()],1)},staticRenderFns:[function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"bgfff martop10 pad10 font14 color666"},[a("p",[e._v("\n    \t\t这里展示了使用axios获取数据，axios已封装，方便快捷使用，封装参数与jq ajax基本一致，减少学习成本。\n    \t")])])}]}},226:function(e,t,a){a(183);var i=a(0)(a(110),a(219),null,null);e.exports=i.exports},77:function(e,t,a){a(188);var i=a(0)(a(119),a(224),null,null);e.exports=i.exports}},[105]);