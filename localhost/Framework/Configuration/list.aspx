<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="Framework_Configuration_list" Theme="FORM" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <meta http-equiv="X-UA-Compatible" content="IE=7" />
        <link href="../../Common/myplugin/myplugin.css" rel="stylesheet" type="text/css" />
        <script src="../../Common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/jquery.ui.custom.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.core.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.ui.js" type="text/javascript"></script>
        <script src="JScript.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div class="pDivTopSplitor">
            <div class="mypanel">
                <table id="table-company-search" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <th>权限编号</th>
                        <td>
                            <input type="text" id="PermissionID" name="PermissionID" />
                        </td>
                        <th>名称</th>
                        <td>
                            <input type="text" id="NameCHS" name="NameCHS" />
                        </td>
                        <td>
                            <button type="button" id="btnDelete">删除</button>
                            <button type="button" id="btnSearch">查询</button>
                            <button type="button" id="btnAddnew">新增</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="mypanel">
            <table id="table-company-list" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <th>选择 <input type="checkbox" id="chkAll" name="chkAll" /></th>
                    <th>维护</th>
                    <th>Key名</th>
                    <th>Key值</th>
                    <th>备注</th>
                </tr>
                <asp:Repeater runat="server" ID="Repeater1">
                    <ItemTemplate>
                    <tr id='Tr_<%# Eval("KeyName") %>'>
                        <td>
                            <input type="checkbox" name="chkItem" value='<%# Eval("KeyName") %>' />
                        </td>
                        <td>
                            <a href="javascript:void(0)" rel='<%# Eval("KeyName") %>' name="aModifyDATA">修改</a>
                        </td>
                        <td id='Td_<%# Eval("KeyName") %>_01'>&nbsp;<%# Eval("KeyName")%></td>
                        <td id='Td_<%# Eval("KeyName") %>_02'>&nbsp;<%# Eval("KeyValue")%></td>
                        <td id='Td_<%# Eval("KeyName") %>_03'>&nbsp;<%# Eval("Remark")%></td>
                    </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            
            <div class="pDivSplitor">
                <asp:AspNetPager id="AspNetPager1" runat="server" horizontalalign="Center" pagingbuttontype="Image" width="100%" 
                    ImagePath="../images/" ButtonImageNameExtension="n" ButtonImageExtension=".gif" DisabledButtonImageNameExtension="g" 
                    CpiButtonImageNameExtension="r" ButtonImageAlign="left" 
                    PagingButtonSpacing="10px" OnPageChanging="AspNetPager1_OnPageChanging"></asp:AspNetPager>
            </div>
            
        </div>
        </form>
    </body>
</html>
