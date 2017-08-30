<template>
    <div class="mainWrapper" :style="pageHeight">
        <ul class="container" id="container" ref="container">
            <li class="page" :style="pageHeight"><img src="./assets/page1.jpg" alt="" @touchstart="docTouchStart" @touchmove="docTouchMove"></li>
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
            <li class="page" :style="pageHeight"><img src="./assets/page3.jpg" alt=""></li>
        </ul>
        <audio :src="voice.zero.src" @canplay="pageOneCanPlay" ref="pageOneMp3"></audio>
        <audio :src="voice.one.src"  ref="pageTwo1Mp3" @timeupdate="voiceLength" @ended="ctVoiceEnded"></audio>
        <audio :src="voice.two.src"  ref="pageTwo2Mp3"  @ended="ctTwoVoiceEnded"></audio>
    </div>
</template>
<script type="text/ecmascript-6">
    import Lib from 'assets/js/Lib'
    import {prefixStyle} from 'assets/js/dom'
    import {formatTimeToWeek, formatTimeToHour} from 'assets/js/common'
    import fetchJsonp from 'fetch-jsonp'
    const transform = prefixStyle('transform')
    const transition = prefixStyle('transition')
    let searchUrl = PublicUrlAPI + 'stock/searchAndSort'
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
                voice: {
                    zero:{
                        src: 'http://cdnringuc.shoujiduoduo.com/ringres/user/a24/253/24990253.aac',
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
                userDate:''
            }
        },
        computed: {
            pageHeight() {
                this.windowH =  document.body.clientHeight
                return `height: ${this.windowH}px`
            }
        },
        mounted() {
            setTimeout(this._pageTransform, 5000)
            let date = new Date()
            this.time = formatTimeToWeek(date) +' '+ formatTimeToHour(date)
        },
        watch: {
            pageOnePlay(newPlay) {
                this.$nextTick(() => {
                    return newPlay ? this.$refs.pageOneMp3.play() : this.$refs.pageOneMp3.pause()
                })
            },
            pageTwoPlay1(newPlay) {
                this.$nextTick(() => {
                    return newPlay ? this.$refs.pageTwo1Mp3.play() : this.$refs.pageTwo1Mp3.pause()
                })
            },
            pageTwoPlay2(newPlay) {
                this.$nextTick(() => {
                    return newPlay ? this.$refs.pageTwo2Mp3.play() : this.$refs.pageTwo2Mp3.pause()
                })
            }
        },
        methods: {
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
            search() {
                let that = this
                let keyword = this.$refs.input.value
                if (keyword == '') {
                    return
                }
                that.stockList = []
                let url = searchUrl + `?keyword=${keyword}&sort=code&size=10`
                fetchJsonp(url, {
                    jsonpCallback: 'jsoncallback',
                }).then(function(response) {
                    return response.json()
                }).then(function(json) {
                    that.stockList = json.data
                })
            },
            pageOneCanPlay() {
                this.pageOnePlay = true
            },
            voiceLength(e) {
                this.voice.one.length = e.target.duration
            },
            ctVoiceEnded() {
                this.pageTwoPlay1 = false
            },
            ctTwoVoiceEnded() {
                this.pageTwoPlay2 = false
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
                vm.$off([input,search])
                this.voice.two.src="http://tsn.baidu.com/text2audio?tex=%E5%B9%B3%E5%AE%89%E9%93%B6%E8%A1%8C%E5%95%8A%E6%88%91%E8%B7%9F%E4%BD%A0%E8%AF%B4%E8%BF%99%E4%B8%AA%E4%B8%8D%E9%94%99%E7%9A%84%E5%95%8A&ctp=1&lan=zh&cuid=0e247865&tok=24.17fad79728dfead108d1f9621b1ff508.2592000.1505966324.282335-9931908"
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
            img{
                width:100%;
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
                            }
                            .red{
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
    }
</style>