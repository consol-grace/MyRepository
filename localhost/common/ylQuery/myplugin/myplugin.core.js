/// <reference path="../myplugin/jquery-1.4.1.js" />
/// <reference path="../myplugin/jquery.ui.custom.js" />

/* 
* 描述: 自撰、jQuery扩展脚本库
* 作者: robert     MSN: robert@diygens.com     Email: robert@diygens.com     QQ: 1055210005
*/
document.writeln('<div style="position:absolute;z-index:100;width:auto;height:auto;display:none;" id="pContainer"></div>');
document.writeln('<div style="position:absolute;z-index:99;width:auto;height:auto;display:none;" id="pMasker"></div>');

(function(window, undefined) {
    var repeater;

    // WebService 对象   作者: Richard ( 2011-01-17 )
    var WebService = function(Url, WebMethed, opts, callsuccess, callerror) {
        /// <summary>
        /// JS 脚本库
        /// -------------------------------
        ///     Myplugin.WebService("http://frame.diygens.com/myplugin.asmx", "TestMethod", {data:'{Option:"list", chkItem:"101,102,103"}'}, function(result){ alert(result); }, function(error){ alert(error); });
        ///
        /// wservice.asmx 页面
        /// -------------------------------
        ///     [System.Web.Script.Services.ScriptService]
        ///     public class myplugin : WebServiceBase
        ///     {
        ///         public string TestMethod(string Option, string chkItem)
        ///         {
        ///             return "{\"Option\":\""+ Option +"\", \"chkItem\":\""+ chkItem +"\"}";
        ///         }
        ///     }
        /// 
        /// </summary>
        /// <param name="Url" type="String">http://frame.diygens.com/myplugin.asmx</param>
        /// <param name="WebMethed" type="String">TestMethod</param>
        /// <param name="opts" type="Map">{contentType:("xml" or "json"), data:'{"Option":"list", "chkItem":"101,102,103"}' }</param>
        /// <param name="callsuccess" type="function">function(result){ alert(result); }</param>
        /// <param name="callerror" type="function">function(error){ alert(error); }</param>

        opts.type = "POST";
        opts.async = false;
        opts.data = !opts.data ? '{}' : opts.data;
        opts.url = Url.substr(Url.length - 1, 1).indexOf("/") != -1 ? Url + WebMethed : Url + "/" + WebMethed;
        opts.dataType = !opts.dataType ? "json" : opts.dataType;
        if (opts.dataType == "json") opts.contentType = "application/json; charset=utf-8";

        if (callsuccess) {
            opts.success = function(result) {
                var data = opts.dataType == "json" ? result.d : result;
                callsuccess.call(new Object(), data);
            }
        }
        if (callerror) {
            opts.error = function(result, status) {
                if (status == 'error') callerror.call(new Object(), result.responseText);
            }
        }

        $.ajax(opts);
    } // WebService 对象   End

    // Dialog 对象   作者: Richard ( 2011-01-18 )
    var Dialog = function() {
        var _dialog, _opts = {}, _buttons = {}, _url, _width, _height, _caption, _background, _opacity;
        var $dialog = function(html) {
            /*_opts = { title: _caption
            , autoOpen: true
            , width: _width
            , height: _height
            , modal: true
            , resizable: true
            , autoResize: true
            , buttons: { OK: function() { alert("OK"); }, Cancel: function() { alert("Cancel"); } }
            , overlay: {
            opacity: _opacity,
            background: _background
            }
            };*/

            _dialog = $(html).dialog(_opts);
            _dialog.width(_width).height(_height);
            return _dialog;
        }
        // 创建一个对话框会话
        this.Create = function(opts) {
            /// <summary>创建一个对话框会话
            /// 例01:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框", url: "http://frame.diygens.com" });
            ///     var dgWin = dialog.Open(); // 打开对话框
            ///     dialog.Close(dgWin); // 关闭对话框
            ///     或
            ///     dialog.Close();
            ///
            /// 例02:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框", width: 500, height: 300, url: "http://frame.diygens.com" });
            ///     var dgWin = dialog.Open(); // 打开对话框
            ///     dialog.Close(dgWin); // 关闭对话框
            ///     或
            ///     dialog.Close();
            /// </summary>
            /// <param name="opts" type="Map"></param>
            /// <returns type="Dialog" />

            _url = opts.url ? opts.url : "http://frame.diygens.com";
            _width = opts.width ? opts.width : 500;
            _height = opts.height ? opts.height : 400;
            _caption = opts.caption ? opts.caption : "请输入标题";
            _opacity = opts.opacity ? opts.opacity : 0.5;
            _background = opts.background ? opts.background : "black";
            _buttons.YClick = opts.YClick ? opts.YClick : undefined;
            _buttons.XClick = opts.XClick ? opts.XClick : undefined;

            _opts.autoOpen = true;
            _opts.modal = true;
            _opts.resizable = true;
            _opts.autoResize = true;
            _opts.title = _caption;
            _opts.width = _width;
            _opts.height = _height;
            _opts.overlay = {
                opacity: _opacity,
                background: _background
            };

            if (_buttons.YClick) _opts.buttons = { "确定": _buttons.YClick };
            if (_buttons.XClick) _opts.buttons = { "取消": _buttons.XClick };
            if (_buttons.YClick && _buttons.XClick) {
                _opts.buttons = { "确定": _buttons.YClick
                    , "取消": _buttons.XClick
                };
            }

            return this;
        }
        this.MsgBox = function() {
            /// <summary>打开对话框
            /// 例01:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框" });
            ///     或
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框", width: 300, height: 200 });
            ///     var dgWin = dialog.MsgBox(); // 打开对话框
            ///     dialog.Close();
            ///
            /// 例02:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框" });
            ///     var dgWin = dialog.MsgBox("请输入名称!"); // 打开对话框
            ///     dialog.Close();
            ///
            /// 例03:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框" });
            ///     var dgWin = dialog.MsgBox("请输入名称!"，function(){ alert("您点选了[确定]按钮!"); }); // 打开对话框
            ///     dialog.Close();
            ///
            /// 例04:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框" });
            ///     var dgWin = dialog.MsgBox("请输入名称!"，function(){ alert("您点选了[确定]按钮!"); },function(){ alert("您点选了[取消]按钮!"); }); // 打开对话框
            ///     dialog.Close();
            /// </summary>
            /// <returns type="Dialog" />

            _caption = _caption && _caption != "请输入标题" ? _caption : "温馨提示";
            _width = _width && _width != 500 ? _width : 380;
            _height = _height && _height != 400 ? _height : 150;
            _html = arguments[0] ? arguments[0] : "欢迎来到: <a target='_blank' href='http://frame.diygens.com'>frame.diygens.com</a> !";

            _buttons.YClick = arguments[1] ? arguments[1] : undefined;
            _buttons.XClick = arguments[2] ? arguments[1] : undefined;
            if (_buttons.YClick) _opts.buttons = { "确定": _buttons.YClick };
            if (_buttons.XClick) _opts.buttons = { "取消": _buttons.XClick };
            if (_buttons.YClick && _buttons.XClick) {
                _opts.buttons = { "确定": _buttons.YClick
                    , "取消": _buttons.XClick
                };
            }

            var panel = ("<div>{html}</div>").replace("{html}", _html);
            _dialog = $dialog(panel);
            _dialog.dialog("open");
            return _dialog;
        }
        this.Open = function() {
            /// <summary>打开对话框
            /// 例:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框", url: "http://frame.diygens.com" });
            ///     var dgWin = dialog.Open(); // 打开对话框
            /// </summary>
            /// <returns type="Dialog" />

            var iframe = ("<iframe style='width:100%;height:100%;' frameborder=\"0\" src=\"{url}\"></iframe>").replace("{url}", _url);
            _dialog = $dialog(iframe);
            _dialog.dialog("open");
            //_dialog.width(_width).height(_height).dialog("open");
            return _dialog;
        }
        this.Close = function() {
            /// <summary>关闭对话框, Close([dialog dgWin])
            /// 例:
            ///     var dialog = MyPlugin.Dialog.Create({ caption: "我的对话框", url: "http://frame.diygens.com" });
            ///     var dgWin = dialog.Open(); // 打开对话框
            ///     dialog.Close(dgWin); // 关闭对话框
            ///     或
            ///     dialog.Close();
            /// </summary>
            _dialog = arguments[0] ? arguments[0] : _dialog;
            _dialog.dialog("close");
            _dialog.dialog("destroy");
        }
    } // Dialog 对象   End

    // Json 对象   作者: Richard ( 2011-01-18 )
    var Json = function() {
        var strJson = ",\"{k}\":\"{v}\"", contents = "";
        // 添加 json 数据项
        this.Add = function(key, value) {
            /// <summary>添加 json 数据项，
            /// 例01:
            ///     var strJson = MyPlugin.Json.Add("name","richard").GET(); // json 字串
            ///     alert(strJson);
            ///
            ///     var json = MyPlugin.Json.Add("name","richard").GetJSON(); // json 对象
            ///     alert(json.name);
            ///
            /// 例02:
            ///     var strJson = MyPlugin.Json.Add("name","richard").Add("email","richard@diygens.com").GetArray(); // json数组(长度为1) 字串
            ///     alert(strJson);
            ///
            ///     var json = MyPlugin.Json.Add("name","richard").Add("email","richard@diygens.com").GetArrayJSON(); // json 对象
            ///     alert(json[0].name);
            /// </summary>
            /// <param name="key" type="string">json 数据项键</param>
            /// <param name="value" type="string">json 数据项值</param>
            /// <returns type="Json" />

            contents += strJson.replace("{k}", key).replace("{v}", value);
            return this;
        }
        // 获取 单json数据字串
        this.GET = function() {
            /// <summary>获取 单json数据字串，
            /// 例:
            ///     var strJson = MyPlugin.Json.Add("name","richard").GET(); // json 字串
            ///     alert(strJson);
            /// </summary>
            /// <returns type="string">单json数据字串</returns>

            return "{" + contents.substring(1, contents.length) + "}";
        }
        // 获取 单json对象
        this.GetJSON = function() {
            /// <summary>获取 单json对象，
            /// 例:
            ///     var json = MyPlugin.Json.Add("name","richard").GetJSON(); // json 对象
            ///     alert(json.name);
            /// </summary>
            /// <returns type="Map">获取 单json对象</returns>

            return jQuery.parseJSON(this.GET());
        }
        // 获取 json数组(长度为1) 字串
        this.GetArray = function() {
            /// <summary>获取 json数组(长度为1) 字串，
            /// 例:
            ///     var strJson = MyPlugin.Json.Add("name","richard").Add("email","richard@diygens.com").GetArray(); // json数组(长度为1) 字串
            ///     alert(strJson);
            /// </summary>
            /// <returns type="string">json数组(长度为1) 字串</returns>

            return "[" + this.GET() + "]";
        }
        // 获取 json数组(长度为1) 对象
        this.GetArrayJSON = function() {
            /// <summary>获取 json数组(长度为1) 对象，
            /// 例:
            ///     var json = MyPlugin.Json.Add("name","richard").Add("email","richard@diygens.com").GetArrayJSON(); // json 对象
            ///     alert(json[0].name);
            /// </summary>
            /// <returns type="Map">json数组(长度为1) 对象</returns>

            return jQuery.parseJSON(this.GetArray());
        }
    } // Json 对象   End

    // Commonlib 开始
    var Common = function() {
        this.RandomGET = function() {
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
        this.FindPosX = function(obj) {
            /// <summary>Document中对象的X定位，
            /// 例:
            ///     var x = Myplugin.FindPosX("id")
            /// </summary>
            /// <returns type="string">X定位</returns>

            var curleft = 0;
            if (obj.offsetParent)
                while (1) {
                curleft += obj.offsetLeft;
                if (!obj.offsetParent)
                    break;
                obj = obj.offsetParent;
            }
            else if (obj.x)
                curleft += obj.x;
            return curleft;
        }
        this.FindPosY = function(obj) {
            /// <summary>Document中对象的Y定位，
            /// 例:
            ///     var y = $.FindPosY("id");
            /// </summary>
            /// <returns type="string">Y定位</returns>

            var curtop = 0;
            if (obj.offsetParent)
                while (1) {
                curtop += obj.offsetTop;
                if (!obj.offsetParent)
                    break;
                obj = obj.offsetParent;
            }
            else if (obj.y)
                curtop += obj.y;
            return curtop;
        }
    }
    // Commonlib 结束

    var DataTable = function() {
        /// <summary> DataTable 对象,
        /// 例:
        ///     html:
        ///     --------------------------------------------
        ///     <table id="table-list">
        ///         <tr>
        ///             <td>字段 001</td>
        ///             <td>字段 002</td>
        ///             <td>字段 003</td>
        ///         </tr>
        ///     </table>
        ///
        /// 
        ///
        ///     javascript
        ///     --------------------------------------------
        ///     $(document).ready(function() {
        ///         var row, dt = new Myplugin.DataTable();
        ///         dt.Bind("table-list").Clear();
        ///
        ///         row = new dt.NewRow();
        ///         row.Add("值 011");
        ///         row.Add("值 012");
        ///         row.Add("值 013");
        ///         dt.Rows.Add(row);
        ///
        ///         row = new dt.NewRow();
        ///         row.Add("值 011");
        ///         row.Add("值 012");
        ///         row.Add("值 013");
        ///         dt.Rows.Add(row);
        ///
        ///         row = new dt.NewRow();
        ///         row.Add("值 011");
        ///         row.Add("值 012");
        ///         row.Add("值 013");
        ///         dt.Rows.Add(row);
        ///
        ///         dt.AcceptChanges();
        ///     });
        /// </summary>

        var pTable, pRow, pColumn;
        this.Bind = function(table) {
            /// <summary> 绑定 HTML 标签 TABLE 对象,
            /// 例:
            ///     var dt = new Myplugin.DataTable();
            ///     dt.Bind("table-list").Clear();
            /// </summary>
            /// <param name="table" type="String">HTML 标签 TABLE 对象 ID</param>
            /// <returns>DataTable对象</returns>

            pTable = table;
            pRow = "";
            pColumn = "";
            return this;
        }
        this.Clear = function() {
            /// <summary> 清除 HTML 标签 TABLE 对象所有资料,
            /// 例:
            ///     var dt = new Myplugin.DataTable();
            ///     dt.Bind("table-list").Clear();
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

    // Controller
    // exmaple:   AJAX 资料管控
    /*
    aspx 或 js 頁面
    -------------------------------------------------------------------------------------------------------------
    Myplugin.Data.Controller({form:"table-add", url:"DataController.ashx?option=add"}, function(data){
    var table = document.getElementById("table-list");
    if (table.rows.length > 1) for (var i = 1; i < table.rows.length; ) table.deleteRow(table.rows(i).rowIndex);
                
    var json = $.parseJSON(data);
    var dt = Myplugin.Data.DataTable.Bind(table);
    for (var i = 0; i < json.length; i++) {
    dt.Rows.Add(json[i]);
    }
    });
   
    ashx 頁面
    -------------------------------------------------------------------------------------------------------------
    MssqlFields fields = new MssqlFields();
    fields.Add("Option", "CW_Company");
    fields.Add("PinYin", context.Request["q"]);
    dal = new MssqlDAL(MyConfigHelper.WmbtDB, "YUL_CommonDataController_SP", fields);
    DataTable dt = dal.GetList().Tables[0];
    if (dt == null && dt.Rows.Count == 0)
    {
    context.Response.Write("");
    }
    else
    {
    cflist = new CommonFields[dt.Rows.Count];
    for (int i = 0; i < dt.Rows.Count; i++)
    {
    cflist[i] = new CommonFields();
    cflist[i].Add("Code", dt.Rows[i]["RowNO"]);
    cflist[i].Add("PinYin", dt.Rows[i]["PinYin"]);
    cflist[i].Add("Abbr", dt.Rows[i]["NameCHS"]);
    }
    context.Response.Write(JScriptlib.ParseJSON(cflist));
    }
    */
    var Controller = function(opts, callback) {
        /// <summary>AJAX 资料管控,  
        /// 例:
        ///     Myplugin.Data.Controller({form:"table-add", url:"DataController.ashx?option=add"}, function(data){
        ///         var table = document.getElementById("table-list");
        ///         if (table.rows.length > 1) for (var i = 1; i < table.rows.length; ) table.deleteRow(table.rows(i).rowIndex);
        ///                           
        ///         var json = $.parseJSON(data);
        ///         var dt = Myplugin.Data.DataTable.Bind(table);
        ///         for (var i = 0; i < json.length; i++) {
        ///             dt.Rows.Add(json[i]);
        ///         }
        ///     });
        /// </summary>
        /// <param name="opts" type="Map">opts: {form:"table-add", url:"DataController.ashx?option=add"}</param>
        /// <param name="callback" type="Fn">callback: function(data){ var json = $.parseJSON(data); if(json[0].Option=="true"){ alert(json[0].Message); } else { alert(json[0].Message); } }</param>

        if (opts.form) {
            var pForm = null, tmpId = null;
            if (typeof (opts.form) == "string") {
                pForm = jQuery("#" + opts.form);
                tmpId = opts.form;
            }
            if (typeof (opts.form) == "object") {
                pForm = jQuery(opts.form);  // Hyperlink in table column applications ( this.parentNode.parentNode )
                tmpId = "DG_" + Myplugin.Common.RandomGET();
            }

            var strMask = '<div style="position:absolute;z-index:100;width:auto;height:auto;display:none;" id="pMask' + tmpId + '"></div>';
            var strData = '<div style="position:absolute;z-index:100;width:0;height:0;display:none;" id="pData' + tmpId + '"></div>';
            var strForm = '<form id="form' + tmpId + '" name="' + tmpId + '" method="post" target="ifrm' + tmpId + '" action="' + opts.url + '" style="width:0; height:0;"></form>';
            jQuery(strMask + strData).appendTo(jQuery(document.body));
            jQuery("#pData" + tmpId).html(strForm);

            // string or object
            opts.html = !opts.html ? "" : opts.html;
            if (typeof (opts.form) == "string") jQuery("#form" + tmpId).html(jQuery("#" + tmpId).html() + opts.html + '<input type="submit" id="btn' + tmpId + '" name="btn' + tmpId + '" />');
            if (typeof (opts.form) == "object") jQuery("#form" + tmpId).html(jQuery(opts.form).html() + opts.html + '<input type="submit" id="btn' + tmpId + '" name="btn' + tmpId + '" />');


            var pos = pForm.offset();
            var w = pForm.width(), h = pForm.height(), t = parseFloat(pos.top) + 3, l = parseFloat(pos.left) + 3;

            var pMask = jQuery("#pMask" + tmpId);
            pMask.css({ "top": pos.top + "px", "left": pos.left + "px", "width": w + "px", "height": h + "px" });
            jQuery(pMask).addClass("dgForm_pMask").css("display", "block");

            var checkbox = "";
            pForm.find("input[type=checkbox]").each(function(i) {
                if ($(this).attr("checked") == "checked") checkbox += "&" + $(this).attr("name") + "=" + $(this).val();
            });
            if (jQuery.browser.msie && jQuery.browser.version == "7.0") checkbox = "";
            
            jQuery.ajax({ type: 'POST', url: jQuery("#form" + tmpId).attr('action'), data: jQuery("#form" + tmpId).serialize() + checkbox,
                success: function(data) {
                    callback.call(new Object(), data);
                    jQuery("#pMask" + tmpId).remove();
                    jQuery("#pData" + tmpId).remove();
                }, error: function(message) { alert(message); jQuery("#pMask" + tmpId).remove(); jQuery("#pData" + tmpId).remove(); }
            });
        }
    }   // Controller 结束
    /*
    Myplugin.Checkbox.ChoiceAll("chkAll", "chkItem");
        
    Myplugin.Checkbox.ChoicItem("chkAll", "chkItem");
    或
    Myplugin.Checkbox.ChoicItemAll("chkAll", "chkItem"); // 权限勾选时用
    */
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
                var chkLength = 1, chkCount = 0;
                if (typeof (document.all(chkItemName).length) != 'undefined') chkLength = document.all(chkItemName).length;
                chkItem.each(function(i) { if (this.checked == true) chkCount++; });
                if (chkLength == chkCount) Myplugin.$(chkAllID).checked = true; else Myplugin.$(chkAllID).checked = false;
            });
        }
        // 单选为全部选中，则全选为选中，否则反之
        this.ChoicItemAll = function(chkAllID, chkItemName) {
            var chkItem = $("input[name=" + chkItemName + "]");
            chkItem.click(function() {
                var chkLength = 1, chkCount = 0;
                if (typeof (document.all(chkItemName).length) != 'undefined') chkLength = document.all(chkItemName).length;
                chkItem.each(function(i) { if (this.checked == true) chkCount++; });
                if (chkCount > 0) Myplugin.$(chkAllID).checked = true; else Myplugin.$(chkAllID).checked = false;

                //if (chkLength == chkCount) Myplugin.$(chkAllID).checked = true; else Myplugin.$(chkAllID).checked = false;
            });
        }
    }
    // 获取地址栏值( http://localhost/CCCRM/index.htm?id=1 )
    // 例: var id = Myplugin.QueryString("id");
    this.QueryString = function(key) {
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

    // 日历, 选择后可修改
    // 例: jQuery.MyCalender("txtDate", "yyyy-MM-dd hh:mm") 或 jQuery.MyCalender("txtDate", "yyyy-MM-dd")
    var Calender = function(ID, Format) {
        if (Format == "")
            WdatePicker({ el: ID, dateFmt: 'yyyy-MM-dd' })
        else
            WdatePicker({ el: ID, dateFmt: Format })
    }
    // 自动识别网站路径或虚拟路径
    var ContextPath = function() {
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
    /* 例: 
    Myplugin.AutoComplete("controller.ashx?option=AutoComplete", { TextID: "txtNameCHS", ValueID: "txtRowID", Splitor: "[]" });
    */
    var AutoComplete = function(UrlOrData, opts, callback) {
        if (!opts.width) opts.width = 180;
        if (!opts.height) opts.height = 300;
        if (!opts.max) opts.max = 50;

        //var UrlOrData = [{ text: 'Link A', value: '/page1' }, { text: 'Link B', value: '/page2'}];
        var txtValue = $.trim($("#" + opts.TextID).val()).length == 0 ? "%" : $("#" + opts.TextID).val();
        var data = typeof (UrlOrData) == "object" ? UrlOrData : $.ajax({ url: UrlOrData + (UrlOrData.indexOf("?") == -1 ? "?text=" : "&text=") + txtValue, async: false }).responseText;

        var json = $.parseJSON(data);

        var returnValue;
        $("#" + opts.TextID).autocomplete(json, { max: opts.max    //列表里的条目数
            , multiple: true
            , minChars: 0    //自动完成激活之前填入的最小字符
            , width: opts.width     //提示的宽度，溢出隐藏
            , scrollHeight: opts.height   //提示的高度，溢出显示滚动条
            , matchContains: true    //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
            , autoFill: false    //自动填充
            , formatItem: function(item) {
                returnValue = item.text;
                if (item.text != "")
                    returnValue = "(" + item.value + ") " + item.text;
                return returnValue;
            }
        }).result(function(event, item) {
            $("#" + opts.TextID).val(item.text);
            $("#" + opts.ValueID).val(item.value);
        });
    }

    /* <remarks>作者: Robert Yu ( 2007-11-16 ) 版权所有<remarks>
    * <summary>
    * 加载页面
    * </summary>
    * <example>
    *		<a href='#1' onclick='Myplugin.PopupPanel({obj:this ,w:500 ,h:400 ,y:18 ,url:"http://mail.163.com"});'>
    *			<img style="margin:2px 8px 0px 0px" src='<%=Publiclib.Common.ContextPath%>Common/images/view.gif'>
    *		</a> 
    *       或
    *       Myplugin.PopupPanel({option:"open",obj:this ,w:300 ,h:33 ,y:23 ,html:$("#pHblGreaterThanOne").html()});
    *       
    *       Myplugin.PopupPanel({option:"open",obj:this ,w:300 ,h:33 ,y:23 ,url:"http://frame.diygens.com"});
    * </example>
    * <param name="obj">HTML物件</param>
    * <param name="w">宽度</param>
    * <param name="h">高度</param>
    * <param name="y">Y轴偏移量</param>
    * <param name="url">加载页面</param> */
    var PopupPanel = function(opts) {
        if (opts.option.toLowerCase() == "autocomplete") {
            /// <summary>
            /// Myplugin.PopupPanel({option:"AutoComplete", TextID: "", ValueID: "", Splitor: "", url: "xxx.do?option=AutoComplete-location"})
            /// </summary>

            opts.obj = Myplugin.$(opts.TextID);
            opts.w = $("#" + opts.TextID).width() + 16;
            //if (!opts.w) opts.w = 180;
            //if (!opts.h) opts.h = 300;
            if (!opts.y) opts.y = 23;
            if (!opts.ContainerBG) opts.ContainerBG = "#ffffff";
            if (!opts.ContainerBorder) opts.ContainerBorder = "1px #BDBDBD solid";

            document.getElementById("pContainer").style.display = "block";
            document.getElementById("pContainer").style.left = parseInt(Myplugin.Common.FindPosX(opts.obj)) - 5;
            document.getElementById("pContainer").style.top = parseInt(Myplugin.Common.FindPosY(opts.obj)) + opts.y;
            document.getElementById("pContainer").style.background = opts.ContainerBG;
            document.getElementById("pContainer").style.width = "auto";
            document.getElementById("pContainer").style.height = "auto";
            document.getElementById("pContainer").style.border = opts.ContainerBorder;

            var p_error = arguments[1] ? arguments[1] : undefined;
            jQuery.ajax({ url: opts.url + (opts.url.indexOf("?") == 1 ? "?text=" : "&text=") + $("#" + opts.TextID).val()
                , async: false
                , success: function(data) {
                    //var json = [{ text: 'Link A', value: '/page1' }, { text: 'Link B', value: '/page2'}];
                    var json = $.parseJSON(data);
                    var str = "", temp = "";

                    repeater = "";
                    $.each(json, function(i) {
                        if (json[i].value != "")
                            repeater += ("<a href='javascript:void(0)' onclick='{c}'>({v}) {t}</a><br />").replace("{v}", json[i].value).replace("{t}", json[i].text)
                                .replace("{c}", "$(\"#" + opts.TextID + "\").val(\"" + json[i].text + "\"); $(\"#" + opts.ValueID + "\").val(\"" + json[i].value + "\"); $(\"#" + opts.TextID + "\").focus(); document.getElementById(\"pContainer\").style.display=\"none\"; ");
                        else {
                            repeater = "";
                            temp = $("#" + opts.TextID).val();
                            $("#" + opts.TextID).val(temp.substring(0, temp.length - 1)).click();
                            //$("#" + opts.TextID).click();
                        }
                    });
                    temp = '<div class="loadpanel-content" style="width:' + opts.w + 'px; height:auto; z-index:9999;margin:0;padding:3px;">' + repeater + '</div>'
                    str += '<div class="loadpanel-handler"><a class="a010" href="javascript:void(0);" onclick=\'document.getElementById("pContainer").style.display="none";\'>Close</a></div>';
                    str += temp;
                    document.getElementById("pContainer").innerHTML = str;
                }
                , error: function(message) {
                    if (p_error) p_error.call(new Object(), message);
                }
            });

            //$(document.body).click(function() { document.getElementById("pContainer").style.display = "none"; });            
            //$("#" + opts.TextID).blur(function() { document.getElementById("pContainer").style.display = "none"; });
        }
        if (opts.option.toLowerCase() == "open") {
            if (!opts.w) opts.w = 900;
            if (!opts.h) opts.h = 600;
            if (!opts.y) opts.y = 18;
            if (!opts.ContainerBG) opts.ContainerBG = "#ffffff";
            if (!opts.ContainerBorder) opts.ContainerBorder = "1px #BDBDBD solid";

            document.getElementById("pContainer").style.display = "block";
            document.getElementById("pContainer").style.left = parseInt(Myplugin.Common.FindPosX(opts.obj));
            document.getElementById("pContainer").style.top = parseInt(Myplugin.Common.FindPosY(opts.obj)) + opts.y;
            document.getElementById("pContainer").style.background = opts.ContainerBG;
            document.getElementById("pContainer").style.width = "auto";
            document.getElementById("pContainer").style.height = "auto";
            document.getElementById("pContainer").style.border = opts.ContainerBorder;

            var str = "", temp = "";
            if (opts.url) temp = '<iframe class="loadpanel-content" frameborder="0" src="' + opts.url + '" style="width:' + opts.w + 'px; height:' + opts.h + 'px; z-index:9999;margin:0;" />';
            if (opts.html) temp = '<div class="loadpanel-content" style="width:' + opts.w + 'px; height:' + opts.h + 'px; z-index:9999;margin:0;padding:3px;">' + opts.html + '</div>'
            if (opts.url && opts.html) temp = '<iframe class="loadpanel-content" frameborder="0" src="' + opts.url + '" style="width:' + opts.w + 'px; height:' + opts.h + 'px; z-index:9999;margin:0;" />';
            str += '<div class="loadpanel-handler"><a class="a010" href="javascript:void(0);" onclick=\'document.getElementById("pContainer").style.display="none";\'>Close</a></div>';
            str += temp;
            document.getElementById("pContainer").innerHTML = str;
        }
        if (opts.option.toLowerCase() == "close") {
            var obj = opts.levelid == 0 ? document.getElementById("pContainer") : window.parent.document.getElementById("pContainer");
            obj.style.display = "none";
        }
    }

    // ComboBox
    var _ComboBox = function(UrlOrData, opts) {
        if (!opts.TextID) opts.TextID = "#ComboBox1_T";
        if (!opts.ValueID) opts.ValueID = "#ComboBox1_V";

        //设置该页面上所有combobox的模式
        combobox.prototype.mustSelect = false; //必须选择参数,默认为false
        combobox.prototype.fieldText = "text"; //设置数据源文本命名，默认为text
        combobox.prototype.fieldValue = "value"; //设置数据源id命名，默认为id
        combobox.prototype.maxLength = 3; //自动搜索显示20项,默认为null.即不限制

        //初始化所有combobox
        //如果有多个text要改成combobox.请在text上设置class。然后id参数使用‘.class',如 combobox.prototype.init(".demos"）
        combobox.prototype.init(opts.TextID, "/Common/jquery/ComboBox/dropdown.gif");

        //绑定
        var combo = new combobox(opts.TextID, opts.ValueID);
        //// combo.dataSource = [{ id: 'i1', text: 't1' }, { id: 'i2', text: 't2' }, { id: 'i3', text: 't3' }, { id: 'i4', text: 't4' }, { id: 'i5', text: 't5'}];
        // $(opts.TextID).val()
        combo.dataSource = typeof (UrlOrData) == "object" ? UrlOrData : $.parseJSON($.ajax({ url: UrlOrData.indexOf("?") == -1 ? UrlOrData + "?q=" + $(opts.TextID).val() : UrlOrData + "&q=" + $(opts.TextID).val(), async: false }).responseText);
        //combo.defaultText = "xx";//text的默认值，默认为text的value;
        combo.dataBind();

        $(opts.TextID).keyup(function() {
            combo = new combobox(opts.TextID, opts.ValueID);
            combo.dataSource = typeof (UrlOrData) == "object" ? UrlOrData : $.parseJSON($.ajax({ url: UrlOrData.indexOf("?") == -1 ? UrlOrData + "?q=" + $(opts.TextID).val() : UrlOrData + "&q=" + $(opts.TextID).val(), async: false }).responseText);
            combo.dataBind();
        });
    }

    var _browser = function() {
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

    window.Myplugin = { ContextPath: ContextPath()
        , $: function(v) {
            /// <summary>获取 HTML 标签 对象</summary>
            /// <returns type="Element" />
            return document.getElementById(v);
        }
        , Browser: _browser()
        , Controller: Controller
        , WebService: WebService
        , Dialog: new Dialog()
        , JSON: new Json()
        , Common: new Common()
        , DataTable: DataTable
        , Checkbox: new CheckboxChoic()
        , QueryString: QueryString
        , Calender: Calender
        , AutoComplete: AutoComplete
        , PopupPanel: PopupPanel
        , ComboBox: _ComboBox

        , ContentType: { JS: 'application/x-javascript', CSS: 'text/css', HTML: 'text/html', TEXT: 'text/plain', XML: 'text/xml' }
        , DataType: { XML: "xml", JSON: "json", SCRIPT: "script", HTML: "html", TEXT: "text" }
    }
})(window);
