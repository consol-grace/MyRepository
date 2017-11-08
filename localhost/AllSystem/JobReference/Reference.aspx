<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reference.aspx.cs" Inherits="OceanExport_OEJobRference_Reference" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidsys" runat="server"></ext:Hidden>
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
    <div style="padding-top: 10px; padding-bottom: 10px; padding-left: 10px">
        <table width="900px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tr>
                <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                    <table width="800px" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                Job Reference
                            </td>
                            <td width="288" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <table border="0" cellspacing="4" cellpadding="0" style="padding-left: 10px">
        <tr>
            <td width="40" style="padding-left: 2px">
                Date
            </td>
            <td width="90">
                <ext:DateField ID="txtETDFrom" runat="server" Cls="text_100px" Width="90" Format="dd/m/Y"
                    TabIndex="1">
                </ext:DateField>
            </td>
            <td width="40" style="padding-left: 10px">
                To
            </td>
            <td width="90">
                <ext:DateField ID="txtETDTo" runat="server" Cls="text_100px" Width="90" Format="dd/m/Y"
                    TabIndex="2">
                </ext:DateField>
            </td>

            <td width="50" style="padding-left: 10px">
                <asp:Label ID="lblJobNo" runat="server" Text="Lot No#"></asp:Label>
            </td>
            <td>
                <ext:TextField ID="txtJobNo" runat="server" Width="127" TabIndex="3"  Cls="text">
                </ext:TextField>
            </td>

            <td style="padding-left:10px">
                <asp:Label ID="lblMBL" runat="server" Text="MBL"></asp:Label>
            </td>
            <td>
                <ext:TextField ID="txtMBL" runat="server" Width="127" TabIndex="4"  Cls="text">
                </ext:TextField>
            </td>

            <td style="padding-left:10px">
                <asp:Label ID="lblHBL" runat="server" Text="HBL"></asp:Label>
            </td>
            <td>
                <ext:TextField ID="txtHBL" runat="server" Width="127" TabIndex="5"  Cls="text">
                </ext:TextField>
            </td>           
        </tr>
        <tr>
            <td width="40" style="padding-left: 2px">
                <asp:Label ID="lblDest" runat="server" Text="Location"></asp:Label>
            </td>
            <td width="90">
                <div id="divDest" runat="server">
                    <uc1:UserComboBox runat="server" ID="cmbDest" ListWidth="180" clsClass="select_160px"
                        TabIndex="6" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="90"
                        winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                        winHeight="620" isButton="false" />
                </div>
            </td>
            <td width="40" style="padding-left: 10px">
                <asp:Label ID="lblSales" Text="Sales" runat="server"></asp:Label>
            </td>
            <td width="90">
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
                <div id="divSalesman" runat="server">
                    <uc1:UserComboBox runat="server" ID="cmbSalesman" Query="option=SalesList" Width="90"
                        clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                        TabIndex="7" winWidth="680" winHeight="560" isButton="false" />
                </div>
            </td>
            
                         
            <td width="50" style="padding-left: 10px">
                <asp:Label ID="lblSHPR" runat="server" Text="Shipper"></asp:Label>
            </td>
            <td >
                <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="8" clsClass="x-form-text x-form-field text"
                    Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" isDiplay="false" />
            </td>
            
            <td width="50" style="padding-left: 10px">
                <asp:Label ID="lblCNEE" runat="server" Text="Consignee"></asp:Label>
            </td>
            <td>
                <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="9" clsClass="x-form-text x-form-field text"
                    Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" isDiplay="false" />
            </td>
            
            <td width="50" style="padding-left: 10px">
                <asp:Label ID="labcoloader" runat="server" Text="Coloader"></asp:Label>
            </td>
            <td>
                <uc1:AutoComplete runat="server" ID="CmbColoader" TabIndex="10" clsClass="x-form-text x-form-field text"
                    Query="option=CompanyList" Width="100" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                    winWidth="800" winHeight="800" isDiplay="false" />
            </td>           
        </tr>
        <tr>
            <td width="40" style="padding-left: 2px">
                <asp:Label ID="lblVessel" runat="server" Text="Vessel"></asp:Label>
            </td>
            <td>
                <ext:TextField ID="txtVessel" runat="server" Width="90" TabIndex="11"  Cls="text">
                </ext:TextField>
            </td>
            <td width="40" style="padding-left: 10px">
               <asp:Label ID="lblVoyage" runat="server" Text="Voyage"></asp:Label> 
            </td>
            <td>
                <ext:TextField ID="txtVoyage" runat="server" Width="90" TabIndex="12"  Cls="text">
                </ext:TextField>
            </td>
            <td width="40" style="padding-left: 10px">
                <asp:Label ID="lblContainer" runat="server" Text="Container"></asp:Label>
            </td>
            <td>
                <ext:TextField ID="txtContainer" runat="server" Width="127" TabIndex="13"  Cls="text">
                </ext:TextField>
            </td>
            <td></td><td></td>
            <td  width="50" ></td>
            <td  align="right" style="padding-right: 2px" >
                <ext:Button runat="server" Text="Search" ID="btnSearch" Width="65">
                    <DirectEvents>
                        <Click OnEvent="btnSearch_Click">
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:KeyNav ID="keyNav1" Target="#{form1}" runat="server">
                    <Enter Handler="btnSearch.fireEvent('click')" />
                </ext:KeyNav>
            </td>
            
        </tr>
     
    </table>
    <table><tr><td style="height:2px;"></td></tr></table>
    <div id="div1" runat="server" style="padding-left: 10px">
        <iframe id="mainReference" height="550px" width="900px" scrolling="yes" src="<%=href() %>"
            name="mainReport" frameborder="0"></iframe>
    </div>
    </form>
</body>
</html>
