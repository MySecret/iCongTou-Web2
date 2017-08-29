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
                    <div class="msg usermsg">
                        <div class="answer-text">
                            <div class="answer-name">侦查员小聪</div>
                            <div class="answer-msg">
                                <p class="answer-vioce">有很重要的个股侦察情报告诉你就在这个群里说吧！</p>
                                <p class="sanjiao i-user"></p>
                            </div>
                        </div>
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                    </div>
                </div>
                <div class="user-input">
                    <div class="search-resource">
                        <span class="code-name" v-html="this.stockList.name"></span>
                        <span class="code-mun" v-html="this.stockList.code"></span>
                    </div>
                    <input type="text" @input="search()" ref="input">
                </div>
            </li>
            <li class="page" :style="pageHeight"><img src="./assets/page3.jpg" alt=""></li>
        </ul>
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
                stockList: {}
            }
        },
        computed: {
            pageHeight() {
                this.windowH =  document.body.clientHeight
                return `height: ${this.windowH}px`
            }
        },
        mounted() {
//            setTimeout(this._pageTransform, 4000)
            let date = new Date()
            this.time = formatTimeToWeek(date) +' '+ formatTimeToHour(date)
        },
        watch: {
            stockList(newY) {
                console.log(newY)
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
                    this.autoTransform = 0
                    return;
                }
            },
            _pageTransform() {

                if(this.autoTransform) {
                    this.$refs.container.style[transition] = `all 0.3s`
                    this.$refs.container.style[transform] = `translate3d(0, -${this.windowH}px, 0)`
                }
            },
            search() {
                let that = this
                console.log(this.$refs.input.value)
                searchUrl = searchUrl + `?keyword=${this.$refs.input.value}&sort=code&size=1`
                fetchJsonp(searchUrl, {
                    jsonpCallback: 'jsoncallback',
                }).then(function(response) {
                    return response.json()
                }).then(function(json) {
                    console.log(json)
                    that.stockList = json.data[0]
                })
            },

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
                                top:50px;
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
        }
    }
</style>