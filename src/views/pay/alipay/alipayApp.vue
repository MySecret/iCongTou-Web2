<template>
    <div>
        <form action="http://stag-api2.zmkm.la/api/rest/alipay/pay/web?no=201708281226257193" method="post" id="payForm" target="_self">
            <input type="hidden" name="mergeId" id="mergeId" value="">
            <input type="hidden" name="shop.title" id="shopTitle" value="测试产品">
            <input type="hidden" name="totalPrice" id="totalPrice" value="">
            <input type="hidden" name="totalNum" id="totalNum" value="">
            <input type="hidden" name="yhId" id="yhId" value="">
        </form>
        <a href="javascript:void(0);" @click="goPay" class="pay-link">点击支付</a>
    </div>
</template>

<script type="text/ecmascript-6">
    import Lib from 'assets/js/Lib';
    export default {
        components: {

        },
        data () {
            return {

            }
        },
        methods: {
            goPay:function(){
                document.getElementById('payForm').submit();
            }
        }
    }
</script>

<style lang="scss">

    $baseFontSize: 75px;
    @function pxToRem($px){
    @return $px / $baseFontSize * 1rem;
    }

    @mixin font-dpr($font-size)
    {
        font-size: $font-size;
        [data-dpr="2"] & { font-size: $font-size * 2; }
        [data-dpr="3"] & { font-size: $font-size * 3; }
    }
    html,body{
        height:100%;
    }
    body{
        background-color: #fff;
    }
    .pay-link{
        width:pxToRem(200px);
        height:pxToRem(100px);
        display: block;
        background-color: red;
        color:#fff;
        text-align:center;
        line-height:pxToRem(100px);
    }

</style>