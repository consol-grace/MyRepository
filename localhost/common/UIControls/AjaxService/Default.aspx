<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Tracking_AjaxService_Default" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register src="/common/uicontrols/UserComboBox.ascx" tagname="UserComboBox" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test</title>
    <style type="text/css">
        *
        {
            margin: 0px;
            padding: 0px;
            font-size: 10px;
            font-family: Verdana, Arial;
        }
        table
        {
            background: #ddd;
        }
        #UserGridPanel1
        {
            margin: 20px;
        }
        input, select
        {
            height: 16px;
            text-transform: uppercase;
            border: 0;
            background-color: Transparent;
        }
        body
        {
            -webkit-text-size-adjust: none;
        }
        td, th
        {
            height: 17px;
            line-height: 17px;
            padding: 2px 3px 0px 3px;
            background-color: #fff;
        }
        .grid_title th
        {
            border: solid 1px #ddd;
            border-bottom: solid 0px #fff;
        }
        .grid_title th
        {
            background-image: url(http://localhost:85/images/bg_line_3.jpg);
            height: 24px;
            line-height: 24px;
            text-align: left;
            color: #1542AF;
            font-size: 12px;
            font-weight: bold;
        }
        .grid_caption th
        {
            background-image: url(http://localhost:85/common/ylQuery/ext-3.2.0/resources/images/default/grid/grid3-hrow.gif);
            height: 20px;
            line-height: 20px;
            text-align: center;
        }
        .grid_content_div
        {
            height: 200px;
            overflow-y: scroll;
            border-right: solid 1px #ddd;
            border-bottom: solid 1px #ddd;
        }
        .border_bottom
        {
            background-image: url(http://localhost:85/common/uicontrols/ajaxservice/text_bottom.gif);
            background-position: left 12px;
            background-repeat: repeat-x;
        }
        .ac_results ul li
        {
            line-height: 14px;
            height: 14px;
        }
    </style>

    <script src="../../Common/ylQuery/myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="jquery.autocomplete-1.4.2.js" type="text/javascript"></script>

    <script src="DropDownList.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="divcontent" style="width: 200px">
    </div>

    <script type="text/javascript">

        var str = "你有新消息，请及时查收！！！";
        var i = 0;

        $(function() {
            function auto() {
                if (i <= str.length) {
                    document.title = str.substring(0, i);
                    ++i;
                    setTimeout(auto, 200);
                }
                else {
                    i = str.length;
                    move();
                }
            }
            function move() {
                if (i == 0)
                    auto();
                else {
                    document.title = document.title.substring(1, i);
                    --i;
                    setTimeout(move, 200);
                }
            }

            auto();
        })   

    </script>   
    
  
  
    </form>
</body>
</html>
