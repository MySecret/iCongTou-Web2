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
                                <p class="answer-vioce">有很重要的个股侦察情报告诉你就在这个群里说吧！</p>
                                <p class="sanjiao i-answer"></p>
                            </div>
                        </div>
                    </div>
                    <div class="msg ctmsg" @click="voicePlay">
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-audio answer-vioce"></p>
                                <p class="sanjiao i-answer"></p>
                                <img src="./assets/voice.png" alt="" class="voice">
                                <p class="minite">{{format(voice.one.length)}}''</p>
                            </div>
                        </div>
                    </div>
                    <div class="msg usermsg" v-show="userDate">
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-vioce">{{userDate}}</p>
                                <p class="sanjiao i-user"></p>
                            </div>
                        </div>
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                    </div>
                    <div class="msg ctmsg" v-show="voice.two.src" @click="voiceTwoPlay">
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
                <div class="user-input">
                    <input type="text" @input="search" ref="input">
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
        <audio :src="ctStock.url"  ref="pageTwo1Mp3" @timeupdate="updateTime" @ended="ctVoiceEnded"></audio>
        <audio :src="voice.two.src"  ref="pageTwo2Mp3"  @ended="ctTwoVoiceEnded"></audio>
    </div>
</template>

<script type="text/ecmascript-6">
    import Lib from 'assets/js/Lib'
    import {prefixStyle} from 'assets/js/dom'
    import Rxports from 'assets/js/common'
    import fetchJsonp from 'fetch-jsonp'
    const transform = prefixStyle('transform')
    const transition = prefixStyle('transition')
    let searchUrl = PublicUrlAPI + 'stock/searchAndSort'
    let loadUrl = PublicUrlAPI + 'activity/call'
    export default {
        data() {
            return{
                windowH: 0,
                touchY: 0,
                touchnewY: 0,
                autoTransform: 1,
                time:0,
                stockList: [],
                pageOnePlay: false,
                pageTwoPlay1: false,
                pageTwoPlay2: false,
                ctStock: {

                },
                voice: {
                    zero:{
                        src: 'http://ws.stream.qqmusic.qq.com/105030812.m4a?fromtag=46',
                        length:0,
                        play: false
                    },
                    one:{
                        src: 'http://tsn.baidu.com/text2audio?tex=%E4%BD%A0%E6%98%AF%E9%A3%8E%E5%84%BF%E5%84%BF%E6%88%91%E6%98%AF%E6%B2%99%E5%84%BF%E5%84%BF%E6%88%91%E4%BB%AC%E4%B8%80%E8%B5%B7%E7%9D%A1%E4%BB%96%E5%AE%B6&ctp=1&lan=zh&cuid=0e247865&tok=24.17fad79728dfead108d1f9621b1ff508.2592000.1505966324.282335-9931908',
                        length:0,
                        play: false
                    },
                    two:{
                        src: '',
                        length:24,
                        red: 1,
                        play: false
                    }
                },
                userDate:'',
                guideShow: 1,
                ctVoiceEnd: 0,
                share: 0
            }
        },
        computed: {
            pageHeight() {
                this.windowH =  document.body.clientHeight
                return `height: ${this.windowH}px`
            }
        },
        mounted() {
            this.pageOnePlay = true // 第一个声音默认可以播放
            setTimeout(this._pageTransform, 5000)
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
                "title":'分享标题',
                "text":'分享描述',
                "imageUrl":'',
                "url":window.location.href
            }
            Rxports.WXshare(shareInfo,() => {
                this.share = 0
            })

        },
        watch: {
            pageOnePlay(newPlay) {
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        document.addEventListener('WeixinJSBridgeReady', function() {
                            return newPlay ? that.$refs.pageOneMp3.play() : that.$refs.pageOneMp3.pause()
                        })
                        return newPlay ? that.$refs.pageOneMp3.play() : that.$refs.pageOneMp3.pause()
                    }else{
                        return newPlay ? this.$refs.pageOneMp3.play() : this.$refs.pageOneMp3.pause()
                    }
                })
            },
            pageTwoPlay1(newPlay) {
                console.log(newPlay)
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        document.addEventListener('WeixinJSBridgeReady', function() {
                            return newPlay ? that.$refs.pageTwo1Mp3.play() : that.$refs.pageTwo1Mp3.pause()
                        })
                        return newPlay ? that.$refs.pageTwo1Mp3.play() : that.$refs.pageTwo1Mp3.pause()
                    }else {
                        return newPlay ? this.$refs.pageTwo1Mp3.play() : this.$refs.pageTwo1Mp3.pause()
                    }
                })
            },
            pageTwoPlay2(newPlay) {
                this.$nextTick(() => {
                    if(Rxports.isWeiXin()){
                        let that = this
                        document.addEventListener('WeixinJSBridgeReady', function() {
                            return newPlay ? that.$refs.pageTwo2Mp3.play() : that.$refs.pageTwo2Mp3.pause()
                        })
                        return newPlay ? that.$refs.pageTwo2Mp3.play() : that.$refs.pageTwo2Mp3.pause()
                    }else {
                        return newPlay ? this.$refs.pageTwo2Mp3.play() : this.$refs.pageTwo2Mp3.pause()
                    }
                })
            }
        },
        methods: {
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
                    this.pageTwoPlay1 = true
                    this.autoTransform = 0
                    return;
                }
            },
            _pageTransform() {
                if(this.autoTransform) {
                    this.$refs.container.style[transition] = `all 0.3s`
                    this.$refs.container.style[transform] = `translate3d(0, -${this.windowH}px, 0)`
                    this.pageOnePlay = false
                    this.pageTwoPlay1 = true
                }
            },
            _pageTransformTwo(){
                this.$refs.container.style[transition] = `all 0.3s`
                this.$refs.container.style[transform] = `translate3d(0, -${2 * this.windowH}px, 0)`
            },
            search() {
                this.guideShow = 0
                this.ctVoiceEnd = 0
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
            updateTime(e) {
                console.log(e.target.duration)
                this.voice.one.length = e.target.duration
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
            },
            voiceTwoPlay() {
                this.pageTwoPlay2 = !this.pageTwoPlay2
                this.pageTwoPlay1 = false
                this.voice.two.red = 0
            },
            choseStock(item) {
                this.userDate = item.name
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
                    that.share = 1
                })
            },
            download() {
                window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.niusan.zmkm"
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
                                left:160px;
                                font-size:28px;
                                color:#999999;
                            }
                            .answer-vioce{
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