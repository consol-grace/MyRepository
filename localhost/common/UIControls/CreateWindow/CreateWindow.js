
///创建动态层
function AppendList() {

    var obj = window.parent.div_parent_content;
    if (obj == undefined || obj == null) {

        var div = document.createElement("div");
        div.setAttribute("id", "div_parent_content");
        div.setAttribute("style", "display:none; position:absolute; border:solid 1px #B3C4DA;border-radius:5px 5px 5px 5px;z-index:9998;top:0%; left:0%; width:800px; padding:5px;  height:350px; background-image:url('/common/uicontrols/ajaxservice/cont_bg.png');box-shadow: 1px 1px 15px #999; -moz-box-shadow: 1px 1px 15px #999; -webkit-box-shadow: 1px 1px 15px #999; background-color:#ffffff;");

        var div1 = document.createElement("div");
        div1.setAttribute("id", "div_parent_show");
        div1.setAttribute("style", "display:none;position:absolute;z-index:9997;top:0px; left:0px;width:100%; height:100%;background-color:#ccc;filter:alpha(opacity=50);opacity:0.5;");

        var div2 = document.createElement("script");
        div2.setAttribute("type", "text/javascript");
        div2.setAttribute("src", "/common/UIControls/CreateWindow/CreateWindow.js?v=" + new Date().toString());

        window.parent.form1.appendChild(div);
        window.parent.form1.appendChild(div1);
        window.parent.form1.appendChild(div2);
    }
}


///设置样式
///标题，宽，高，Form类型为Form或Alert，类容或url
function SetStyle(title, width, height, FormorAlert, content) {

    AppendList();
    var strcontent = "";
    var show = window.parent.div_parent_show;
    var obj = window.parent.div_parent_content;
    show.style.display = 'block';
    show.style.height = window.parent.document.documentElement.scrollHeight;

    width == null || width == undefined ? 500 : parseInt(width);
    height == null || height == undefined ? 250 : parseInt(height);
    obj.style.width = width + "px";
    obj.style.height = height + "px";

    var td_height = (parseInt(obj.style.height) - 22) + "px";
    if (FormorAlert == "Form") {
        strcontent = "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style='width:100%;height:100%'><tr><td style='height:18px;'><p   onmousedown='window.parent.startDrag(this,event)'  style='height:20px;line-height:20px; color: #15428B;font: bold 11px tahoma,arial,verdana;cursor:move;background:url(\"/common/UIControls/CreateWindow/icon.jpg\") no-repeat 0 0;'>";
        strcontent += "<span style='float:left;;display:block;margin-top:2px;font-size:12px; text-indent: 20px;font:bold 12px tahoma, arial, verdana, sans-serif;'>" + title + "</span><span style='float:right;background-image:url(\"/common/UIControls/CreateWindow/close_01.jpg\");width:57px;height: 15px;cursor: pointer;' onclick=\"Close(document.getElementById('div_parent_show'),document.getElementById('div_parent_content'));\">";
        strcontent += "</span></p></td></tr><tr><td id='td_content'style='vertical-align:top;border:solid 1px #B3C4DA;height:" + td_height + "'><iframe frameborder='0' id='contentframe' scrolling='auto' height='100%' width='100%' style='background-color:#fff;height:100%;' src='" + content + "'></iframe></td></tr></table>";
    }
    else {
        strcontent = "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style='width:100%;height:100%'><tr><td style='height:18px;'><p   onmousedown='window.parent.startDrag(this,event)'  style='height:20px;line-height:20px; color: #15428B;font: bold 11px tahoma,arial,verdana;cursor:move;'>";
        strcontent += "<span style='float:left;display:block;margin-top:2px;font-size:12px;font:bold 12px tahoma, arial, verdana, sans-serif; '>" + title + "</span><span style='float:right;background-image:url(\"/common/UIControls/CreateWindow/close_01.jpg\");width:57px;height: 15px;cursor: pointer;' onclick=\"Close(document.getElementById('div_parent_show'),document.getElementById('div_parent_content'));\">";
        strcontent += "</span></p></td></tr><tr><td id='td_content'style='vertical-align:top;overflow:hidden;height:" + td_height + "'><p style='line-height:25px;font-size:12px;background-color:#CCD9E8;'>" + content + "</p><p style='text-align:center'><input type='button' value='OK' style='background: url(/images/btn_save_02.jpg) -1px center;height: 22px;width: 58px;border: 0px;cursor: pointer;font-weight: bold;'></p></td></tr></table>";
    }

    obj.innerHTML = strcontent;
    obj.style.display = 'block';

    Center(obj);

}


///居中
function Center(obj) {

    var left = (parseInt(window.parent.document.body.clientWidth) - parseInt(obj.style.width == "" ? 0 : obj.style.width) - 12) / 2;
    var top = (parseInt(window.parent.document.documentElement.clientHeight) - parseInt(obj.style.height) - 12) / 2;
    obj.style.left = left + "px";
    obj.style.top = top + "px";

}


///关闭
function Close(show, content) {
    show.style.display = 'none';
    content.style.display = 'none';
    this.focus();
}



///改变窗体大小
window.onresize = function () {

    var obj = window.parent.div_parent_content;
    var show = window.parent.div_parent_show;
    show.style.height = parseInt(window.parent.document.documentElement.scrollHeight) + "px";
    Center(obj);
}


///*---------------------拖动开始----------------------------*/
var a, b;
document.onmouseup = function () {
    try {
        if (!a) return; document.all ? a.releaseCapture() : window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
        a = "";
    }
    catch (e)
    { }
};
document.onmousemove = function (d) {
    try {
        if (!a) return;
        if (!d) d = event; a.style.left = (d.clientX - b) + "px"; a.style.top = (d.clientY - c) + "px";
    }
    catch (e)
    { }
};
function startDrag(obj, e) {
    if (!document.all) {
        e.preventDefault(); //阻止默认事件 
    }
    a = obj.parentNode.parentNode.parentNode.parentNode.parentNode;
    document.all ? a.setCapture() : window.captureEvents(Event.MOUSEMOVE);
    b = e.clientX - parseInt(a.style.left); c = e.clientY - parseInt(a.style.top);
}
///*---------------------拖动结束-------------------------*/

