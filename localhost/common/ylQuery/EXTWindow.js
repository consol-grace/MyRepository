
/**
* ExtWindow.CreateWin({}); // 常规调用方式window.parent.top.ExtWindow.CreateWin({id:'winAutoMakeHBL'});
*/

(function (window, $) {

    var fakemr = {};

    /**
    * ExtWindow.CreateWin({})
    */
    fakemr.CreateWin = function (attrs) {
        var ops = $.extend(fakemr.dft, attrs); //这个方法可以合并并且替换返回的是属性集合
        var win = new Ext.Window(ops);
        win.load("http://" + window.location.host + ops.url);
        win.show();
    };

    fakemr.dft = { //属性集合
        //以下为该插件的属性及其默认值   
        id: 'EXTWindow',
        title: 'EXT Window', // 标题
        X: 200, //横向位置
        Y: 160,
        width: 750,
        height: 300,
        resizable: false, //更改窗体大小
        draggable: true, //拖动
        maximizable: false, //最大化按钮
        bodyStyle: 'background-color:#fff', //body元素的CSS样式
        modal: true, //对其后面的一切内容进行遮罩
        closeAction: "close", //关闭
        hidden: true, 
        url: "",
        shadow: true //阴影

    };

    window.ExtWindow = fakemr;
})(window, jQuery);