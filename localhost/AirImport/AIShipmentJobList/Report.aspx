<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="AirImport_AIShipmentJobList_Report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <style type="text/css">
        .bottom_line
        {
            color: #000;
            border: solid 1px #B5B8C8 !important;
            border-bottom: solid 1px #B5B8C8 !important;
        }
    </style>

    <script language="javascript" type="text/javascript">
        $(function() {
            if ($(window).width() < 1150) {
                $("#mainReport").width("970");
                $("#mainReport").height("500");
            }
            AutoSize();

            $(window).resize(function() {
                AutoSize();
            })
        });

        function AutoSize() {
            var height = ($(window).height() - 180);
            $("#mainShow").height(height);
        }
        
    </script>

</head>
<body>
    <form id="form1" runat="server" target="_blank">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX" >
    </ext:ResourceManager>
    <ext:Hidden ID="hidsys" runat="server" Text="AI">
    </ext:Hidden>
    <ext:Hidden ID="hidtype" runat="server" Text="DNCN">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreSalesman" OnRefreshData="StoreSalesman_OnRefreshData">
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreOP" OnRefreshData="StoreOP_OnRefreshData">
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <div style="margin-left: 13px">
        <table width="800" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="5" valign="top" style="padding-top: 10px">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                                <%=setTitle() %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10px" colspan="5">
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <table border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td width="40" style="padding-left: 4px">
                                Date
                            </td>
                            <td width="90">
                                <ext:DateField ID="txtETDFrom" runat="server" Cls="text_100px" Width="90" Format="dd/m/Y"
                                    TabIndex="1">
                                </ext:DateField>
                            </td>
                            <td width="40" style="padding-left: 2px">
                                To
                            </td>
                            <td width="90">
                                <ext:DateField ID="txtETDTo" runat="server" Cls="text_100px" Width="90" Format="dd/m/Y"
                                    TabIndex="2">
                                </ext:DateField>
                            </td>
                            <td width="50" style="padding-left: 2px">
                                <asp:Label ID="lblSHPR" runat="server" Text="Shipper"></asp:Label>
                            </td>
                            <%--                            <td width="50" style="padding-left: 2px">
                               Shipper 
                            </td>--%>
                            <td width="200">
                                <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="3" clsClass="x-form-text x-form-field text"
                                    Query="option=CompanyList" Width="200" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800" isDiplay="false" />
                            </td>
                            <td width="80" align="right">
                                <ext:Button ID="btnFilter" runat="server" Cls="Submit_65px" Text="Report" Width="65"
                                    TabIndex="6" AutoFocus="true">
                                    <DirectEvents>
                                        <Click OnEvent="btnFilter_Click">
                                            <%--<EventMask ShowMask="true" Msg=" Searching ... "  CustomTarget="mainShow" />--%>
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                    <Enter Handler="btnFilter.fireEvent('click')" />
                                </ext:KeyNav>
                            </td>
                        </tr>
                        <tr>
                            <td width="40" style="padding-left: 4px">
                                <asp:Label ID="lblDest" runat="server" Text="Dest" Visible="true"></asp:Label>
                                 <asp:Label ID="lblLoc" runat="server" Text="Location" Visible="false"></asp:Label>
                            </td>
                            <%--                            <td width="40" style="padding-left: 2px">
                               Dest 
                            </td>--%>
                            <td width="90">
                                <div id="divDest" runat="server">
                                    <uc1:UserComboBox runat="server" ID="cmbDest" ListWidth="180" clsClass="select_160px"
                                        TabIndex="4" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="70"
                                        winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                        winHeight="620" isButton="false" />
                                </div>
                                <div id="divSales" runat="server">
                                    <uc1:UserComboBox runat="server" ID="cmbSales" Query="option=SalesList" Width="70"
                                        clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                        TabIndex="4" winWidth="680" winHeight="560" isButton="false" />
                                </div>
                            </td>
                            <td width="40" style="padding-left: 2px">
                                <asp:Label ID="lblSalesman" Text="Salesman" runat="server"></asp:Label>
                                <asp:Label ID="LblOP" Text="OP" runat="server" Visible="false"></asp:Label>
                                
                            </td>
                            <td width="90">
                                <div id="divSalesman" runat="server">
                                    <uc1:UserComboBox runat="server" ID="cmbSalesman" Query="option=SalesList" Width="90"
                                        clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                        TabIndex="4" winWidth="680" winHeight="560" isButton="false" />
                                </div>
                                <div id="divOP" runat="server" style=" display:none;">
                                    <uc1:UserComboBox runat="server" ID="cmbOP" Query="option=GetUserListByStat" Width="90"  ListWidth="180"
                                        clsClass="select" StoreID="StoreOP" winTitle="OP" winUrl="/Framework/User/UserList.aspx"
                                        TabIndex="4" winWidth="680" winHeight="560" isButton="false" />
                                </div>
                            </td>
                            <td width="50" style="padding-left: 2px">
                                <asp:Label ID="lblCNEE" runat="server" Text="Consignee"></asp:Label>
                            </td>
                            <%--                            <td width="50" style="padding-left: 2px">
                                Consignee
                            </td>--%>
                            <td width="200">
                                <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="5" clsClass="x-form-text x-form-field text"
                                    Query="option=CompanyList" Width="200" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                    winWidth="800" winHeight="800" isDiplay="false" />
                            </td>
                            <td width="80" align="right">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10" colspan="7">
                </td>
            </tr>
            <tr>
                <td colspan="7" width="800px" id="mainShow">
                    <iframe id="mainReport" height="100%" width="1148" scrolling="yes" 
                        name="mainReport" frameborder="0"></iframe>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
