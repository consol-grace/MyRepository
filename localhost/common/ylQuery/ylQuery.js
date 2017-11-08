/*
* 该文件已被评论v isuals tudio Intellisense支持。
* 你不应该使用这个文件在运行时在浏览器——它仅IntelliSense只能用于设计。
* 在所有产品使用请使用标准的ylQuery库。 注: 先引用 jQuery 库
*
* 当前版本: 1.3.3
*
*
* ylQuery库 1.3.3
* http://framework.diygens.com/ylQuery
*
* 版权所有 2011, Yulin ( Richard )
*
* Date: 2011-07-01
*/

/*
* ylQuery库成员、字段、变量、常量
* 
* 01 ylQuery.Browser()
* 02 ylQuery.Controller(Map, Function)
* 03 ylQuery.QueryString(String)
* 04 ylQuery.ContextPath
* 05 new ylQuery.DataTable(String)
* 06 ylQuery.Window.Open("http://mail.qq.com", {w: 500, h: 400}); 或者 ylQuery.Window.Dialog("http://mail.qq.com", {w: 500, h: 400});
* 07 ylQuery.Dialog
* 08 ylQuery.Uploadify
* 09 ylQuery.GetRandom
* 
*/
/// <reference path="jquery.ui.custom/js/jquery-1.4.1.js" />
/// <reference path="jquery.ui.custom/js/jquery-ui-1.8.14.custom.min.js" />


        
(function(winddow, undefined) {

    var _GetRandom = function() {
        /// <summary>获取 随机数，
        /// 例:
        ///     var iRnd = Myplugin.RandomGET();
        /// </summary>
        /// <returns type="string">j随机数 字串</returns>

        var a = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "Z", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "_");
        var b = "";
        for (i = 1; i <= 13; i++) {
            b = b + a[Math.floor(Math.random() * 63)];
        }
        return b;
    }

    var _Window = function() {
        /// <summary>窗体对象</summary>

        var features = "", opts = { WinName: "", width: 900, height: 600 };
        this.Open = function(url) {
            /// <summary>打开新窗体
            /// &#10; 01  ylQuery.Window.Open("http://mail.qq.com");
            /// &#10; 02  ylQuery.Window.Open("http://mail.qq.com", {w: 500, h: 400});
            /// </summary>

            opts = arguments[0] ? arguments[0] : opts;
            features += "width=" + opts.width + "px";
            features += ", height=" + opts.height + "px";
            features += ", top=" + (screen.availHeight - opts.h) / 2 + "px";
            features += ", left=" + (screen.availWidth - opts.w) / 2 + "px";
            features += ", scrollbars=yes";
            features += ", resizable=yes";
            window.open(url, opts.WinName, features);
        }

        this.Dialog = function(url) {
            /// <summary>打开模式新窗体
            /// &#10; 01  ylQuery.Window.Dialog("http://mail.qq.com");
            /// &#10; 02  ylQuery.Window.Dialog("http://mail.qq.com", {w: 500, h: 400});
            /// </summary>

            opts = arguments[0] ? arguments[0] : opts;
            features += "dialogWidth:" + opts.width + "px";
            features += "; dialogHeight:" + opts.height + "px";
            features += "; dialogTop:" + (screen.availHeight - opts.h) / 2 + "px";
            features += "; dialogLeft:" + (screen.availWidth - opts.w) / 2 + "px";
            features += "; status:no";
            window.showModalDialog(url, opts.WinName, features);
        }
    }

    var _DataTable = function(tableId) {
        /// <summary> DataTable 对象,
        /// &#10; 例:
        /// &#10;     $(document).ready(function() {
        /// &#10;         var row, dt = new ylQuery.DataTable("table-list");
        /// &#10;         dt.Clear();
        /// &#10;
        /// &#10;         row = new dt.NewRow();
        /// &#10;         row.Add("值 011");
        /// &#10;         row.Add("值 012");
        /// &#10;         row.Add("值 013");
        /// &#10;         dt.Rows.Add(row);
        /// &#10;
        /// &#10;         row = new dt.NewRow();
        /// &#10;         row.Add("值 011");
        /// &#10;         row.Add("值 012");
        /// &#10;         row.Add("值 013");
        /// &#10;         dt.Rows.Add(row);
        /// &#10;
        /// &#10;         row = new dt.NewRow();
        /// &#10;         row.Add("值 011");
        /// &#10;         row.Add("值 012");
        /// &#10;         row.Add("值 013");
        /// &#10;         dt.Rows.Add(row);
        /// &#10;
        /// &#10;         dt.AcceptChanges();
        /// &#10;     });
        /// </summary>
        /// <param name="tableId" type="String">table对象id</param>

        var pTable = tableId, pRow = "", pColumn = "";
        this.Clear = function() {
            /// <summary> 清除 HTML 标签 TABLE 对象所有资料,
            /// 例:
            ///     var dt = new ylQuery.DataTable("table-list");
            ///     dt.Clear();
            /// </summary>
            /// <returns>DataTable对象</returns>

            $("#" + pTable + " tr:gt(0)").remove();
            this.Rows.Clear();
            return this;
        }

        // 新行
        _NewRow = function() {
            var row = "";
            this.Clear = function() {
                row = "";
                return this;
            }
            this.Add = function(html) {
                if (arguments[1])
                    row += "<td id='" + arguments[1] + "'>&nbsp;" + html + "</td>";
                else
                    row += "<td>&nbsp;" + html + "</td>";
                return this;
            }
            this.Get = function() {
                return row;
            }
        }
        this.NewRow = _NewRow;

        // 行
        this.Rows = { Count: 0
            , Clear: function() {
                pRow = "";
            }
            , Add: function(row) {
                this.Count++;
                if (arguments[1])
                    pRow += "<tr id='" + arguments[1] + "'>" + row.Get() + "</tr>";
                else
                    pRow += "<tr>" + row.Get() + "</tr>";
                row.Clear();
            }
            , Get: function() {
                return pRow;
            }
        }

        // 接收更改
        this.AcceptChanges = function() {
            jQuery("#" + pTable).append(jQuery(this.Rows.Get()));
            this.Rows.Clear();
        }

    }   // DataTable 结束

    var _ContextPath = function() {
        /// <summary>自动识别网站路径或虚拟路径
        /// &#10; 例: alert(ylQuery.ContextPath);
        /// </summary>
        /// <returns>网站路径或虚拟路径</returns>

        var _ContextPath = "/", strUrl = "/";
        strUrl = window.location.href.replace("http://", "").replace("https://", "");
        if (strUrl.indexOf("localhost:") != -1)
            _ContextPath = "/";
        else {
            if (strUrl.indexOf("localhost") != -1) {
                strUrl = strUrl.substring(strUrl.indexOf("/") + 1, strUrl.length);
                _ContextPath = "/" + strUrl.substring(0, strUrl.indexOf("/") + 1);
            }
        }
        return _ContextPath;
    }

    var _QueryString = function(key) {
        /// <summary>获取地址栏值( http://localhost:81/ylQuery/index.htm?id=1 )
        /// &#10; 例: var id = ylQuery.QueryString("id");
        /// </summary>
        /// <param name="key" type="String">Url参考键值对键名</param>

        var value = ""; 									//获取当前文档的URL,为后面分析它做准备	
        var sURL = window.document.URL;
        if (sURL.indexOf("?") > 0)								//URL中是否包含查询字符串
        {
            var arrayParams = sURL.split("?");                  //分解URL,第二的元素为完整的查询字符串, 即arrayParams[1]的值为【first=1&second=2】
            var arrayURLParams = arrayParams[1].split("&");     //分解查询字符串, arrayURLParams[0]的值为【first=1 】, arrayURLParams[2]的值为【second=2】		
            for (var i = 0; i < arrayURLParams.length; i++)		//遍历分解后的键值对
            {
                var sParam = arrayURLParams[i].split("="); 	//分解一个键值对
                if ((sParam[0] == key) && (sParam[1] != "")) {
                    value = sParam[1]; 						//找到匹配的的键,且值不为空
                    break;
                }
            }
        }
        return value;
    }

    var _Controller = function(opts, callback) {
        /// <summary>AJAX-FORM 无刷新资料提交,
        /// &#10; function DSearch()
        /// &#10; {
        /// &#10;       ylQuery.Controller({regionId:"pForm", url:"DataController.ashx?option=add"}, function(data){
        /// &#10;           var json = $.parseJSON(data);
        /// &#10;           $("#table-data-list tr:gt(0)").remove();
        /// &#10;           $.each(json, function(i){
        /// &#10;               var rowItem = "";
        /// &#10;               rowItem += "<tr>";
        /// &#10;               rowItem += "    <td><a href="javascript:void(0)" onclick='alert("M101")'>M101</a></td>";
        /// &#10;               rowItem += "    <td>系统管理</td>";
        /// &#10;               rowItem += "    <td>System Manager</td>";
        /// &#10;               rowItem += "</tr>";
        /// &#10;               $("#table-data-list").append(rowItem);
        /// &#10;           });
        /// &#10;       });
        /// &#10; }
        /// </summary>
        /// <param name="opts" type="Map">opts: {form:"table-add", url:"DataController.ashx?option=add"}</param>
        /// <param name="callback" type="Function">callback: function(data){ var json = $.parseJSON(data); if(json[0].Option=="true"){ alert(json[0].Message); } else { alert(json[0].Message); } }</param>

        if (opts.form) {
            var pForm = null, tmpId = null;
            if (typeof (opts.form) == "string") {
                pForm = jQuery("#" + opts.form);
                tmpId = opts.form;
            }
            if (typeof (opts.form) == "object") {
                pForm = jQuery(opts.form);  // Hyperlink in table column applications ( this.parentNode.parentNode )
                tmpId = "DG_" + ylQuery.GetRandom();
            }
            jQuery('<div style="position:absolute;z-index:100;width:auto;height:auto;display:none;" id="pMask' + tmpId + '"></div>').appendTo(jQuery(document.body));

            var pos = pForm.offset();
            var w = pForm.width(), h = pForm.height(), t = parseFloat(pos.top) + 3, l = parseFloat(pos.left) + 3;
            var pMask = jQuery("#pMask" + tmpId); pMask.css({ "top": pos.top + "px", "left": pos.left + "px", "width": w + "px", "height": h + "px" });
            jQuery(pMask).addClass("RegionMask").css("display", "block");

            var content1 = null;
            if (!opts.selector || opts.selector == "") {
                content1 = "";
            }
            else {
                content1 = typeof (opts.selector) == "object" ? $(opts.selector) : $("#" + opts.selector);
                content1 = content1.clone();
            }

            var form1 = $("<form></form>"), data = pForm.serialize() ? pForm.serialize() : form1.append(pForm.clone()).append(content1).serialize(); form1.remove();
            jQuery.ajax({ type: 'POST'
                , url: opts.url
                , data: data
                , success: function(result) { callback.call(new Object(), result); }
                , error: function(message) { alert(message); }
            });
            jQuery("#pMask" + tmpId).remove();
        }
    }   // Controller 结束

    var _Browser = function() {
        /// <summary>浏览器信息
        /// &#10; 例:
        /// &#10; var browser = ylQuery.Browser();
        /// &#10; alert(browser.version);
        /// &#10; -------------------------------------------------
        /// &#10; 01 version: 版本号
        /// &#10; 02 safari: 苹果浏览器
        /// &#10; 03 opera: Opera 浏览器
        /// &#10; 04 firefox: 火狐浏览器
        /// &#10; 05 msie: Microsoft Internet Explorer 浏览器
        /// &#10; 06 mozilla: 火狐浏览器
        /// &#10; 07 chrome: 谷歌浏览器
        /// </summary>
        /// <returns>Browser对象</returns>

        var browserName = navigator.userAgent.toLowerCase();
        return {
            version: (browserName.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [0, '0'])[1],
            safari: /webkit/i.test(browserName) && !this.chrome,
            opera: /opera/i.test(browserName),
            firefox: /firefox/i.test(browserName),
            msie: /msie/i.test(browserName) && !/opera/.test(browserName),
            mozilla: /mozilla/i.test(browserName) && !/(compatible|webkit)/.test(browserName) && !this.chrome,
            chrome: /chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName)
        }
    }

    // 有待完善
    var _Dialog = function() {
        this.Close = function() {
            $("#utility-dialog").remove();
            $("#utility-dialog-masker").remove();
        }
        this.Open = function(UrlOrHtml, opts) {
            /// <summary>
            ///
            /// </summary>
            this.Close();
            if (!opts) opts = {};
            if (!opts.width) opts.width = "980";
            if (!opts.height) opts.height = "560";
            if (!opts.Caption) opts.Caption = "";

            if (isFirefox = navigator.userAgent.indexOf("Firefox") > 0) {
                // 位置定义
                var topOrleft = "";
                topOrleft += "; top: " + (screen.availHeight - opts.height) / 16 + "px";
                topOrleft += "; left: " + (screen.availWidth - opts.width) / 2 + "px";
                var ifmHeight = (parseInt(opts.height) - 54);
            }
            else {
                function pointerY() {
                    return event.pageY || (event.clientY + (document.documentElement.scrollTop || document.body.scrollTop));
                }
                var delHeight = (opts.height >= event.clientY) ? event.clientY : event.clientY / 1.5;
                var nowHeight = pointerY() - delHeight;
                // 位置定义
                var topOrleft = "";
                topOrleft += "; top: " + nowHeight + "px";
                topOrleft += "; left: " + (((document.body.clientWidth - opts.width) / 2) + (document.body.scrollWidth - document.body.clientWidth)) + "px";
                var ifmHeight = (parseInt(opts.height) - 25);
            }
            // 宽、高度
            var vitualwidth = (opts.width - 15);
            opts.width = opts.width + "px";
            opts.height = opts.height + "px";


            var html = "";
            html += '<div id="utility-dialog-masker" style="position:absolute; z-index:99; top:0px; left:0px; filter:alpha(opacity=81); -moz-opacity:0.81; opacity:0.81;background-color:#efefef;width:' + document.documentElement.scrollWidth + 'px;height:' + (document.documentElement.scrollHeight + ifmHeight / 3) + 'px"></div>';
            html += '<div id="utility-dialog" style="position:absolute;z-index:100;margin-top:8px;width:' + opts.width + ';height:' + opts.height + topOrleft + '">';
            html += '   <div id="div_window">';
            html += '       <div id="div_window01">';
            html += '       <div id="div_window_title"><div id="div_window_button" onclick=\'ylQuery.Dialog.Close()\' style="cursor:pointer;"></div>{Caption}</div>';
            html += '       <div id="div_window02"><div id="div_window03">';
            html += '   <div style="width: ' + vitualwidth + '; height: ' + ifmHeight + '">';
            html += '       {html}';
            html += "   </div>";
            html += "</div></div></div></div></div>";
            // 内容填充
            var urlurl = UrlOrHtml; 
            var Extension = UrlOrHtml.substring(UrlOrHtml.lastIndexOf("."), UrlOrHtml.length);
            if (UrlOrHtml.indexOf("?") != -1) {
                Extension = UrlOrHtml.substring(0, UrlOrHtml.indexOf("?"));
                var Extension = Extension.substring(Extension.lastIndexOf("."), Extension.length);
            }
            if ((".aspx|.asp|.htm|.html|.ashx").indexOf(Extension) != -1) UrlOrHtml = '<iframe id=fer567fgh frameborder="0" style="width: ' + vitualwidth + 'px; height: ' + ifmHeight + 'px" src="' + UrlOrHtml + '"></iframe>';
            html = html.replace("{Caption}", opts.Caption);
            html = html.replace("{html}", UrlOrHtml);
            $(document.body).append(html);
            $("#utility-dialog").css("cursor", "move").draggable();
            var ieset = navigator.userAgent;
            if (ieset.indexOf("MSIE 6.0") > -1) {
                fer567fgh.location.href = urlurl;
            }
        }
    }

    var _Uploadify = function(opts, callback) {
        if (!opts.dialog) opts.dialog = ylQuery.Dialog;
        if (!opts.language) opts.language = "CHS";
        if (!opts.title) opts.title = "上传文件";
        if (!opts.width) opts.width = 600;
        if (!opts.height) opts.height = 480;
        if (!opts.orderId) opts.orderId = "DIY1000000000000";
        if (!opts.tableName) opts.tableName = "FW_Uploadify_01";
        if (!opts.authorityId) opts.authorityId = "12345678";

        opts.dialog.Open(ylQuery.ContextPath + "Common/ylQuery/Uploadify" + opts.language + "/Uploadify.aspx?Option=init-data&OrderID=" + opts.orderId + "&TableName=" + opts.tableName + "&AuthorityID=" + opts.authorityId, { title: opts.title, width: opts.width, height: opts.height });
    }

    var CheckboxChoic = function() {
        // chkAll 全选
        this.ChoiceAll = function(chkAllID, chkItemName) {
            $("#" + chkAllID).click(function() {
                var chkItem = $("input[name=" + chkItemName + "]");
                if (this.checked == true)
                    chkItem.each(function(i) { this.checked = true; });
                else
                    chkItem.each(function(i) { this.checked = false; });
            });
        }
        // 单选为全部选中，则全选为选中，否则反之
        this.ChoicItem = function(chkAllID, chkItemName) {
            var chkItem = $("input[name=" + chkItemName + "]");
            chkItem.click(function() {
                var chkLength = 0, chkCount = 0;
                chkLength = document.getElementsByName(chkItemName).length;
                chkItem.each(function(i) { if (this.checked == true) chkCount++; });
                if (chkLength == chkCount) ylQuery.$(chkAllID).checked = true; else ylQuery.$(chkAllID).checked = false;
            });
        }
    }

    // 数据表单验证
    var _DataValid = function() {
        /// <summary>数据表单验证</summary>

        // 正则表达式
        this.IsRegExp = function(strString, validId) {
            switch (validId.toString().toLowerCase()) {
                case "english": 				// 英文字母
                    regex = /^[a-zA-Z]+$/;
                    break;
                case "chinese": 				// 中文字符
                    regex = /^[\u4E00-\u9FA5]*$/;
                    break;
                case "int": 				// 整数
                    regex = /^\d+$/;
                    break;
                case "float":
                case "double":
                case "numeric": 			// 数值
                    regex = /^(-?\d+)(\.\d+)?$/;
                    break;
                case "+int": 				// 正整数
                    regex = /^(\d+)(\.\d+)?$/;
                    break;
                case "float-dot2":
                case "double-dot2":
                case "numeric.2": 				// 数值[小数为2位]
                    regex = /^(-?\d+)(\.\d{2})$/;
                    break;
                case "numeric.3": 				// 数值[小数为3位]
                    regex = /^(-?\d+)(\.\d{3})$/;
                    break;
                case "numeric.4": 				// 数值[小数为4位]
                    regex = /^(-?\d+)(\.\d{4})$/;
                    break;
                case "email": 				// Email地址
                    regex = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
                    break;
                case "date.chs": 				// 公元日期
                    regex = /^(\d{2,4}\-\d{1,2}\-\d{1,2})?(\d{2,4}\/\d{1,2}\/\d{1,2})?$/;
                    break;
                case "date.cht": 				// 民国日期
                    regex = /^(\d{3,3}\-\d{1,2}\-\d{1,2})?(\d{3,3}\/\d{1,2}\/\d{1,2})?$/;
                    break;
                case "image": 				// 图片文件格式				
                    //regex = /^(-?\w(-?\w)+(-?\.(gif|jpg|jpeg|png|bmp|swf)))?$/ig ;
                    regex = /(\w+(-\w+)*)(\.(gif|jpg|png))$/g;
                    break;
                case "telephone": 			// 校验普通电话、传真号码：可以“+”开头，除数字外，可含有“-”
                    regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
                    break;
                case "mobile": 			// 手机号码
                    regex = /^(13\d|15\d|18\d)\d{8}$/;
                    break;
                case "ip": 			// IP地址
                    regex = /^\d{1,3}[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$/;
                    break;
                case "time": 			// 时间
                    regex = /^\d{1,2}[:]\d{1,2}[:]\d{1,2}$/;
                    break;
                case "zipcode": // 邮政编号
                    regex = /^\d{6}/;
                    break;
                case "tel_mobile": // 电话 或 手机 号码验证
                    regex = /^([+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12}))|((13\d|15\d|18\d)\d{8})$/;
                    break;

                default: 			// 空值
                    if (strString.length == "" || strString == "null") { return false; } else { return true; }
                    break;
            }
            return regex.test(strString);
        }
        this.Form = function(obj, message, validType) {
            /// <summary>表单（form）数据验证,
            /// &#10;例:
            /// &#10;    if (!MyPlugin.DataValid.Form($("#SUPPLIER_NAME"), "请输入供应商名称！", "null")) { $("#SUPPLIER_NAME").focus(); return false; }
            /// &#10;    或 if (!MyValid.Form($("#TELPHONE"), "请输入正确格式的联系电话！", "telephone")) { $("#TELPHONE").focus(); return false; }
            /// &#10;    或 if (!MyValid.Form($("#EMAIL"), "请输入正确格式的电子邮箱！", "email")) { $("#EMAIL").focus(); return false; }
            /// </summary>
            /// <param name="obj" type="object">$("#ID")产生的对象</param>
            /// <param name="message" type="string">提示的信息</param>
            /// <param name="validType" type="string">
            /// &#10; 验证类型:
            /// &#10;   english=英文字母,       chinese=中文字符,       int=整数,
            /// &#10;   numeric=数值,           +int=正整数,            numeric.2=数值[小数为2位],
            /// &#10;   email=Email地址,        data.chs=公元日期,      date.cht=民国日期,
            /// &#10;   image=图片文件格式,     telephone=电话、传真号码：可以“+”开头，除数字外，可含有“-”
            /// &#10;   mobile=手机号码,        ip=IP地址,              time=时间,
            /// &#10;   zipcode=邮政编号,       tel_mobile=电话 或 手机 号码验证
            /// </param>
            /// <returns type="bool">数据是否符合要求: true=是, false=否</returns>
            var bTF = false;
            if (this.IsRegExp(obj.val(), validType)) bTF = true; else alert(message);
            return bTF;
        }
    }

    window.ylQuery = { $: function(v) { return document.getElementById(v); }
        , Browser: _Browser
        , Controller: _Controller
        , QueryString: _QueryString
        , ContextPath: _ContextPath()
        , DataTable: _DataTable
        , Window: new _Window()
        , Dialog: new _Dialog()
        , Uploadify: _Uploadify
        , GetRandom: _GetRandom
        , DataValid: new _DataValid()
        , Checkbox: new CheckboxChoic()
    }
})(window);
