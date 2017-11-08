<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Setting.aspx.cs" Inherits="BasicData_Customer_Setting" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <style type="text/css">
        *
        {
            margin: 0px;
            padding: 0px;
        }
        body
        {
            font-size: 12px;
            padding: 15px;
            color: #000;
        }
        #chkModifyStat td, #chkModifiedStat td
        {
            padding: 5px 20px 5px 0;
        }
        input
        {
            margin-right: 5px;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            $("#chkModifyStat input").click(function() {
                if ($(this).attr("checked")) {
                    $("#chkModifyStat input").attr("checked", false);
                    $("#chkModifyStat input").next("label").css("color", "#000");
                    $(this).attr("checked", true);
                    $(this).next("label").css("color", "red");
                }
                else {
                    $(this).next("label").css("color", "#000");
                }
                CompanyX.UpdateStat($(this).next("label").text(), $(this).attr("checked"), "Z")

            })

            $("#chkModifiedStat input").click(function() {

                if ($(this).attr("checked")) {
                    $(this).next("label").css("color", "red");
                }
                else {
                    $(this).next("label").css("color", "#000");
                }
                CompanyX.UpdateStat($(this).next("label").text(), $(this).attr("checked"), "Y")

            })

        })
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    <div>
        <table>
            <tr>
                <td style="border-bottom: solid 1px #ddd; padding: 10px 0">
                    当前正在处理的分站
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBoxList ID="chkModifyStat" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: solid 1px #ddd; padding: 20px 0 10px 0">
                    已经处理好的分站
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBoxList ID="chkModifiedStat" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                    </asp:CheckBoxList>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
