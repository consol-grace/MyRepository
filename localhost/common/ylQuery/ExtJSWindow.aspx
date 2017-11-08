<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExtJSWindow.aspx.cs" Inherits="Common_ylQuery_ExtJSWindow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <link href="jquery.ui.custom/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
        <script src="jquery.ui.custom/js/jquery-1.6.1.js" type="text/javascript"></script>
        <script src="jquery.ui.custom/js/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
        <link href="themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <script src="ylQuery.js" type="text/javascript"></script>
        <link href="ext-3.2.0/resources/css/ext-all.css" rel="stylesheet" type="text/css" />
        <script src="ext-3.2.0/adapter/ext/ext-base.js" type="text/javascript"></script>
        <script src="ext-3.2.0/ext-all.js" type="text/javascript"></script>
        <script type="text/javascript">
            Ext.onReady(function() {
                var panel = new Ext.Panel({ id: "myPanel", //标识    
                    renderTo: "divPanel", //在哪个元素中渲染    
                    title: "我的面板",
                    width: 400,
                    height: 300,
                    frame: false, //如果为true 则panel具有全部阴影，否则只有1px边框    
                    //html:"<h1>这是在Panel中的内容...</h1>",    
                    contentEl: 'divPanelContent', //此属性可以简写成“el”，显示哪个元素中的内容    
                    draggable: true, //是否允许拖动    
                    collapsible: true,
                    titleCollapse: true, //是否点击整个标题栏都可以收缩
                    tools: [{ id: "Close", handler: function() { panel.hide(); } }]
                    , tbar: [new Ext.Toolbar.TextItem("工具栏")
                        , { xtype: "tbfill" }
                        , { pressed: true, text: '添加', handler: function() { alert(1); } }
                        , { xtype: "tbseparator" }
                        , { pressed: true, text: '保存' }
                    ]
                    , bbar: [{ text: "这是状态栏"}]
                    , buttons: [{ text: "该按钮位于底部！"}]
                });

            });
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div id="divPanel"></div>
            <div id="divPanelContent">    ExtJs学习，欢迎大家多多交流，共同进步！cmj studio！</div>
        </form>
    </body>
</html>



