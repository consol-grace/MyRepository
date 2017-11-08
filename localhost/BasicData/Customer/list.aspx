<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>

    <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>

    <script type="text/javascript" src="Controller.js"></script>
    <style type="text/css">
        #ChkGrpStat label, #tblChkGroup label, #tblChkGroup_Container label {
            margin-right: 0px !important;
        }

        #ChkGrpStat .x-form-check-wrap, #tblChkGroup .x-form-check-wrap, #tblChkGroup_Container .x-form-check-wrap {
            padding-top: 1px !important;
        }

        .x-form-check-wrap {
            line-height: 10px !important;
        }
    </style>
    <script type="text/javascript">
        function ShowDetail(rowid) {
            SetStyle("Company", 746, 565, "Form", "/BasicData/Customer/detail.aspx?rowid=" + rowid);
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX" />
        <%Response.Write("<script src=\"/common/UIControls/CreateWindow/CreateWindow.js?v=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" type=\"text/javascript\"></script>");%>
        <asp:HiddenField ID="hidRowID" runat="server" Value="0" />
        <div id="location_div01">
            <table width="720" height="24" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                <tr>
                    <td background="../../images/bg_line.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                        style="padding-left: 8px">Customer List
                    </td>
                </tr>
            </table>
            <table width="710" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="700" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="padding-left: 9px">
                        <table width="700" border="0" cellpadding="0" cellspacing="0" class="table_25left">
                            <tr>
                                <td width="33">
                                    <table width="80" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="left" class="font_11bold">Code / Name
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="75">
                                    <ext:TextField ID="Code" runat="server" Cls="text_80px" TabIndex="1" Width="100">
                                    </ext:TextField>
                                </td>
                                <td width="32" style="padding-left: 20px">
                                    <table width="50" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="left" class="font_11bold">Address
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="" align="left">
                                    <ext:TextField ID="Address" runat="server" Cls="text_160px" TabIndex="2" Width="160">
                                    </ext:TextField>
                                </td>
                                <td>
                                    <div runat="server" id="div_ShowActive" style="margin-left: 15px;">
                                        <nobr><label for="chkActive" style=" float:left;">Show Inactive</label>
                                <ext:Checkbox ID="chkActive" runat="server" Checked="true" StyleSpec="float:left; margin:5px 2px 0px 5px;">
                                    <Listeners>
                                        <Check Handler="CompanyX.ShowInActive();" />                                                                                    
                                    </Listeners>
                                    <AutoEl Tag="Form"></AutoEl>
                                </ext:Checkbox></nobr>
                                    </div>
                                </td>
                                <td width="100" align="center">
                                    <ext:Button ID="btnFilter" runat="server" Text=" Filter " Cls="Submit_70px" Width="65px"
                                        AutoFocus="true" AutoShow="true" Selectable="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnFilter_Click">
                                                <EventMask ShowMask="true" Msg="  Searching ... " />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:KeyNav runat="server" Target="form1">
                                        <Enter Handler="btnFilter.fireEvent('click')" />
                                    </ext:KeyNav>
                                </td>
                                <td>
                                    <ext:Button ID="btnNew" runat="server" Text="  New  " Cls="Submit_70px" Width="60px"
                                        NavigateUrl="detail.aspx">
                                    </ext:Button>
                                </td>
                                <td>
                                    <ext:Button ID="btnPrint" runat="server" Text="  Print  " Cls="Submit_70px" Width="60px">
                                        <Listeners>
                                            <Click Handler="window.open('/basicdata/customer/company_report/company_report.aspx?Type=companylist');" />
                                        </Listeners>
                                    </ext:Button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" id="showlist">
                <tr>
                    <td valign="top" id="GridView">
                        <ext:GridPanel ID="GridPanel1" runat="server" StripeRows="true" Height="446" Width="412"
                            AutoExpandColumn="Code">
                            <Store>
                                <ext:Store ID="Store7" runat="server" OnRefreshData="storeList_OnRefreshData">
                                    <AutoLoadParams>
                                        <ext:Parameter Name="start" Value="={0}" />
                                        <ext:Parameter Name="limit" Value="={300}" />
                                    </AutoLoadParams>
                                    <Reader>
                                        <ext:JsonReader IDProperty="ROWID">
                                            <Fields>
                                                <ext:RecordField Name="Code" />
                                                <ext:RecordField Name="Name" />
                                                <ext:RecordField Name="Type" />
                                                <ext:RecordField Name="Remark" />
                                                <ext:RecordField Name="co_isvalid" />
                                                <ext:RecordField Name="StatList" />
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                            <Listeners>
                                <RowClick Fn="rowclickFn" />
                                <KeyPress Handler="Code.focus();" />
                            </Listeners>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn Width="30" Header="No." />
                                    <ext:Column DataIndex="Code" Header="Code" Width="210" />
                                    <ext:Column DataIndex="Type" Header="Type" Width="60" />
                                    <ext:Column DataIndex="Name" Header="Name" Width="170" />
                                    <ext:CheckColumn DataIndex="co_isvalid" Header="Active" Width="45"></ext:CheckColumn>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                            </SelectionModel>
                            <LoadMask ShowMask="true" Msg=" Loading..." />
                            <BottomBar>
                                <ext:PagingToolbar StoreID="Store7" PageSize="300" DisplayInfo="true" ID="PagingToolbar1"
                                    runat="server">
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </td>
                    <td style="padding-left: 8px"></td>
                    <td width="224" valign="top">
                        <div id="div_CheckboxGroup">
                            <ext:CheckboxGroup ID="tblChkGroup" ColumnsNumber="6" runat="server">
                            </ext:CheckboxGroup>
                        </div>
                        <table width="300px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 8px; height: 22px">Remark
                                </td>
                            </tr>
                        </table>
                        <table width="260" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="2"></td>
                            </tr>
                        </table>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <textarea name="txtRemark" style="width: 294px; height: 413px; font-family: Arial, Helvetica, sans-serif; font-size: 11px; vertical-align: top; background-color: #fff;"
                                        disabled="disabled"
                                        id="txtRemark" tabindex="3"></textarea>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript">

        Ext.onReady(function () {
            var dept = "<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[28].ToUpper() %>";
            if (dept == "IT" || dept == "ADMIN") {
                var tblHeight = $("#tblChkGroup").height();
                var RemHeight = $("#txtRemark").height();
                $("#txtRemark").height(RemHeight - tblHeight + 1);
                $("#div_CheckboxGroup").css("margin-top", "-1px");
            }

            $("#tblChkGroup input[type='checkbox']").click(function () {
                var rowid = $("#hidRowID").val();
                var station = Ext.getCmp($(this).attr("ID")).tag;
                var flag = Ext.getCmp($(this).attr("ID")).getValue() == true ? 1 : 0;
                if (rowid == 0) {
                    alert("请选择要更新的项!");
                    Ext.getCmp($(this).attr("ID")).setValue(flag == 1 ? 0 : 1);
                    return;
                }
                $.getJSON("/basicdata/customer/handler.ashx?rowid=" + rowid + "&station=" + station + "&flag=" + flag + "&v=" + new Date().getTime(), function (data) {
                    if (data == "N")
                        alert("数据异常，更新失败!");
                })
              
            })

        });
    </script>
</body>
</html>
