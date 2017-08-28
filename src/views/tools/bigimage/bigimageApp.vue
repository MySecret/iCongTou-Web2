<template>
  <div class="mainWarp">
	<hb-head headfont="图片"></hb-head>
    
    <div class="bgfff martop10 pad10 font14 color666">
    	<p>
    		这里展示了多页面模块下放静态文件
    	</p>
        <p>
          {{message}}
        </p>
    </div>
    
    <div class="martop10">
    	<img src="./assets/bg.jpg" alt="" />
    </div>
    

    
  </div>
</template>

<script>

import Lib from 'assets/js/Lib';

import HbHead from 'components/HbHead';

export default {

  components: {
    HbHead
  },
  data () {
    return {
      message:''
    }
  },
  methods: {

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

p{
  font-size:pxToRem(60px);
}
img{
	max-width:100%;
}

</style>
