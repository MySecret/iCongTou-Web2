<template>
    <div class="mainWrapper" :style="pageHeight">
        <ul class="container" id="container" ref="container">
            <li class="page" :style="pageHeight"><img src="./assets/page1.jpg" alt="" @touchstart="docTouchStart" @touchmove="docTouchMove"></li>
            <li class="page" :style="pageHeight">
                <div class="time"></div>
                <div class="chatWrapper">
                    <div class="msg">
                        <div class="answer-img">
                            <img src="./assets/logo.jpg" alt="">
                        </div>
                        <div class="answer-text">
                            <div class="answer-name"></div>
                            <div class="answer-msg">
                                <p class="answer-vioce"></p>
                                <i class="i-answer"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li class="page" :style="pageHeight"><img src="./assets/page3.jpg" alt=""></li>
        </ul>
    </div>
</template>
<script type="text/ecmascript-6">
    import Lib from 'assets/js/Lib'
    import {prefixStyle} from 'assets/js/dom'
    const transform = prefixStyle('transform')
    const transition = prefixStyle('transition')
    export default {
        data() {
            return{
                windowH: 0,
                touchY: 0,
                touchnewY: 0,
                autoTransform: 1
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
            }
        }
    }
</script>

<style lang="less">
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
            background:#fff;
        }
    }
</style>