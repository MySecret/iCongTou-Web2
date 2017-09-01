
import conf from './conf';

import axios from 'axios';

import fetchJsonp from 'fetch-jsonp';
var wx = require('weixin-js-sdk');
var oproto = Object.prototype;
var serialize = oproto.toString;
var Rxports = {


	/**
	  * 封装axios，减少学习成本，参数基本跟jq ajax一致
	  * @param {String} type			请求的类型，默认post
	  * @param {String} url				请求地址
	  * @param {String} time			超时时间
	  * @param {Object} data			请求参数
	  * @param {String} dataType		预期服务器返回的数据类型，xml html json ...
	  * @param {Object} headers			自定义请求headers
	  * @param {Function} success		请求成功后，这里会有两个参数,服务器返回数据，返回状态，[data, res]
	  * @param {Function} error		发送请求前
	  * @param return 
	*/
	ajax:function (opt){
		
		var opts = opt || {};
		
		if (!opts.url) {
			alert('请填写接口地址');
			return false;
		}
		
		axios({
			method: opts.type || 'post',
			url: opts.url,
			params: opts.data || {},
			headers: opts.headers || {
			  	'Content-Type':'application/x-www-form-urlencoded'
			},
			// `baseURL` 将自动加在 `url` 前面，除非 `url` 是一个绝对 URL。
  			// 它可以通过设置一个 `baseURL` 便于为 axios 实例的方法传递相对 URL
			baseURL:'',
			timeout: opts.time || 10*1000,
			responseType: opts.dataType || 'json'
		}).then(function(res){
			if(res.status == 200 ){
				if(opts.success){
					opts.success(res.data,res);
				}
			}else{
				if (data.error) {
					opts.error(error);
				}else{
					alert('好多人在访问呀，请重新试试[timeout]');
				}
			}
		}).catch(function (error){
			console.log(error);
			if (opts.error) {
				opts.error(error);
			}else{
				alert('好多人在访问呀，请重新试试[timeout]');
			}
		});
	},
	/*判定是否类数组，如节点集合，纯数组，arguments与拥有非负整数的length属性的纯JS对象*/
	isArrayLike:function(obj) {
    if (!obj)
        return false
    var n = obj.length
    if (n === (n >>> 0)) { //检测length属性是否为非负整数
        var type = serialize.call(obj).slice(8, -1)
        if (/(?:regexp|string|function|window|global)$/i.test(type))
            return false
        if (type === "Array")
            return true
        try {
            if ({}.propertyIsEnumerable.call(obj, "length") === false) { //如果是原生对象
                return /^\s?function/.test(obj.item || obj.callee)
            }
            return true
        } catch (e) { //IE的NodeList直接抛错
            return !obj.window //IE6-8 window
        }
    }
    return false
	},
	/*遍历数组与对象,回调的第一个参数为索引或键名,第二个或元素或键值*/
    each: function (obj, fn) {
    	var That = this;
        if (obj) { //排除null, undefined
            var i = 0
            if (That.isArrayLike(obj)) {
                for (var n = obj.length; i < n; i++) {
                    if (fn(i, obj[i]) === false)
                        break
                }
            } else {
                for (i in obj) {
                    if (obj.hasOwnProperty(i) && fn(i, obj[i]) === false) {
                        break
                    }
                }
            }
        }
    },
	/**
	  * 获取url传过来的参数
	  * @param name 	获取的参数
	  * @param Url 		自定义获取参数的链接
	  * @param return
	*/
	getUrlQuery:function (name,Url){
	   //URL GET 获取值
　　   var reg = new RegExp("(^|\\?|&)"+ name +"=([^&]*)(\\s|&|$)", "i"),
             url = Url || location.href;
　　     if (reg.test(url))
　　     return unescape(RegExp.$2.replace(/\+/g, " "));
　　     return "";
	},
    isWeiXin: function() {
		var ua = window.navigator.userAgent.toLowerCase();
		if (ua.match(/MicroMessenger/i) == 'micromessenger') {
			return true;
		} else {
			return false;
		}
	},
	ajaxJsonp:function(_url,options){
		var options =Object.assign({jsonpCallback:'jsoncallback'},options ||{}),
			 params = options.data || {},
			 successFunc = options.success || function() {};
		if(Object.keys(params).length){
			_url += _url.indexOf('?') === -1 ? '?' : '&';
			for(let [key,value] of Object.entries(params)){
				_url+=key + '=' + value + "&";
			}
			_url = _url.substring(0,_url.length-1);
			delete options.data;
		}
		fetchJsonp(_url,options).then(function(response){
			response.json().then(function(response){
				successFunc.call(Rxports,response);
			});
		}).catch(function(err){
			console.log(err);
		})
		return this;
	},
    formatTimeToHour: function(fmt) {
		let date = new Date(fmt)
		return date.Format('hh:mm')
	},
    formatTimeToWeek: function (fmt) {
		let date = new Date(fmt)
		let weekDay = {
			'0' : '星期日',
			'1' : '星期一',
			'2' : '星期二',
			'3' : '星期三',
			'4' : '星期四',
			'5' : '星期五',
			'6' : '星期六'
		}
		return weekDay[date.Format('w')]
	},
    WXshare: function(setUpInfo, callback) {
		var shareUrl = window.location.href;
		var shareTitle_t = setUpInfo.shareTitle_t || setUpInfo.title;
		var lineLink_t = shareUrl;
		var imgUrl_t = setUpInfo.imgUrl_t || setUpInfo.imageUrl;
		var descContent_t = setUpInfo.descContent_t || setUpInfo.text;

		//好友数据
		var shareTitle_f = setUpInfo.shareTitle_f || setUpInfo.title;
		var lineLink_f = shareUrl;
		var imgUrl_f = setUpInfo.imgUrl_f || setUpInfo.imageUrl;
		var descContent_f = setUpInfo.descContent_f || setUpInfo.text;

		var Wxsharemessage = 'http://api2.zmkm.la/api/rest/system/jssdk'; //这里必须写死这个后台的接口，因为微信没有QA，所以直接用正式的
		var options = {
			success: function(data){
				console.log(data)
                var data = data.data;
                var appid = data.appid;
                var timestamp = data.timestamp;
                var nonceStr = data.noncestr;
                var signature = data.sign;
                wx.config({
                    debug: false,
                    appId: appid,
                    timestamp: timestamp,
                    nonceStr: nonceStr,
                    signature: signature,
                    jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']
                });
                wx.ready(function () {
                    //分享朋友圈
                    wx.onMenuShareTimeline({
                        title: shareTitle_t, // 分享标题
                        link: lineLink_t, // 分享链接
                        imgUrl: imgUrl_t, // 分享图标
                        success: function () {
                            callback()
                            // 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        }
                    });
                    //分享好友
                    wx.onMenuShareAppMessage({
                        title: shareTitle_f, // 分享标题
                        desc: descContent_f, // 分享描述
                        link: lineLink_f, // 分享链接
                        imgUrl: imgUrl_f, // 分享图标
                        type: '', // 分享类型,music、video或link，不填默认为link
                        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                        success: function () {
                            callback()
                            // 用户确认分享后执行的回调函数
                        },
                        cancel: function () {
                            // 用户取消分享后执行的回调函数
                        }
                    });
                });
			},
			data: {
                "url" : shareUrl
			}
		};
		this.ajaxJsonp(Wxsharemessage,options)
	}
};
Date.prototype.Format = function(fmt)
{ //author: meizz
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds(),             //毫秒
		"w+" : this.getDay()
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}
export default Rxports;


































