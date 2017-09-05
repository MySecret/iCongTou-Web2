<template>
    <div class="mainWrapper" :style="pageHeight">
        <ul class="container" id="container" ref="container">
            <li class="page" :style="pageHeight" @touchstart="docTouchStart" @touchmove="docTouchMove">
                <div class="avatar">
                    <img src="./assets/logo.jpg" alt="">
                </div>
                <div class="text">个股情报侦查员</div>
                <div class="desc">紧急情报！{{ctStock.name}}有重大消息</div>
                <img src="./assets/tellphone.png" alt="" class="tellphone" @click="tellphone">
            </li>
            <li class="page" :style="pageHeight">
                <p class="time" v-html="this.time"></p>
                <div class="chatWrapper">
                    <div class="msg ctmsg">
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-vioce">有很重要的个股侦察情报告诉你,就在这个群里说吧！</p>
                                <p class="sanjiao i-answer"></p>
                            </div>
                        </div>
                    </div>
                    <div class="msg ctmsg" @click="voicePlay" v-show="voice.one.show">
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-audio answer-vioce"></p>
                                <p class="sanjiao i-answer"></p>
                                <img src="./assets/voice.png" alt="" class="voice">
                                <img src="./assets/red.png" alt="" class="red" v-show="voice.one.red">
                                <p class="minite">{{format(voice.one.length)}}''</p>
                            </div>
                        </div>
                    </div>
                    <div class="msg usermsg" v-show="userDate">
                        <div class="answer-text">
                            <div class="answer-name">{{userName}}</div>
                            <div class="answer-msg">
                                <p class="answer-vioce">{{userDate}}</p>
                                <p class="sanjiao i-user"></p>
                            </div>
                        </div>
                        <div class="answer-img">
                            <img :src="userAvatar" alt="">
                        </div>
                    </div>
                    <div class="msg ctmsg" v-show="voice.two.show" @click="voiceTwoPlay" >
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-audio answer-vioce"></p>
                                <p class="sanjiao i-answer"></p>
                                <img src="./assets/voice.png" alt="" class="voice">
                                <img src="./assets/red.png" alt="" class="red" v-show="voice.two.red">
                                <p class="minite">{{format(voice.two.length)}}''</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="search-resource" v-show="stockList">
                    <ul class="search-ul">
                        <li class="stock" v-for="(item, index) in stockList" @click="choseStock(item)">
                            <span class="code-mun" v-html="item.code"></span>
                            <span class="code-name" v-html="item.name"></span>
                        </li>
                    </ul>
                </div>
                <div class="user-input" v-show="userinput">
                    <input type="text" @input="search" ref="input" @focus="focus">
                </div>
            </li>
            <li class="page" :style="pageHeight">
                <img src="./assets/page3bg.png" alt="" class="page3bg">
                <img src="./assets/download.png" alt="" class="download" @click="download">
            </li>
        </ul>
        <img src="./assets/guideinput.png" alt="" class="guideinput" v-show="ctVoiceEnd">
        <div class="share" v-show="share">
            <img src="./assets/share.png" alt="">
        </div>
        <audio :src="voice.zero.src"  ref="pageOneMp3"  @error="error"></audio>
        <audio :src="ctStock.url"  ref="pageTwo1Mp3" @ended="ctVoiceEnded"></audio>
        <audio :src="voice.two.src"  ref="pageTwo2Mp3"  @ended="ctTwoVoiceEnded"></audio>
    </div>
</template>

<script type="text/ecmascript-6">
    import Lib from 'assets/js/Lib'
    import {prefixStyle} from 'assets/js/dom'
    import Rxports from 'assets/js/common'
    import fetchJsonp from 'fetch-jsonp'
    import {querystring} from 'vux'
    const transform = prefixStyle('transform')
    const transition = prefixStyle('transition')
    let searchUrl = PublicUrlAPI + 'stock/searchAndSort'
    let loadUrl = PublicUrlAPI + 'activity/call'
    let userInfoUrl = PublicUrlAPI + 'user/my/info/sync'
    let token = window.localStorage.ctH5token
    export default {
        data() {
            return{
                windowH: 0,
                touchY: 0,
                touchnewY: 0,
                autoTransform: 1,
                time:0,
                userinput:1,
                stockList: [],
                pageOnePlay: false,
                pageTwoPlay1: false,
                pageTwoPlay2: false,
                userAvatar:'',
                userName:'',
                ctStock: {
                },
                voice: {
                    zero:{
                        src: 'http://mp3.9ku.com/m4a/550430.m4a',
                        length:0,
                        play: false
                    },
                    one:{
                        src: '',
                        length:11,
                        red: 1,
                        play: false,
                        show: 0
                    },
                    two:{
                        src: '',
                        length:11,
                        red: 1,
                        play: false,
                        show: 0
                    }
                },
                userDate:'',
                guideShow: 1,
                ctVoiceEnd: 0,
                share: 0,
                voiceClick: 1
            }
        },
        computed: {
            pageHeight() {
                this.windowH =  document.body.clientHeight
                return `height: ${this.windowH}px`
            }
        },
        beforeCreate() {
            let urlParams = querystring.parse(location.search)
            let from = urlParams.from
            let isappinstalled = urlParams.isappinstalled
            if(from || isappinstalled) {
                window.location.href = location.href.substring(0, location.href.lastIndexOf('?'))
            }
            let token = window.localStorage.ctH5token
            let openid = urlParams.token
            if(openid) {
                localStorage.setItem('ctH5token', openid)
            }
            if(!openid) {// 如果头部没有token，本地存储也没有token，那就去掉微信登录
                var rdirecct_uri=encodeURI('http://api2.zmkm.la/api/weixin/auth/callback',"UTF-8")
                var appid='wx69961095c4129c21';
                var state=encodeURI(window.location.href,"UTF-8")
                window.location.href='https://open.weixin.qq.com/connect/oauth2/authorize?appid='+appid+'&redirect_uri='+rdirecct_uri+'&response_type=code&scope=snsapi_userinfo&state='+state+'#wechat_redirect'
            }
        },
        mounted() {
            this.pageOnePlay = true // 第一个声音默认可以播放
            let t = setTimeout(this._pageTransform, 6000)
            let date = new Date()
            this.time = Rxports.formatTimeToWeek(date) +' '+ Rxports.formatTimeToHour(date)
            let url = loadUrl
            let that = this
            fetchJsonp(url, {
                jsonpCallback: 'jsoncallback',
            }).then(function(response) {
                return response.json()
            }).then(function(json) {
                that.ctStock = json.data
            })
            // 设置分享
            let shareInfo = {
                "title":'个股侦查小分队发来前方紧急内幕消息！',
                "text":`紧急通知！重大消息！这支股票即将有大动作，需密切注意！`,
                "imageUrl":'http://zmkm.qiniudn.com/congtoulogo.png',
                "url":window.location.href
            }
            Rxports.WXshare(shareInfo,() => {
                this.share = 0
                this.voiceClick = 0
            })
            this.loadUserAvatar()
        },
        watch: {
            pageOnePlay(newPlay) {
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        if(window.WeixinJSBridge) {
                            return newPlay ? that.$refs.pageOneMp3.play() : that.$refs.pageOneMp3.pause()
                        }else {
                            document.addEventListener('WeixinJSBridgeReady', function() {
                                return newPlay ? that.$refs.pageOneMp3.play() : that.$refs.pageOneMp3.pause()
                            })
                        }
                    }else{
                        return newPlay ? this.$refs.pageOneMp3.play() : this.$refs.pageOneMp3.pause()
                    }
                })
            },
            pageTwoPlay1(newPlay) {
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        if(window.WeixinJSBridge) {
                            return newPlay ? that.$refs.pageTwo1Mp3.play() : that.$refs.pageTwo1Mp3.pause()
                        }else {
                            document.addEventListener('WeixinJSBridgeReady', function() {
                                return newPlay ? that.$refs.pageTwo1Mp3.play() : that.$refs.pageTwo1Mp3.pause()
                            })
                        }
                    }else {
                        return newPlay ? this.$refs.pageTwo1Mp3.play() : this.$refs.pageTwo1Mp3.pause()
                    }
                })
            },
            pageTwoPlay2(newPlay) {
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        if(window.WeixinJSBridge) {
                            return newPlay ? that.$refs.pageTwo2Mp3.play() : that.$refs.pageTwo2Mp3.pause()
                        }else {
                            document.addEventListener('WeixinJSBridgeReady', function() {
                                return newPlay ? that.$refs.pageTwo2Mp3.play() : that.$refs.pageTwo2Mp3.pause()
                            })
                        }
                    }else {
                        return newPlay ? this.$refs.pageTwo2Mp3.play() : this.$refs.pageTwo2Mp3.pause()
                    }
                })
            }
        },
        methods: {
            loadUserAvatar() {
                let url = userInfoUrl
                let that = this
                let option = {
                    data:{
                        token: window.localStorage.ctH5token
                    },
                    success:function(res) {
                        if(res.code){
                            alert(res.msg)
                            return
                        }
                        let data = res.data
                        that.userAvatar = data.avatar
                        that.userName = data.show_name
                    }
                }
                Rxports.ajaxJsonp(url, option)
            },
            error(){
                alert('报错')
            },
            tellphone() {
                this._pageTransform()
            },
            docTouchStart(e) {
                this.touchY = e.touches[0].pageY
            },
            docTouchMove(e) {
                this.touchnewY = e.touches[0].pageY
                let moveY = -(this.touchnewY - this.touchY)
                if (moveY > 0 && moveY / this.windowH > 0.2) {
                    this.$refs.container.style[transition] = `all 0.3s`
                    this.$refs.container.style[transform] = `translate3d(0, -${this.windowH}px, 0)`
                    this.pageOnePlay = false
                    this.autoTransform = 0
                    let b = setTimeout(this.oneVoiceMsgShow , 2000)
                    return;
                }
            },
            _pageTransform() {
                if(this.autoTransform) {
                    this.$refs.container.style[transition] = `all 0.3s`
                    this.$refs.container.style[transform] = `translate3d(0, -${this.windowH}px, 0)`
                    this.pageOnePlay = false
                    let b = setTimeout(this.oneVoiceMsgShow , 2000)
                }
            },
            _pageTransformTwo(){
                this.$refs.container.style[transition] = `all 0.3s`
                this.$refs.container.style[transform] = `translate3d(0, -${2 * this.windowH}px, 0)`
            },
            focus(){
                this.ctVoiceEnd = 0
            },
            search() {
                this.guideShow = 0
                let that = this
                let keyword = this.$refs.input.value
                if (keyword == '') {
                    return
                }
                that.stockList = []
                let option={
                    data: {
                        keyword : keyword,
                        sort: 'code',
                        size: '10'
                    },
                    success: function(res){
                        that.stockList = res.data
                    }
                }
                Rxports.ajaxJsonp(searchUrl, option)
            },
            ctVoiceEnded() {
                this.pageTwoPlay1 = false
                if(this.guideShow) {
                    this.ctVoiceEnd = 1
                }
            },
            ctTwoVoiceEnded() {
                this.pageTwoPlay2 = false
                this.autoTransform = 1
                setTimeout(this._pageTransformTwo, 1000)
            },
            format(interval) {
                interval = Math.round(interval)
                return `${interval}`
            },
            voicePlay() {
                this.pageTwoPlay1 = !this.pageTwoPlay1
                this.pageTwoPlay2 = false
                this.voice.one.red = 0
            },
            voiceTwoPlay() {
                if(this.voiceClick) {
                    if(!this.share) {
                        this.share = 1
                    }
                }else{
                    this.pageTwoPlay2 = !this.pageTwoPlay2
                    this.pageTwoPlay1 = false
                    this.voice.two.red = 0
                }
            },
            choseStock(item) {
                this.userDate = item.name
                this.userinput = 0
                let code = item.code
                this.stockList = []
                this.$refs.input.value = ''
                let url = `${loadUrl}?code=${code}`
                let that = this
                fetchJsonp(url, {
                    jsonpCallback: 'jsoncallback',
                }).then(function(response) {
                    return response.json()
                }).then(function(json) {
                    that.voice.two.src = json.data.url
                    setTimeout(that.twoVoiceMsgShow,1000)
                })
            },
            download() {
                window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.niusan.zmkm"
            },
            oneVoiceMsgShow() {
                this.voice.one.show = 1
            },
            twoVoiceMsgShow() {
                this.voice.two.show = 1
            }
        }
    }
</script>

<style lang="scss">
    body,html{
        width:100%;
        height: 100%;
    }
    .mainWrapper{
        overflow: hidden;
    }
    .page {
        overflow: hidden;
        &:first-child{
            position: relative;
            background-size:100% 100%;
            background-image:url('./assets/onebg.jpg');
            text-align: center;
            color:#fff;
            .avatar{
                width:206px;
                height:206px;
                border-radius:50%;
                overflow: hidden;
                margin:70px auto 35px;
                img{
                    width:100%;
                    height:100%;
                }
            }
            .text{
                font-size:70px;
            }
            .desc{
                font-size:34px;
                line-height:110px;
            }
            .tellphone{
                width:100%;
                position: absolute;
                bottom:130px;
                left:0px;
            }
        }
        &:nth-of-type(2){
            box-sizing:border-box;
            position: relative;
            background:#EBEBEB;
            text-align: center;
            padding:30px 20px;
            .time{
                display: inline-block;
                font-size:22px;
                padding:9px;
                line-height:22px;
                background:#CECECE;
                color:#fff;
                border-radius:5px;
            }
            .chatWrapper{
                .ctmsg{
                    text-align: left;
                    justify-content: flex-start;
                    /*.answer-text{*/

                    /*}*/
                    .answer-audio{
                        width:240px;
                    }
                }
                .usermsg{
                    text-align: right;
                    justify-content: flex-end;
                }
                .msg{
                    display: flex;
                    padding:20px 0;
                    .answer-img{
                        width:80px;
                        height:80px;
                        border-radius:5px;
                        overflow: hidden;
                        img{
                            width:100%;
                            height:100%;
                        }
                    }
                    .answer-text{
                        position: relative;
                        padding:0 30px;
                        .answer-name{
                            font-size:24px;
                            margin-bottom:10px;
                        }
                        .answer-msg{
                            .answer-audio{
                                height:60px;
                            }
                            .voice{
                                position: absolute;
                                top:55px;
                                left:50px;
                                width:25px;
                                height:34px;
                            }
                            .red{
                                width:18px;
                                height:18px;
                                position: absolute;
                                right:0px;
                                top:35px;
                            }
                            .minite{
                                position: absolute;
                                top:75px;
                                right:-20px;
                                font-size:28px;
                                color:#999999;
                            }
                            .answer-vioce{
                                display:inline-block;
                                text-align: left;
                                font-size:32px;
                                max-width:460px;
                                line-height:48px;
                                padding:10px 20px;
                                background:#fff;
                                border-radius:6px;
                            }
                            .sanjiao{
                                position: absolute;
                                top:60px;
                                width: 0px;
                                height: 0px;
                                border-top: 10px solid transparent;
                                border-bottom: 10px solid transparent;
                            }
                            .i-answer{
                                left: 15px;
                                border-right:20px solid #fff;
                            }
                            .i-user{
                                right: 15px;
                                border-left:20px solid #fff;
                            }
                        }
                    }
                }
            }
            .user-input{
                box-sizing:border-box;
                border-top:1px solid #D7D7D9;
                position: absolute;
                bottom:0px;
                left:0px;
                width:100%;
                height:100px;
                background:#F5F5F6;
                padding:15px 20px;
                input{
                    width:100%;
                    height:100%;
                    bordder:1px solid #D7D7D9;
                    outline:none;
                    font-size:30px;
                    line-height:30px;
                }
            }
            .search-resource{
                position: absolute;
                bottom:100px;
                left:0px;
                width:100%;
                font-size:24px;
                max-height:260px;
                overflow-y: scroll;
                ul{
                    background:rgba(0,0,0,0.6);
                    padding:0 40px;
                    li{
                        color:#fff;
                        font-size:26px;
                        line-height:64px;
                        border-bottom:1px solid rgba(255,255,255,0.1);
                        text-align: left;
                    }
                }

            }
        }
        &:nth-of-type(3){
            position: relative;
            .page3bg{
                width:100%;
                height:100%;
            }
            .download{
                width:378px;
                height:92px;
                position: absolute;
                top:1010px;
                left:50%;
                transform:translate3d(-50%,0,0);
            }
        }
    }
    .guideinput{
        position: absolute;
        bottom:110px;
        left:20px;
        width:266px;
        height:177px;
    }
    .share{
        position: fixed;
        width:100%;
        height:100%;
        top:0px;
        left:0px;
        background:rgba(0,0,0,0.5);
        img{
            position: absolute;
            right:0px;
            top:0px;
            width:288px;
            height:269px;
        }
    }
</style>