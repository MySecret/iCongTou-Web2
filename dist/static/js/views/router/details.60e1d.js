webpackJsonp([0],{10:function(t,e,n){"use strict";function r(t,e){if(!/^javas/.test(t)&&t){"object"===(void 0===t?"undefined":i()(t))||e&&"string"==typeof t&&!/http/.test(t)?"object"===(void 0===t?"undefined":i()(t))&&!0===t.replace?e.replace(t):"BACK"===t?e.go(-1):e.push(t):window.location.href=t}}e.a=r;var o=n(17),i=n.n(o)},104:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r=n(1),o=n(72),i=n(74),a=n.n(i),s=n(75),u=n.n(s),c=[{path:"/",component:a.a},{path:"/list",component:u.a}];r.a.use(o.a);var p=new o.a({routes:c});new r.a({router:p}).$mount("#app")},112:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r=n(10);e.default={name:"msg",props:["icon","title","description","buttons"],methods:{onClick:function(t,e){"function"==typeof t&&t(),e&&n.i(r.a)(e,this.$router)}}}},117:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r=(n(5),n(228)),o=n.n(r),i=n(49),a=n.n(i),s=n(26),u=n.n(s),c=n(16),p=n.n(c);e.default={name:"add",components:{HbHead:p.a,Msg:o.a,Divider:a.a,XButton:u.a},data:function(){return{}},methods:{}}},118:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r=(n(5),n(26)),o=n.n(r),i=n(16),a=n.n(i);e.default={components:{HbHead:a.a,XButton:o.a},data:function(){return{}},methods:{}}},175:function(t,e){},185:function(t,e){},187:function(t,e){},211:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"weui-msg"},[n("div",{staticClass:"weui-msg__icon-area"},[n("i",{staticClass:"weui-icon_msg",class:"weui-icon-"+(t.icon||"success")})]),t._v(" "),n("div",{staticClass:"weui-msg__text-area"},[n("h2",{staticClass:"weui-msg__title",domProps:{innerHTML:t._s(t.title)}}),t._v(" "),n("p",{staticClass:"weui-msg__desc"},[t._t("description")],2),t._v(" "),t.description?n("p",{staticClass:"weui-msg__desc",domProps:{innerHTML:t._s(t.description)}}):t._e()]),t._v(" "),n("div",{staticClass:"weui-msg__opr-area"},[n("p",{staticClass:"weui-btn-area"},[t._t("buttons"),t._v(" "),t._l(t.buttons,function(e){return n("a",{staticClass:"weui-btn",class:"weui-btn_"+e.type,attrs:{href:"javascript:;"},on:{click:function(n){t.onClick(e.onClick,e.link)}}},[t._v(t._s(e.text))])})],2)])])},staticRenderFns:[]}},221:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("hb-head",{attrs:{headfont:"有变化！！"}}),t._v(" "),n("div",{staticStyle:{padding:"25px 10px",color:"red","text-align":"center"}},[t._v("\n  \t注意看浏览器地址的变化！！\n  \t")]),t._v(" "),n("router-link",{attrs:{to:"/"}},[n("x-button",{attrs:{type:"warn"}},[t._v("点我再切换回来度试呗")])],1)],1)},staticRenderFns:[]}},223:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",[n("hb-head",{attrs:{headfont:"首页首页"}}),t._v(" "),n("div",{staticStyle:{padding:"25px 10px",color:"red","text-align":"center"}},[t._v("\n\t注意看浏览器地址的变化！！\n")]),t._v(" "),n("msg",{attrs:{title:"路由切换demo",description:"内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现",icon:"success"}},[n("div",{slot:"buttons"},[n("router-link",{attrs:{to:"/list"}},[n("x-button",{attrs:{type:"primary"}},[t._v("路由切换")])],1),t._v(" "),n("div",{staticStyle:{"margin-top":"15px"}},[n("a",{attrs:{href:"../home/list.html"}},[n("x-button",[t._v("返回demo列表页")])],1)])],1)])],1)},staticRenderFns:[]}},228:function(t,e,n){n(175);var r=n(0)(n(112),n(211),null,null);t.exports=r.exports},26:function(t,e,n){n(46);var r=n(0)(n(29),n(48),null,null);t.exports=r.exports},28:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default={name:"divider"}},29:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r=n(10);e.default={name:"x-button",props:{type:{default:"default"},disabled:Boolean,mini:Boolean,plain:Boolean,text:String,actionType:String,showLoading:Boolean,link:String},methods:{onClick:function(){!this.disabled&&n.i(r.a)(this.link,this.$router)}},computed:{classes:function(){return[{"weui-btn_disabled":this.disabled,"weui-btn_mini":this.mini},"weui-btn_"+this.type,this.plain?"weui-btn_plain-"+this.type:"",this.showLoading?"weui-btn_loading":""]}}}},45:function(t,e){},46:function(t,e){},47:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement;return(t._self._c||e)("p",{staticClass:"vux-divider"},[t._t("default")],2)},staticRenderFns:[]}},48:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("button",{staticClass:"weui-btn",class:t.classes,attrs:{disabled:t.disabled,type:t.actionType},on:{click:t.onClick}},[t.showLoading?n("i",{staticClass:"weui-loading"}):t._e(),t._v(" "),t._t("default",[t._v(t._s(t.text))])],2)},staticRenderFns:[]}},49:function(t,e,n){n(45);var r=n(0)(n(28),n(47),null,null);t.exports=r.exports},72:function(t,e,n){"use strict";function r(t,e){}function o(t){return Object.prototype.toString.call(t).indexOf("Error")>-1}function i(t,e){switch(typeof e){case"undefined":return;case"object":return e;case"function":return e(t);case"boolean":return e?t.params:void 0}}function a(t,e,n){void 0===e&&(e={});var r,o=n||s;try{r=o(t||"")}catch(t){r={}}for(var i in e){var a=e[i];r[i]=Array.isArray(a)?a.slice():a}return r}function s(t){var e={};return(t=t.trim().replace(/^(\?|#|&)/,""))?(t.split("&").forEach(function(t){var n=t.replace(/\+/g," ").split("="),r=qt(n.shift()),o=n.length>0?qt(n.join("=")):null;void 0===e[r]?e[r]=o:Array.isArray(e[r])?e[r].push(o):e[r]=[e[r],o]}),e):e}function u(t){var e=t?Object.keys(t).map(function(e){var n=t[e];if(void 0===n)return"";if(null===n)return Lt(e);if(Array.isArray(n)){var r=[];return n.forEach(function(t){void 0!==t&&(null===t?r.push(Lt(e)):r.push(Lt(e)+"="+Lt(t)))}),r.join("&")}return Lt(e)+"="+Lt(n)}).filter(function(t){return t.length>0}).join("&"):null;return e?"?"+e:""}function c(t,e,n,r){var o=r&&r.options.stringifyQuery,i={name:e.name||t&&t.name,meta:t&&t.meta||{},path:e.path||"/",hash:e.hash||"",query:e.query||{},params:e.params||{},fullPath:f(e,o),matched:t?p(t):[]};return n&&(i.redirectedFrom=f(n,o)),Object.freeze(i)}function p(t){for(var e=[];t;)e.unshift(t),t=t.parent;return e}function f(t,e){var n=t.path,r=t.query;void 0===r&&(r={});var o=t.hash;void 0===o&&(o="");var i=e||u;return(n||"/")+i(r)+o}function h(t,e){return e===Ut?t===e:!!e&&(t.path&&e.path?t.path.replace(Mt,"")===e.path.replace(Mt,"")&&t.hash===e.hash&&l(t.query,e.query):!(!t.name||!e.name)&&(t.name===e.name&&t.hash===e.hash&&l(t.query,e.query)&&l(t.params,e.params)))}function l(t,e){void 0===t&&(t={}),void 0===e&&(e={});var n=Object.keys(t),r=Object.keys(e);return n.length===r.length&&n.every(function(n){var r=t[n],o=e[n];return"object"==typeof r&&"object"==typeof o?l(r,o):String(r)===String(o)})}function d(t,e){return 0===t.path.replace(Mt,"/").indexOf(e.path.replace(Mt,"/"))&&(!e.hash||t.hash===e.hash)&&v(t.query,e.query)}function v(t,e){for(var n in e)if(!(n in t))return!1;return!0}function y(t){if(!(t.metaKey||t.altKey||t.ctrlKey||t.shiftKey||t.defaultPrevented||void 0!==t.button&&0!==t.button)){if(t.currentTarget&&t.currentTarget.getAttribute){if(/\b_blank\b/i.test(t.currentTarget.getAttribute("target")))return}return t.preventDefault&&t.preventDefault(),!0}}function m(t){if(t)for(var e,n=0;n<t.length;n++){if(e=t[n],"a"===e.tag)return e;if(e.children&&(e=m(e.children)))return e}}function g(t){if(!g.installed){g.installed=!0,At=t;var e=function(t){return void 0!==t},n=function(t,n){var r=t.$options._parentVnode;e(r)&&e(r=r.data)&&e(r=r.registerRouteInstance)&&r(t,n)};t.mixin({beforeCreate:function(){e(this.$options.router)?(this._routerRoot=this,this._router=this.$options.router,this._router.init(this),t.util.defineReactive(this,"_route",this._router.history.current)):this._routerRoot=this.$parent&&this.$parent._routerRoot||this,n(this,this)},destroyed:function(){n(this)}}),Object.defineProperty(t.prototype,"$router",{get:function(){return this._routerRoot._router}}),Object.defineProperty(t.prototype,"$route",{get:function(){return this._routerRoot._route}}),t.component("router-view",$t),t.component("router-link",Ft);var r=t.config.optionMergeStrategies;r.beforeRouteEnter=r.beforeRouteLeave=r.beforeRouteUpdate=r.created}}function b(t,e,n){var r=t.charAt(0);if("/"===r)return t;if("?"===r||"#"===r)return e+t;var o=e.split("/");n&&o[o.length-1]||o.pop();for(var i=t.replace(/^\//,"").split("/"),a=0;a<i.length;a++){var s=i[a];".."===s?o.pop():"."!==s&&o.push(s)}return""!==o[0]&&o.unshift(""),o.join("/")}function w(t){var e="",n="",r=t.indexOf("#");r>=0&&(e=t.slice(r),t=t.slice(0,r));var o=t.indexOf("?");return o>=0&&(n=t.slice(o+1),t=t.slice(0,o)),{path:t,query:n,hash:e}}function _(t){return t.replace(/\/\//g,"/")}function x(t,e){for(var n,r=[],o=0,i=0,a="",s=e&&e.delimiter||"/";null!=(n=Nt.exec(t));){var u=n[0],c=n[1],p=n.index;if(a+=t.slice(i,p),i=p+u.length,c)a+=c[1];else{var f=t[i],h=n[2],l=n[3],d=n[4],v=n[5],y=n[6],m=n[7];a&&(r.push(a),a="");var g=null!=h&&null!=f&&f!==h,b="+"===y||"*"===y,w="?"===y||"*"===y,_=n[2]||s,x=d||v;r.push({name:l||o++,prefix:h||"",delimiter:_,optional:w,repeat:b,partial:g,asterisk:!!m,pattern:x?j(x):m?".*":"[^"+O(_)+"]+?"})}}return i<t.length&&(a+=t.substr(i)),a&&r.push(a),r}function k(t,e){return R(x(t,e))}function C(t){return encodeURI(t).replace(/[\/?#]/g,function(t){return"%"+t.charCodeAt(0).toString(16).toUpperCase()})}function E(t){return encodeURI(t).replace(/[?#]/g,function(t){return"%"+t.charCodeAt(0).toString(16).toUpperCase()})}function R(t){for(var e=new Array(t.length),n=0;n<t.length;n++)"object"==typeof t[n]&&(e[n]=new RegExp("^(?:"+t[n].pattern+")$"));return function(n,r){for(var o="",i=n||{},a=r||{},s=a.pretty?C:encodeURIComponent,u=0;u<t.length;u++){var c=t[u];if("string"!=typeof c){var p,f=i[c.name];if(null==f){if(c.optional){c.partial&&(o+=c.prefix);continue}throw new TypeError('Expected "'+c.name+'" to be defined')}if(zt(f)){if(!c.repeat)throw new TypeError('Expected "'+c.name+'" to not repeat, but received `'+JSON.stringify(f)+"`");if(0===f.length){if(c.optional)continue;throw new TypeError('Expected "'+c.name+'" to not be empty')}for(var h=0;h<f.length;h++){if(p=s(f[h]),!e[u].test(p))throw new TypeError('Expected all "'+c.name+'" to match "'+c.pattern+'", but received `'+JSON.stringify(p)+"`");o+=(0===h?c.prefix:c.delimiter)+p}}else{if(p=c.asterisk?E(f):s(f),!e[u].test(p))throw new TypeError('Expected "'+c.name+'" to match "'+c.pattern+'", but received "'+p+'"');o+=c.prefix+p}}else o+=c}return o}}function O(t){return t.replace(/([.+*?=^!:${}()[\]|\/\\])/g,"\\$1")}function j(t){return t.replace(/([=!:$\/()])/g,"\\$1")}function A(t,e){return t.keys=e,t}function $(t){return t.sensitive?"":"i"}function T(t,e){var n=t.source.match(/\((?!\?)/g);if(n)for(var r=0;r<n.length;r++)e.push({name:r,prefix:null,delimiter:null,optional:!1,repeat:!1,partial:!1,asterisk:!1,pattern:null});return A(t,e)}function S(t,e,n){for(var r=[],o=0;o<t.length;o++)r.push(q(t[o],e,n).source);return A(new RegExp("(?:"+r.join("|")+")",$(n)),e)}function P(t,e,n){return L(x(t,n),e,n)}function L(t,e,n){zt(e)||(n=e||n,e=[]),n=n||{};for(var r=n.strict,o=!1!==n.end,i="",a=0;a<t.length;a++){var s=t[a];if("string"==typeof s)i+=O(s);else{var u=O(s.prefix),c="(?:"+s.pattern+")";e.push(s),s.repeat&&(c+="(?:"+u+c+")*"),c=s.optional?s.partial?u+"("+c+")?":"(?:"+u+"("+c+"))?":u+"("+c+")",i+=c}}var p=O(n.delimiter||"/"),f=i.slice(-p.length)===p;return r||(i=(f?i.slice(0,-p.length):i)+"(?:"+p+"(?=$))?"),i+=o?"$":r&&f?"":"(?="+p+"|$)",A(new RegExp("^"+i,$(n)),e)}function q(t,e,n){return zt(e)||(n=e||n,e=[]),n=n||{},t instanceof RegExp?T(t,e):zt(t)?S(t,e,n):P(t,e,n)}function M(t,e,n){try{return(Qt[t]||(Qt[t]=Vt.compile(t)))(e||{},{pretty:!0})}catch(t){return""}}function U(t,e,n,r){var o=e||[],i=n||Object.create(null),a=r||Object.create(null);t.forEach(function(t){H(o,i,a,t)});for(var s=0,u=o.length;s<u;s++)"*"===o[s]&&(o.push(o.splice(s,1)[0]),u--,s--);return{pathList:o,pathMap:i,nameMap:a}}function H(t,e,n,r,o,i){var a=r.path,s=r.name,u=F(a,o),c=r.pathToRegexpOptions||{};"boolean"==typeof r.caseSensitive&&(c.sensitive=r.caseSensitive);var p={path:u,regex:B(u,c),components:r.components||{default:r.component},instances:{},name:s,parent:o,matchAs:i,redirect:r.redirect,beforeEnter:r.beforeEnter,meta:r.meta||{},props:null==r.props?{}:r.components?r.props:{default:r.props}};if(r.children&&r.children.forEach(function(r){var o=i?_(i+"/"+r.path):void 0;H(t,e,n,r,p,o)}),void 0!==r.alias){(Array.isArray(r.alias)?r.alias:[r.alias]).forEach(function(i){var a={path:i,children:r.children};H(t,e,n,a,o,p.path||"/")})}e[p.path]||(t.push(p.path),e[p.path]=p),s&&(n[s]||(n[s]=p))}function B(t,e){var n=Vt(t,[],e);return n}function F(t,e){return t=t.replace(/\/$/,""),"/"===t[0]?t:null==e?t:_(e.path+"/"+t)}function I(t,e,n,r){var o="string"==typeof t?{path:t}:t;if(o.name||o._normalized)return o;if(!o.path&&o.params&&e){o=z({},o),o._normalized=!0;var i=z(z({},e.params),o.params);if(e.name)o.name=e.name,o.params=i;else if(e.matched.length){var s=e.matched[e.matched.length-1].path;o.path=M(s,i,"path "+e.path)}return o}var u=w(o.path||""),c=e&&e.path||"/",p=u.path?b(u.path,c,n||o.append):c,f=a(u.query,o.query,r&&r.options.parseQuery),h=o.hash||u.hash;return h&&"#"!==h.charAt(0)&&(h="#"+h),{_normalized:!0,path:p,query:f,hash:h}}function z(t,e){for(var n in e)t[n]=e[n];return t}function V(t,e){function n(t){U(t,u,p,f)}function r(t,n,r){var o=I(t,n,!1,e),i=o.name;if(i){var s=f[i];if(!s)return a(null,o);var c=s.regex.keys.filter(function(t){return!t.optional}).map(function(t){return t.name});if("object"!=typeof o.params&&(o.params={}),n&&"object"==typeof n.params)for(var h in n.params)!(h in o.params)&&c.indexOf(h)>-1&&(o.params[h]=n.params[h]);if(s)return o.path=M(s.path,o.params,'named route "'+i+'"'),a(s,o,r)}else if(o.path){o.params={};for(var l=0;l<u.length;l++){var d=u[l],v=p[d];if(D(v.regex,o.path,o.params))return a(v,o,r)}}return a(null,o)}function o(t,n){var o=t.redirect,i="function"==typeof o?o(c(t,n,null,e)):o;if("string"==typeof i&&(i={path:i}),!i||"object"!=typeof i)return a(null,n);var s=i,u=s.name,p=s.path,h=n.query,l=n.hash,d=n.params;if(h=s.hasOwnProperty("query")?s.query:h,l=s.hasOwnProperty("hash")?s.hash:l,d=s.hasOwnProperty("params")?s.params:d,u){f[u];return r({_normalized:!0,name:u,query:h,hash:l,params:d},void 0,n)}if(p){var v=K(p,t);return r({_normalized:!0,path:M(v,d,'redirect route with path "'+v+'"'),query:h,hash:l},void 0,n)}return a(null,n)}function i(t,e,n){var o=M(n,e.params,'aliased route with path "'+n+'"'),i=r({_normalized:!0,path:o});if(i){var s=i.matched,u=s[s.length-1];return e.params=i.params,a(u,e)}return a(null,e)}function a(t,n,r){return t&&t.redirect?o(t,r||n):t&&t.matchAs?i(t,n,t.matchAs):c(t,n,r,e)}var s=U(t),u=s.pathList,p=s.pathMap,f=s.nameMap;return{match:r,addRoutes:n}}function D(t,e,n){var r=e.match(t);if(!r)return!1;if(!n)return!0;for(var o=1,i=r.length;o<i;++o){var a=t.keys[o-1],s="string"==typeof r[o]?decodeURIComponent(r[o]):r[o];a&&(n[a.name]=s)}return!0}function K(t,e){return b(t,e.parent?e.parent.path:"/",!0)}function X(){window.addEventListener("popstate",function(t){N(),t.state&&t.state.key&&rt(t.state.key)})}function J(t,e,n,r){if(t.app){var o=t.options.scrollBehavior;o&&t.app.$nextTick(function(){var t=Q(),i=o(e,n,r?t:null);if(i){var a="object"==typeof i;if(a&&"string"==typeof i.selector){var s=document.querySelector(i.selector);if(s){var u=i.offset&&"object"==typeof i.offset?i.offset:{};u=Z(u),t=Y(s,u)}else W(i)&&(t=G(i))}else a&&W(i)&&(t=G(i));t&&window.scrollTo(t.x,t.y)}})}}function N(){var t=nt();t&&(Yt[t]={x:window.pageXOffset,y:window.pageYOffset})}function Q(){var t=nt();if(t)return Yt[t]}function Y(t,e){var n=document.documentElement,r=n.getBoundingClientRect(),o=t.getBoundingClientRect();return{x:o.left-r.left-e.x,y:o.top-r.top-e.y}}function W(t){return tt(t.x)||tt(t.y)}function G(t){return{x:tt(t.x)?t.x:window.pageXOffset,y:tt(t.y)?t.y:window.pageYOffset}}function Z(t){return{x:tt(t.x)?t.x:0,y:tt(t.y)?t.y:0}}function tt(t){return"number"==typeof t}function et(){return Gt.now().toFixed(3)}function nt(){return Zt}function rt(t){Zt=t}function ot(t,e){N();var n=window.history;try{e?n.replaceState({key:Zt},"",t):(Zt=et(),n.pushState({key:Zt},"",t))}catch(n){window.location[e?"replace":"assign"](t)}}function it(t){ot(t,!0)}function at(t,e,n){var r=function(o){o>=t.length?n():t[o]?e(t[o],function(){r(o+1)}):r(o+1)};r(0)}function st(t){return function(e,n,r){var i=!1,a=0,s=null;ut(t,function(t,e,n,u){if("function"==typeof t&&void 0===t.cid){i=!0,a++;var c,p=pt(function(e){e.__esModule&&e.default&&(e=e.default),t.resolved="function"==typeof e?e:At.extend(e),n.components[u]=e,--a<=0&&r()}),f=pt(function(t){var e="Failed to resolve async component "+u+": "+t;s||(s=o(t)?t:new Error(e),r(s))});try{c=t(p,f)}catch(t){f(t)}if(c)if("function"==typeof c.then)c.then(p,f);else{var h=c.component;h&&"function"==typeof h.then&&h.then(p,f)}}}),i||r()}}function ut(t,e){return ct(t.map(function(t){return Object.keys(t.components).map(function(n){return e(t.components[n],t.instances[n],t,n)})}))}function ct(t){return Array.prototype.concat.apply([],t)}function pt(t){var e=!1;return function(){for(var n=[],r=arguments.length;r--;)n[r]=arguments[r];if(!e)return e=!0,t.apply(this,n)}}function ft(t){if(!t)if(It){var e=document.querySelector("base");t=e&&e.getAttribute("href")||"/",t=t.replace(/^https?:\/\/[^\/]+/,"")}else t="/";return"/"!==t.charAt(0)&&(t="/"+t),t.replace(/\/$/,"")}function ht(t,e){var n,r=Math.max(t.length,e.length);for(n=0;n<r&&t[n]===e[n];n++);return{updated:e.slice(0,n),activated:e.slice(n),deactivated:t.slice(n)}}function lt(t,e,n,r){var o=ut(t,function(t,r,o,i){var a=dt(t,e);if(a)return Array.isArray(a)?a.map(function(t){return n(t,r,o,i)}):n(a,r,o,i)});return ct(r?o.reverse():o)}function dt(t,e){return"function"!=typeof t&&(t=At.extend(t)),t.options[e]}function vt(t){return lt(t,"beforeRouteLeave",mt,!0)}function yt(t){return lt(t,"beforeRouteUpdate",mt)}function mt(t,e){if(e)return function(){return t.apply(e,arguments)}}function gt(t,e,n){return lt(t,"beforeRouteEnter",function(t,r,o,i){return bt(t,o,i,e,n)})}function bt(t,e,n,r,o){return function(i,a,s){return t(i,a,function(t){s(t),"function"==typeof t&&r.push(function(){wt(t,e.instances,n,o)})})}}function wt(t,e,n,r){e[n]?t(e[n]):r()&&setTimeout(function(){wt(t,e,n,r)},16)}function _t(t){var e=window.location.pathname;return t&&0===e.indexOf(t)&&(e=e.slice(t.length)),(e||"/")+window.location.search+window.location.hash}function xt(t){var e=_t(t);if(!/^\/#/.test(e))return window.location.replace(_(t+"/#"+e)),!0}function kt(){var t=Ct();return"/"===t.charAt(0)||(Rt("/"+t),!1)}function Ct(){var t=window.location.href,e=t.indexOf("#");return-1===e?"":t.slice(e+1)}function Et(t){window.location.hash=t}function Rt(t){var e=window.location.href,n=e.indexOf("#"),r=n>=0?e.slice(0,n):e;window.location.replace(r+"#"+t)}function Ot(t,e){return t.push(e),function(){var n=t.indexOf(e);n>-1&&t.splice(n,1)}}function jt(t,e,n){var r="hash"===n?"#"+e:e;return t?_(t+"/"+r):r}var At,$t={name:"router-view",functional:!0,props:{name:{type:String,default:"default"}},render:function(t,e){var n=e.props,r=e.children,o=e.parent,a=e.data;a.routerView=!0;for(var s=o.$createElement,u=n.name,c=o.$route,p=o._routerViewCache||(o._routerViewCache={}),f=0,h=!1;o&&o._routerRoot!==o;)o.$vnode&&o.$vnode.data.routerView&&f++,o._inactive&&(h=!0),o=o.$parent;if(a.routerViewDepth=f,h)return s(p[u],a,r);var l=c.matched[f];if(!l)return p[u]=null,s();var d=p[u]=l.components[u];return a.registerRouteInstance=function(t,e){var n=l.instances[u];(e&&n!==t||!e&&n===t)&&(l.instances[u]=e)},(a.hook||(a.hook={})).prepatch=function(t,e){l.instances[u]=e.componentInstance},a.props=i(c,l.props&&l.props[u]),s(d,a,r)}},Tt=/[!'()*]/g,St=function(t){return"%"+t.charCodeAt(0).toString(16)},Pt=/%2C/g,Lt=function(t){return encodeURIComponent(t).replace(Tt,St).replace(Pt,",")},qt=decodeURIComponent,Mt=/\/?$/,Ut=c(null,{path:"/"}),Ht=[String,Object],Bt=[String,Array],Ft={name:"router-link",props:{to:{type:Ht,required:!0},tag:{type:String,default:"a"},exact:Boolean,append:Boolean,replace:Boolean,activeClass:String,exactActiveClass:String,event:{type:Bt,default:"click"}},render:function(t){var e=this,n=this.$router,r=this.$route,o=n.resolve(this.to,r,this.append),i=o.location,a=o.route,s=o.href,u={},p=n.options.linkActiveClass,f=n.options.linkExactActiveClass,l=null==p?"router-link-active":p,v=null==f?"router-link-exact-active":f,g=null==this.activeClass?l:this.activeClass,b=null==this.exactActiveClass?v:this.exactActiveClass,w=i.path?c(null,i,null,n):a;u[b]=h(r,w),u[g]=this.exact?u[b]:d(r,w);var _=function(t){y(t)&&(e.replace?n.replace(i):n.push(i))},x={click:y};Array.isArray(this.event)?this.event.forEach(function(t){x[t]=_}):x[this.event]=_;var k={class:u};if("a"===this.tag)k.on=x,k.attrs={href:s};else{var C=m(this.$slots.default);if(C){C.isStatic=!1;var E=At.util.extend;(C.data=E({},C.data)).on=x;(C.data.attrs=E({},C.data.attrs)).href=s}else k.on=x}return t(this.tag,k,this.$slots.default)}},It="undefined"!=typeof window,zt=Array.isArray||function(t){return"[object Array]"==Object.prototype.toString.call(t)},Vt=q,Dt=x,Kt=k,Xt=R,Jt=L,Nt=new RegExp(["(\\\\.)","([\\/.])?(?:(?:\\:(\\w+)(?:\\(((?:\\\\.|[^\\\\()])+)\\))?|\\(((?:\\\\.|[^\\\\()])+)\\))([+*?])?|(\\*))"].join("|"),"g");Vt.parse=Dt,Vt.compile=Kt,Vt.tokensToFunction=Xt,Vt.tokensToRegExp=Jt;var Qt=Object.create(null),Yt=Object.create(null),Wt=It&&function(){var t=window.navigator.userAgent;return(-1===t.indexOf("Android 2.")&&-1===t.indexOf("Android 4.0")||-1===t.indexOf("Mobile Safari")||-1!==t.indexOf("Chrome")||-1!==t.indexOf("Windows Phone"))&&(window.history&&"pushState"in window.history)}(),Gt=It&&window.performance&&window.performance.now?window.performance:Date,Zt=et(),te=function(t,e){this.router=t,this.base=ft(e),this.current=Ut,this.pending=null,this.ready=!1,this.readyCbs=[],this.readyErrorCbs=[],this.errorCbs=[]};te.prototype.listen=function(t){this.cb=t},te.prototype.onReady=function(t,e){this.ready?t():(this.readyCbs.push(t),e&&this.readyErrorCbs.push(e))},te.prototype.onError=function(t){this.errorCbs.push(t)},te.prototype.transitionTo=function(t,e,n){var r=this,o=this.router.match(t,this.current);this.confirmTransition(o,function(){r.updateRoute(o),e&&e(o),r.ensureURL(),r.ready||(r.ready=!0,r.readyCbs.forEach(function(t){t(o)}))},function(t){n&&n(t),t&&!r.ready&&(r.ready=!0,r.readyErrorCbs.forEach(function(e){e(t)}))})},te.prototype.confirmTransition=function(t,e,n){var i=this,a=this.current,s=function(t){o(t)&&(i.errorCbs.length?i.errorCbs.forEach(function(e){e(t)}):(r(!1,"uncaught error during route navigation:"),console.error(t))),n&&n(t)};if(h(t,a)&&t.matched.length===a.matched.length)return this.ensureURL(),s();var u=ht(this.current.matched,t.matched),c=u.updated,p=u.deactivated,f=u.activated,l=[].concat(vt(p),this.router.beforeHooks,yt(c),f.map(function(t){return t.beforeEnter}),st(f));this.pending=t;var d=function(e,n){if(i.pending!==t)return s();try{e(t,a,function(t){!1===t||o(t)?(i.ensureURL(!0),s(t)):"string"==typeof t||"object"==typeof t&&("string"==typeof t.path||"string"==typeof t.name)?(s(),"object"==typeof t&&t.replace?i.replace(t):i.push(t)):n(t)})}catch(t){s(t)}};at(l,d,function(){var n=[];at(gt(f,n,function(){return i.current===t}).concat(i.router.resolveHooks),d,function(){if(i.pending!==t)return s();i.pending=null,e(t),i.router.app&&i.router.app.$nextTick(function(){n.forEach(function(t){t()})})})})},te.prototype.updateRoute=function(t){var e=this.current;this.current=t,this.cb&&this.cb(t),this.router.afterHooks.forEach(function(n){n&&n(t,e)})};var ee=function(t){function e(e,n){var r=this;t.call(this,e,n);var o=e.options.scrollBehavior;o&&X(),window.addEventListener("popstate",function(t){var n=r.current;r.transitionTo(_t(r.base),function(t){o&&J(e,t,n,!0)})})}return t&&(e.__proto__=t),e.prototype=Object.create(t&&t.prototype),e.prototype.constructor=e,e.prototype.go=function(t){window.history.go(t)},e.prototype.push=function(t,e,n){var r=this,o=this,i=o.current;this.transitionTo(t,function(t){ot(_(r.base+t.fullPath)),J(r.router,t,i,!1),e&&e(t)},n)},e.prototype.replace=function(t,e,n){var r=this,o=this,i=o.current;this.transitionTo(t,function(t){it(_(r.base+t.fullPath)),J(r.router,t,i,!1),e&&e(t)},n)},e.prototype.ensureURL=function(t){if(_t(this.base)!==this.current.fullPath){var e=_(this.base+this.current.fullPath);t?ot(e):it(e)}},e.prototype.getCurrentLocation=function(){return _t(this.base)},e}(te),ne=function(t){function e(e,n,r){t.call(this,e,n),r&&xt(this.base)||kt()}return t&&(e.__proto__=t),e.prototype=Object.create(t&&t.prototype),e.prototype.constructor=e,e.prototype.setupListeners=function(){var t=this;window.addEventListener("hashchange",function(){kt()&&t.transitionTo(Ct(),function(t){Rt(t.fullPath)})})},e.prototype.push=function(t,e,n){this.transitionTo(t,function(t){Et(t.fullPath),e&&e(t)},n)},e.prototype.replace=function(t,e,n){this.transitionTo(t,function(t){Rt(t.fullPath),e&&e(t)},n)},e.prototype.go=function(t){window.history.go(t)},e.prototype.ensureURL=function(t){var e=this.current.fullPath;Ct()!==e&&(t?Et(e):Rt(e))},e.prototype.getCurrentLocation=function(){return Ct()},e}(te),re=function(t){function e(e,n){t.call(this,e,n),this.stack=[],this.index=-1}return t&&(e.__proto__=t),e.prototype=Object.create(t&&t.prototype),e.prototype.constructor=e,e.prototype.push=function(t,e,n){var r=this;this.transitionTo(t,function(t){r.stack=r.stack.slice(0,r.index+1).concat(t),r.index++,e&&e(t)},n)},e.prototype.replace=function(t,e,n){var r=this;this.transitionTo(t,function(t){r.stack=r.stack.slice(0,r.index).concat(t),e&&e(t)},n)},e.prototype.go=function(t){var e=this,n=this.index+t;if(!(n<0||n>=this.stack.length)){var r=this.stack[n];this.confirmTransition(r,function(){e.index=n,e.updateRoute(r)})}},e.prototype.getCurrentLocation=function(){var t=this.stack[this.stack.length-1];return t?t.fullPath:"/"},e.prototype.ensureURL=function(){},e}(te),oe=function(t){void 0===t&&(t={}),this.app=null,this.apps=[],this.options=t,this.beforeHooks=[],this.resolveHooks=[],this.afterHooks=[],this.matcher=V(t.routes||[],this);var e=t.mode||"hash";switch(this.fallback="history"===e&&!Wt&&!1!==t.fallback,this.fallback&&(e="hash"),It||(e="abstract"),this.mode=e,e){case"history":this.history=new ee(this,t.base);break;case"hash":this.history=new ne(this,t.base,this.fallback);break;case"abstract":this.history=new re(this,t.base)}},ie={currentRoute:{}};oe.prototype.match=function(t,e,n){return this.matcher.match(t,e,n)},ie.currentRoute.get=function(){return this.history&&this.history.current},oe.prototype.init=function(t){var e=this;if(this.apps.push(t),!this.app){this.app=t;var n=this.history;if(n instanceof ee)n.transitionTo(n.getCurrentLocation());else if(n instanceof ne){var r=function(){n.setupListeners()};n.transitionTo(n.getCurrentLocation(),r,r)}n.listen(function(t){e.apps.forEach(function(e){e._route=t})})}},oe.prototype.beforeEach=function(t){return Ot(this.beforeHooks,t)},oe.prototype.beforeResolve=function(t){return Ot(this.resolveHooks,t)},oe.prototype.afterEach=function(t){return Ot(this.afterHooks,t)},oe.prototype.onReady=function(t,e){this.history.onReady(t,e)},oe.prototype.onError=function(t){this.history.onError(t)},oe.prototype.push=function(t,e,n){this.history.push(t,e,n)},oe.prototype.replace=function(t,e,n){this.history.replace(t,e,n)},oe.prototype.go=function(t){this.history.go(t)},oe.prototype.back=function(){this.go(-1)},oe.prototype.forward=function(){this.go(1)},oe.prototype.getMatchedComponents=function(t){var e=t?t.matched?t:this.resolve(t).route:this.currentRoute;return e?[].concat.apply([],e.matched.map(function(t){return Object.keys(t.components).map(function(e){return t.components[e]})})):[]},oe.prototype.resolve=function(t,e,n){var r=I(t,e||this.history.current,n,this),o=this.match(r,e),i=o.redirectedFrom||o.fullPath;return{location:r,route:o,href:jt(this.history.base,i,this.mode),normalizedTo:r,resolved:o}},oe.prototype.addRoutes=function(t){this.matcher.addRoutes(t),this.history.current!==Ut&&this.history.transitionTo(this.history.getCurrentLocation())},Object.defineProperties(oe.prototype,ie),oe.install=g,oe.version="2.7.0",It&&window.Vue&&window.Vue.use(oe),e.a=oe},74:function(t,e,n){n(187);var r=n(0)(n(117),n(223),null,null);t.exports=r.exports},75:function(t,e,n){n(185);var r=n(0)(n(118),n(221),null,null);t.exports=r.exports}},[104]);