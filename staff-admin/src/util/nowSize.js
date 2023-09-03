// 换算方法
const nowSize = (val, initWidth = 1920)=>{
      var nowClientWidth = document.documentElement.clientWidth;
        return val * (nowClientWidth / initWidth);
      }

export {
  nowSize
};
