/// <reference path="../myplugin/jquery-1.4.1.js" />
/// <reference path="../myplugin/jquery.ui.custom.js" />

(function(Myplugin) {

    var _Dialog = function() {
        this.Open = function(UrlOrHtml, opts) {
            /// <summary>
            /// 弹出对话框, 例:
            /// &#10;01 打开: Myplugin.Utility.Dialog.Open("<div>测试!</div>");
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// &#10;
            /// &#10;02 打开: Myplugin.Utility.Dialog.Open("http://framework.diygens.com", {width: "600", height: "480"});
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// &#10;
            /// &#10;03 打开: Myplugin.Utility.Dialog.Open("http://framework.diygens.com", {width: "600", height: "480", Caption: "FRAMEWORK.DIYGENS.COM"});
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// </summary>
            ///	<param name="UrlOrHtml" type="String">
            ///		&#10;1: url - http://framework.diygens.com
            ///		&#10;2: html - A string of HTML to create on the fly.
            ///	</param>
            ///	<param name="opts" optional="true" type="Map">键/值对,将被发送到服务器</param>
            /// <param name="callback" optional="true" type="Function">The function called when the AJAX request is complete.  It should map function(responseText, textStatus, XMLHttpRequest) such that this maps the injected DOM element.</param>
            Myplugin.Utility.Dialog.Close();
            if (!opts) opts = {};
            if (!opts.width) opts.width = "980";
            if (!opts.height) opts.height = "560";
            if (!opts.Caption) opts.Caption = "";

            function pointerY() {
                return event.pageY || (event.clientY + (document.documentElement.scrollTop || document.body.scrollTop));
            }
            var delHeight = (opts.height >= event.clientY) ? event.clientY : event.clientY / 1.5;
            var nowHeight = pointerY() - delHeight;
            // 位置定义
            var topOrleft = "";
            //topOrleft += "; top: " + (screen.availHeight - opts.height) / 16 + "px";
            //topOrleft += "; left: " + (screen.availWidth - opts.width) / 2 + "px";
            //topOrleft += "; left: " + (document.body.clientWidth - opts.width) / 2 + "px";
            topOrleft += "; top: " + nowHeight + "px";
            topOrleft += "; left: " + (((document.body.clientWidth - opts.width) / 2) + (document.body.scrollWidth - document.body.clientWidth)) + "px";
            var ifmHeight = (parseInt(opts.height) - 54);
            // 宽、高度
            opts.width = opts.width.indexOf("px") == -1 ? opts.width + "px" : opts.width;
            opts.height = opts.height.indexOf("px") == -1 ? opts.height + "px" : opts.height;
            // 布局定义
            var html = "";
            html += '<div id="utility-dialog-masker" style="position:absolute; z-index:99; top:0px; left:0px; filter:alpha(opacity=81); -moz-opacity:0.81; opacity:0.81; background-color:#efefef; width:' + document.documentElement.scrollWidth + 'px;height:' + (document.documentElement.scrollHeight + ifmHeight / 3) + 'px"></div>';
            html += '<div id="utility-dialog" style="position:absolute;z-index:100;margin-top:8px;width:' + opts.width + ';height:' + opts.height + topOrleft + '">';
            html += '   <div class="utility-dialog-titlebar-bg">';
            html += '       <div class="utility-dialog-titlebar-lt"></div>';
            html += '       <div class="utility-dialog-titlebar-ct">{Caption}</div>';
            html += '       <div class="utility-dialog-titlebar-rt" title="close" onclick=\'Myplugin.Utility.Dialog.Close()\'></div>';
            html += "   </div>";
            html += '   <div style="background-color:#fff; width: ' + opts.width + '; height: ' + ifmHeight + '">';
            html += '       {html}';
            html += "   </div>";
            html += "</div>";
            // 内容填充
            var Extension = UrlOrHtml.substring(UrlOrHtml.lastIndexOf("."), UrlOrHtml.length);
            if (UrlOrHtml.indexOf("?") != -1) {
                Extension = UrlOrHtml.substring(0, UrlOrHtml.indexOf("?"));
                var Extension = Extension.substring(Extension.lastIndexOf("."), Extension.length);
            }
            if ((".aspx|.asp|.htm|.html|.ashx").indexOf(Extension) != -1) UrlOrHtml = '<iframe frameborder="0" style="width: ' + opts.width + '; height: ' + ifmHeight + 'px" src="' + UrlOrHtml + '"></iframe>';
            html = html.replace("{Caption}", opts.Caption);
            html = html.replace("{html}", UrlOrHtml);
            $(document.body).append(html);
            $("#utility-dialog").css("cursor", "move").draggable();
        }
        //
        this.Close = function() {
            /// <summary>
            /// 弹出对话框, 例:
            /// &#10;01 打开: Myplugin.Utility.Dialog.Open("");
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// &#10;
            /// &#10;02 打开: Myplugin.Utility.Dialog.Open("http://framework.diygens.com", {width: "600", height: "480"});
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// &#10;
            /// &#10;03 打开: Myplugin.Utility.Dialog.Open("http://framework.diygens.com", {width: "600", height: "480", Caption: "FRAMEWORK.DIYGENS.COM"});
            /// &#10;   关闭: Myplugin.Utility.Dialog.Close();
            /// </summary>
            $("#utility-dialog").remove();
            $("#utility-dialog-masker").remove();
        }
    }

    Myplugin.Utility = { Dialog: new _Dialog()
    }
})(Myplugin);
