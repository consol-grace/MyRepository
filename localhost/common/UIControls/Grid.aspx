<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Grid.aspx.cs" Inherits="common_UIControls_Grid" %>

<%@ Register Src="UserGridPanel.ascx" TagName="UserGridPanel" TagPrefix="uc1" %>
<%@ Register Src="UserComboBox.ascx" TagName="UserComboBox" TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <link href="AjaxService/jquery.autocomplete.css" rel="stylesheet" type="text/css" />

    <script src="AjaxService/jquery.autocomplete.js" type="text/javascript"></script>

    <script src="AjaxService/DropDownList.js" type="text/javascript"></script>

    <script src="AjaxService/grid.js" type="text/javascript"></script>

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
        .grid_title span
        {
            float: right;
            display: block;
            padding: 0px 5px;
        }
        .grid_title .grid_title_span
        {
            float: left;
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
            overflow-x: auto;
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

    <script type="text/javascript">
        var check = function(e) {
            e = e || window.event;
            if ((e.which || e.keyCode) == 13) {
                alert();
            }
        }
        document.attachEvent("onkeydown", check);

        function getSelectPos(obj) {
            var esrc = document.getElementById(obj);
            if (esrc == null) {
                esrc = event.srcElement;
            }
            var rtextRange = esrc.createTextRange();
            rtextRange.moveStart('character', esrc.value.length);
            rtextRange.collapse(true);
            rtextRange.select();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server">
    </ext:ResourceManager>
    <div id="gridPanle" runat="server">
        <uc1:UserGridPanel ID="UserGridPanel1" runat="server" sys="A" />
    </div>
    <ext:GridPanel ID="gridlist" runat="server" AutoHeight="true">
        <Store>
            <ext:Store runat="server" ID="store1">
                <Reader>
                    <ext:JsonReader>
                        <Fields>
                            <ext:RecordField Name="Code">
                            </ext:RecordField>
                            <ext:RecordField Name="Name">
                            </ext:RecordField>
                        </Fields>
                    </ext:JsonReader>
                </Reader>
                <Listeners>
                    <Load Handler="alert()" />
                </Listeners>
            </ext:Store>
        </Store>
        <ColumnModel ID="ColumnModel1" runat="server">
            <Columns>
                <ext:RowNumbererColumn Header="No." Width="30">
                </ext:RowNumbererColumn>
                <ext:Column Header="Code" DataIndex="Code" Width="100">
                </ext:Column>
                <ext:Column Header="Name" DataIndex="Name" Width="250">
                </ext:Column>
            </Columns>
        </ColumnModel>
    </ext:GridPanel>
    <asp:Button ID="btnClick" runat="server" Text="Click" OnClick="btnClick_Click" />
    </form>
</body>
</html>
