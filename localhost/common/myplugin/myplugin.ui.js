/// <reference path="jquery-1.4.1.js" />
/// <reference path="jquery.ui.custom.js" />
/// <reference path="myplugin.core.js" />
/// <reference path="My97DatePicker/WdatePicker.js" />

/*
    Myplugin Data 1.1 数据
*/
(function(Myplugin, undefined) {
    // 数据表单验证
    var DataValid = function() {
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
            /// 例:
            ///     if (!MyPlugin.DataValid.Form($("#SUPPLIER_NAME"), "请输入供应商名称！", "null")) { $("#SUPPLIER_NAME").focus(); return false; }
            ///     或 if (!MyValid.Form($("#TELPHONE"), "请输入正确格式的联系电话！", "telephone")) { $("#TELPHONE").focus(); return false; }
            ///     或 if (!MyValid.Form($("#EMAIL"), "请输入正确格式的电子邮箱！", "email")) { $("#EMAIL").focus(); return false; }
            /// </summary>
            /// <param name="obj" type="object">$("#ID")产生的对象</param>
            /// <param name="message" type="string">提示的信息</param>
            /// <param name="validType" type="string">
            ///     验证类型: english=英文字母, chinese=中文字符, int=整数, numeric=数值, +int=正整数, numeric.2=数值[小数为2位], email=Email地址,
            ///     data.chs=公元日期, date.cht=民国日期, image=图片文件格式, telephone=电话、传真号码：可以“+”开头，除数字外，可含有“-”
            ///     mobile=手机号码, ip=IP地址, time=时间, zipcode=邮政编号, tel_mobile=电话 或 手机 号码验证
            /// </param>
            /// <returns type="bool">数据是否符合要求: true=是, false=否</returns>
            var bTF = false;
            if (this.IsRegExp(obj.val(), validType)) bTF = true; else alert(message);
            return bTF;
        }
    }
    var DataTable = function() {
        /// <summary>DataTable 对象</summary>
        var table = {};
        this.Rows = {};
        this.Columns = {};

        this.Bind = function(tableId) {
            /// <summary>绑定 Table 对象,
            /// 例:
            /// html 页面
            /// ----------------------------------
            /// <table id="table1">
            ///     <tr>
            ///         <td>字段1</td>
            ///         <td>字段2</td>
            ///         <td>字段3</td>
            ///     </tr>
            /// </table>
            /// 
            /// jscript 脚本
            /// ----------------------------------
            /// var data = [
            ///     [{ className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;"}]
            ///         , [{ className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;"}]
            ///         , [{ className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;" }, { className: "TAB001TD", html: "&nbsp;"}]
            ///     ];
            ///     或
            /// var data = [
            ///     [{ html: "&nbsp;" }, { html: "&nbsp;" }, { html: "&nbsp;"}]
            ///         , [{ html: "&nbsp;" }, { html: "&nbsp;" }, { html: "&nbsp;"}]
            ///         , [{ html: "&nbsp;" }, { html: "&nbsp;" }, { html: "&nbsp;"}]
            ///     ];
            ///
            /// var dt = Myplugin.Data.DataTable.Bind("table1");
            /// 或
            /// var dt = Myplugin.Data.DataTable.Bind(table1);
            ///
            /// for (var i = 0; i < data.length; i++) {
            ///     dt.Rows.Add(data[i]);
            /// }
            /// </summary>
            table = typeof (tableId) == "string" ? document.getElementById(tableId) : tableId;
            this.Rows = new _Rows(table);
            this.Columns = new _Columns(table);
            return this;
        };

        var _Rows = function(table) {
            this.Count = table.rows ? table.rows.length : 0;
            this.Add = function(data) {
                var row = table.insertRow(table.rows.length);
                for (var i = 0; i < data.length; i++) {
                    var cell = row.insertCell(i);
                    if (data[i].className) cell.className = data[i].className;
                    if (!data[i].html) data[i].html = "&nbsp;";
                    cell.innerHTML = data[i].html;
                }
                return this;
            };
        }

        var _Columns = function(table) {
            this.Count = table.rows(0) ? table.rows(0).cells.length : 0;
        }
    }
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
        /// <param name="callback" type="Function">callback: function(data){ var json = $.parseJSON(data); if(json[0].Option=="true"){ alert(json[0].Message); } else { alert(json[0].Message); } }</param>

        if (opts.form) {
            var pForm = null, tmpId = null;
            if (typeof (opts.form) == "string") {
                pForm = document.getElementById(opts.form);
                tmpId = opts.form;
            }
            if (typeof (opts.form) == "object") {
                pForm = opts.form;  // Hyperlink in table column applications ( this.parentNode.parentNode )
                tmpId = "DG_" + Myplugin.Common.RandomGET();
            }

            var strMask = '<div style="position:absolute;z-index:100;width:auto;height:auto;display:none;" id="pMask' + tmpId + '"></div>';
            var strData = '<div style="position:absolute;z-index:100;width:0;height:0;display:none;" id="pData' + tmpId + '"></div>';
            var strForm = '<form id="form' + tmpId + '" name="' + tmpId + '" method="post" target="ifrm' + tmpId + '" action="' + opts.url + '" style="width:0; height:0;"></form>';
            jQuery(strMask + strData).appendTo(jQuery(document.body));
            jQuery("#pData" + tmpId).html(strForm);

            // string or object
            if (typeof (opts.form) == "string") jQuery("#form" + tmpId).html(jQuery("#" + tmpId).html() + '<input type="submit" id="btn' + tmpId + '" name="btn' + tmpId + '" />');
            if (typeof (opts.form) == "object") jQuery("#form" + tmpId).html(jQuery(opts.form).html() + '<input type="submit" id="btn' + tmpId + '" name="btn' + tmpId + '" />');

            var pMask = document.getElementById("pMask" + tmpId);
            var xleft = Myplugin.Common.FindPosX(pForm); var ytop = Myplugin.Common.FindPosY(pForm); pMask.style.top = ytop; pMask.style.left = xleft;
            pMask.style.width = pForm.offsetWidth; pMask.style.height = pForm.offsetHeight;
            jQuery(pMask).addClass("dgForm_pMask").css("display", "block");

            jQuery.ajax({ type: 'POST', url: jQuery("#form" + tmpId).attr('action'), data: jQuery("#form" + tmpId).serialize(),
                success: function(data) {
                    callback.call(new Object(), data);
                    jQuery("#pMask" + tmpId).remove();
                    jQuery("#pData" + tmpId).remove();
                }, error: function(message) { alert(message); jQuery("#pMask" + tmpId).remove(); jQuery("#pData" + tmpId).remove(); }
            });
        }
    }

    Myplugin.Data = { Valid: new DataValid()
        , DataTable: new DataTable()
        , Controller: Controller
    };
})(Myplugin);


/*
Myplugin UI 1.1 数据
*/
(function(Myplugin, undefined) {
    // HTML 控件产生
    function MyCtrl() {
        /* MyCtrl()   动态创建 HTML 控件   作者: Richard ( 2011-01-11 )
        例:
        html 页面
        ----------------------------------
        <div id="MyDIV"></div>
                        
                        
        jscript 脚本
        ----------------------------------
        var text = Myplugin.UI.MyCtrl.Make("input").Attr("type", "text").Attr("style", "width:100px;height:30px;").Attr("onclick", "alert(1)").GET();
        var button = Myplugin.UI.MyCtrl.Make("input").Attr("type", "button").Attr("style", "width:100px;height:30px;").Attr("onclick", "alert(\"click button\")").GET();
        var font = Myplugin.UI.MyCtrl.Make("font").Attr("color", "red").Html("*").GET();
        $("#MyDIV").append(text + button + font);   
        */
        var Attrs = "", TagName = "";
        this.Make = function(tagName) {
            TagName = tagName;
            Attrs = "";
            return this;
        };
        this.Attr = function(key, value) {
            Attrs += " " + key + ("='{0}' ").replace("{0}", value);
            return this;
        };
        this.GET = function() {
            if (TagName == "input")
                return ("<{0}{1} />").replace("{0}", TagName).replace("{1}", Attrs);
            else
                return Attrs;
        };
        this.Html = function(text) {
            Attrs = ("<{0}{1}>{2}</{0}>").replace("{0}", TagName).replace("{1}", Attrs).replace("{2}", text).replace("{0}", TagName);
            return this;
        }
    }
    // 窗体对象
    var MyWindow = function() {
        var features = "", opts = { WinName: "", width: 900, height: 600 };
        // 打开新窗体
        this.Open = function(url) {
            /// <summary>打开新窗体, 例: Myplugin
            /// 
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
        // 打开模式新窗体
        this.Dialog = function(url) {
            opts = arguments[0] ? arguments[0] : opts;
            features += "dialogWidth:" + opts.width + "px";
            features += "; dialogHeight:" + opts.height + "px";
            features += "; dialogTop:" + (screen.availHeight - opts.h) / 2 + "px";
            features += "; dialogLeft:" + (screen.availWidth - opts.w) / 2 + "px";
            features += "; status:no";
            window.showModalDialog(url, opts.WinName, features);
        }
    }
    var MyCalender = function(id, format) {
        /// <summary>日期控件
        /// 例:
        ///     Myplugin.UI.MyCalender("txtDate", "yyyy-MM-dd HH:mm") 或 Myplugin.UI.MyCalender("txtDate", "yyyy-MM-dd")
        /// </summary>
        /// <param name="id" type="string">HTML 控件的 ID</param>
        /// <param name="format" type="string">日期的格式: "yyyy-MM-dd HH:mm" 或 "yyyy-MM-dd"</param>
        if (format == "")
            WdatePicker({ el: id, dateFmt: 'yyyy-MM-dd' })
        else
            WdatePicker({ el: id, dateFmt: format })
    }
    /*
    例：
    jQuery(document).ready(function() {
    jQuery.MyTabs({ ulClass: 'TABS001', liID: '#' });
    });
    --------------------------------------------------------------------
    <ul id="tabs001" class="TABS001">
    <li class="TABS001001" id="#0">库存清单</li>
    <li class="TABS001002" id="#1">采购入库</li>
    <li class="TABS001002" id="#2">在途使用维护</li>
    </ul><div class="TABS001004" />
    <div class="#0">

        </div>
    <div class="#1">

        </div>
    <div class="#2">

        </div>
    */
    var MyTabs = function(opts) {
        /// <summary>日期控件
        /// 例:
        ///     jQuery(document).ready(function() {
        ///         Myplugin.UI.MyTabs({ ulClass: 'TABS001', liID: '#' });
        ///     });
        /// -------------------------------------------- 
        ///     <ul id="tabs001" class="TABS001">
        ///         <li class="TABS001001" id="#0">库存清单</li>
        ///         <li class="TABS001002" id="#1">采购入库</li>
        ///         <li class="TABS001002" id="#2">在途使用维护</li>
        ///     </ul><div class="TABS001004" />
        ///     <div class="#0">
        ///     
        ///     </div>
        ///     <div class="#1">
        ///     
        ///     </div>
        ///     <div class="#2">
        ///
        ///     </div>
        /// </summary>
        /// <param name="opts" type="Map">opts: { ulClass: 'TABS001', liID: '#' }</param>
        if (!opts.liStyle) opts.liStyle = "border:solid 1px #AACCF1; padding:8px 8px 18px 13px;";
        if (opts.ifmH) {
            if (opts.ifmH.indexOf("px") == -1) opts.ifmH = opts.ifmH + "px";
        }
        else opts.ifmH = "350px";

        // Initialization Tabs
        jQuery("ul[class=" + opts.ulClass + "]>li").each(function(i) {
            if (i != 0) {
                jQuery("div[class=" + opts.liID + i + "]").attr("style", opts.liStyle).hide();
                jQuery("div[class=" + opts.liID + i + "]>iframe").attr({ "width": "100%", "height": opts.ifmH });
            }
            else {
                jQuery("div[class=" + opts.liID + i + "]").attr("style", opts.liStyle);
                jQuery("div[class=" + opts.liID + i + "]>iframe").attr({ "width": "100%", "height": opts.ifmH });
            }
        });
        // Tabs options click event
        jQuery("ul[class=" + opts.ulClass + "]>li").click(function() {
            jQuery("ul[class=" + opts.ulClass + "]>li").each(function(i) {
                jQuery(this).attr("class", "TABS001002");
                jQuery("div[class=" + opts.liID + i + "]").hide();
            });
            jQuery(this).attr("class", "TABS001001");
            jQuery("div[class=" + jQuery(this).attr("id") + "]").show();
        });
    }

    var Uploadify = function() {
        /// <summary>上传文件,
        /// 例: var uploadify = My.Uploadify.Open();   关闭: uploadify.Close();
        /// </summary>
        /// <param name="OrderID" type="String">OrderID: DIY100000001</param>
        /// <param name="TableName" type="String">TableName: WebUploadify</param>

        var dialog, dgWin;
        this.Open = function(OrderID, TableName) {
            dialog = Myplugin.Dialog.Create({ caption: "上传文件", width: 530, height: 500, url: Myplugin.ContextPath + "Common/myplugin/uploadify/uploadify.aspx?OrderID=" + OrderID + "&TableName=" + TableName });
            dgWin = dialog.Open(); // 打开对话框
            return this;
        }
        this.Close = function() {
            dialog.Close(dgWin);
        }

        this.Download = function(filename, OriginName) {
            window.location = Myplugin.ContextPath + "Common/myplugin/uploadify/uploadify.ashx?Option=download&filename=" + filename + "&OriginName=" + OriginName;
        }

        this.Delete = function(opts) {
            if (confirm("确认删除吗？")) {
                var strParams = "&RemoveID=" + opts.RemoveID + "&RowID=" + opts.RowID + "&filename=" + opts.FileName;
                Myplugin.Data.Controller({ form: opts.selector.parentNode.parentNode, url: Myplugin.ContextPath + "Common/myplugin/uploadify/uploadify.ashx?Option=delete" + strParams }, function(data) {
                    var json = $.parseJSON(data);
                    if (json[0].Option == "false")
                        alert("资料保存失败!");
                    else {
                        alert("资料保存成功!");
                        $(opts.selector.parentNode.parentNode).remove();
                    }
                });
            }
        }

        this.GetList = function(OrderID, TableName) {
            $.get(Myplugin.ContextPath + "Common/myplugin/uploadify/uploadify.ashx?option=list&OrderID=" + OrderID + "&TableName=" + TableName, function(data) {
                var json = eval(data);

                if (json.Option && json.Option == "false")
                    alert("查无资料！");
                else {
                    var table = document.getElementById("table-uploadify-list");
                    if (table.rows.length > 1) for (var i = 1; i < table.rows.length; ) table.deleteRow(table.rows(i).rowIndex);
                    $(table).css("font-size", "12px");

                    var dt = Myplugin.Data.DataTable.Bind(table);
                    for (var i = 0; i < json.length; i++) {
                        dt.Rows.Add(json[i]);
                    }
                }
            });
        }
    }

    /* <remarks>作者: Robert Yu ( 2007-11-16 ) 版权所有<remarks>
    * <summary>
    * 加载页面
    * </summary>
    * <example>
    *		<a href='#1' onclick='jQuery.LoadPagePanel({obj:this ,w:500 ,h:400 ,y:18 ,url:"http://mail.163.com"});'>
    *			<img style="margin:2px 8px 0px 0px" src='<%=Publiclib.Common.ContextPath%>Common/images/view.gif'>
    *		</a> 
    *       或
    *       Myplugin.UI.LoadPanel({option:"open",obj:this ,w:300 ,h:33 ,y:23 ,html:$("#pHblGreaterThanOne").html()});
    *       
    *       Myplugin.UI.LoadPanel({option:"open",obj:this ,w:300 ,h:33 ,y:23 ,url:"http://frame.diygens.com"});
    * </example>
    * <param name="obj">HTML物件</param>
    * <param name="w">宽度</param>
    * <param name="h">高度</param>
    * <param name="y">Y轴偏移量</param>
    * <param name="url">加载页面</param> */
    var LoadPanel = function(opts) {
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

    Myplugin.UI = { MyCtrl: new MyCtrl()
        , MyWindow: new MyWindow()
        , MyCalender: MyCalender
        , MyTabs: MyTabs
        , Uploadify: new Uploadify()
        , LoadPanel: LoadPanel
    }
})(Myplugin);



(function(Myplugin) {
    //例子:<input type="text" name="tex1" value="0000-00-00 00:00" onkeydown="keydown(this)" size="16" maxlength="16" onFocus="" onkeypress="keypress(this)" onpaste="checkPaste()" onDrag="checkPaste()" oncut="checkPaste()" onmousemove="checkPaste()">   
    function KeyDown(src) {
        var e = window.event;
        var code = e.keyCode;
        var cursorPos = getPos(src);
        if (code == 8) {   //退格   
            if (cursorPos == 5 || cursorPos == 8 || cursorPos == 11 || cursorPos == 14) {
                movenext(src, cursorPos, -1);
                cursorPos -= 1;
            } else movenext(src, cursorPos, 0);
            //alert();   
            var range = setSelect(src, cursorPos - 1);
            range.text = "0";
            movenext(src, cursorPos, -1);
            e.returnValue = false;
            //src.focus();   
            return false;
        } else if (code == 46) e.returnValue = false;
    }
    function KeyPress(src) {
        var e = window.event;
        var code = e.keyCode;
        var cursorPos = getPos(src);
        if (!keyPressInt()) return false;
        if (cursorPos == 4 || cursorPos == 7 || cursorPos == 10 || cursorPos == 13) {
            movenext(src, cursorPos, 1);
            cursorPos += 1;
        }
        var num = String.fromCharCode(code);
        //alert(num);   
        if (checkInput(src, num, cursorPos)) {
            var range = setSelect(src, cursorPos);
            range.text = num;
            if (cursorPos == 3 || cursorPos == 6 || cursorPos == 9 || cursorPos == 12)
                movenext(src, cursorPos, 2);
            else movenext(src, cursorPos, 1);
        }
        e.returnValue = false;
        return false;
    }
    function checkInput(src, num, pos) {
        var val = src.value;
        var year = parseInt(val.substring(0, 4), 10);
        var month = parseInt(val.substring(5, 7), 10);
        switch (pos) {
            case 0: if (num != 1 && num != 2) return false; break;
            case 5: if (num > 1) return false; break;
            case 6: if (val.charAt(5) == "1" && num > 2 || val.charAt(5) == "0" && num == 0)
                    return false; break;
            case 8: switch (month) {
                    case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                    case 4: case 6: case 9: case 11:
                        if (num > 3) return false; break;
                    case 2: if (num > 2) return false; break;
                } break;
            case 9: var char8 = val.charAt(8); switch (month) {
                    case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                        if (char8 == 0 && num == 0 || char8 == 3 && num > 1) return false;
                    case 4: case 6: case 9: case 11:
                        if (char8 == 0 && num == 0 || char8 == 3 && num != 0) return false;
                    case 2: if (char8 == 0 && num == 0) return false;
                        else if (char8 == 2 && !(year % 4 == 0 && year % 400 == 0) && num > 8) return false;
                } break;
            case 11: if (num > 2) return false; break;
            case 12: if (parseInt(val.charAt(11) + num) > 23) return false; break;
            case 14: if (num > 5) return false; break;
        }
        return true;
    }
    function setSelect(src, pos) {
        var range = src.createTextRange();
        range.moveStart('character', pos);
        range.moveEnd('character', pos - src.value.length + 1);
        range.select();
        return range;
    }
    function getPos(obj) {
        var ml = obj.value.length;
        var pos = 0;
        var rng = document.selection.createRange();
        rng.moveEnd("character", ml);
        try {
            pos = ml - rng.text.length
        } catch (e) { }
        return pos;
    }
    function movenext(src, pos, flag) {
        var range = src.createTextRange();
        range.moveStart("character", pos + flag);
        range.collapse(true);
        range.select();
    }
    function keyPressInt() {
        var e = window.event;
        code = e.keyCode;
        if (code >= 48 && code <= 57) return true;
        else { window.event.returnValue = false; return false; }
    }
    function CheckPaste() {
        window.event.returnValue = false;
    }

    Myplugin.UI.Date = { KeyDown: KeyDown
        , KeyPress: KeyPress
        , CheckPaste: CheckPaste
    }
})(Myplugin);
