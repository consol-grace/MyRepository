<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportCopy.aspx.cs" Inherits="BasicData_Report_ReportCopy" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div style="width: 970px; margin-top: 10px; margin-left: 13px">
    <div id = "divTitle" style=" display:none">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                    <table cellpadding="0" cellspacing="0" border="0" width="100%" height="25px">
                        <tr>
                            <td>
                                All Report
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div style="height: 10px;">
    </div>
    <div id="divPanelContent">
      <ext:TabPanel ID="tabPanel" runat="server" Width="970"  Border="true" Padding="8" Height="700">
            <Items>
                <ext:Panel ID="Panel1" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat1" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE1" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport1" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI1" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE1" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI1" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT1" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT1" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM1" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK1" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK1" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK1" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport1" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat2" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE2" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport2" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblAI2" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE2" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI2" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT2" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT2" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                       <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM2" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK2" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK2" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK2" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport2" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel3" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat3" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE3" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport3" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblAI3" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE3" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI3" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT3" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT3" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM3" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK3" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK3" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK3" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport3" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>
                
                <ext:Panel ID="Panel4" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat4" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE4" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport4" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblAI4" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE4" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI4" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT4" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                         <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT4" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM4" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK4" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK4" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK4" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport4" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel5" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat5" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE5" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport5" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI5" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE5" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI5" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT5" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT5" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM5" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK5" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK5" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK5" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport5" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel6" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat6" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE6" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport6" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI6" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE6" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI6" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT6" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT6" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM6" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK6" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK6" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK6" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport6" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>
                 
                <ext:Panel ID="Panel7" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat7" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE7" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport7" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI7" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE7" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI7" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT7" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT7" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM7" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK7" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK7" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK7" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport7" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel8" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat8" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE8" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport8" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI8" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE8" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI8" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT8" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT8" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM8" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK8" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK8" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK8" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport8" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel9" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat9" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE9" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport9" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI9" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE9" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI9" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT9" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT9" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM9" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK9" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK9" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK9" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport9" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel10" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat10" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE10" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport10" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI10" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE10" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI10" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT10" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT10" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM10" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK10" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK10" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK10" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport10" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel11" Title="" ActiveIndex="0" runat="server" Width="720" autoScroll="true">
                    <Items> 
                        <ext:Label ID="lblStat11" runat="server" Hidden="true"></ext:Label> 
                        <ext:Label ID="lblAE11" Text="AE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAE11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                     <Items>
                        <ext:CheckboxGroup ID="ChkGroupAEReport11" runat="server" columns="5" >
                        </ext:CheckboxGroup>
                    </Items>
                    <Items>
                        <ext:Label ID="lblAI11" Text="AI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAI11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupAIReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblOE11" Text="OE :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOE11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOEReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOI11" Text="OI :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOI11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOIReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblAT11" Text="AT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllAT11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                     </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupATReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                     <Items> 
                        <ext:Label ID="lblOT11" Text="OT :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllOT11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupOTReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblDM11" Text="DM :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllDM11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupDMReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblTK11" Text="TK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllTK11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupTKReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                    <Items> 
                        <ext:Label ID="lblBK11" Text="BK :" runat="server" StyleSpec="font-weight:bold;font-size:10px;"></ext:Label>
                        <ext:Checkbox runat="server" BoxLabel="ALL" ID="chkAllBK11" StyleSpec="margin-left:3px;"></ext:Checkbox>
                    </Items>
                    <Items>
                        <ext:CheckboxGroup ID="ChkGroupBKReport11" runat="server" columns="5">
                        </ext:CheckboxGroup>
                    </Items>
                </ext:Panel>
            </Items>
            <Listeners>
            <TabChange Handler="bindClick()"/>
            </Listeners>
        </ext:TabPanel>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function bindCheckAll(obj) {//全选事件
//        if ($(obj).attr("id") == "chkAllAE1") {
//            if (obj.checked) {
//                $("#ChkGroupAEReport1 input[type='checkbox']").attr("checked", "checked");
//            } else {
//                $("#ChkGroupAEReport1 input[type='checkbox']").attr("checked", "");
//            }
//        } else if ($(obj).attr("id") == "chkAllAE1") { 
//            
        //        }
//        alert($(obj).parent().next().attr("id"));
        var checkGroupID = $(obj).parent().next().attr("id");
        if (obj.checked) {
            $("#" + checkGroupID + " input[type='checkbox']").attr("checked", "checked");
        } else {
            $("#" + checkGroupID + " input[type='checkbox']").attr("checked", "");
        }

        checkboxClick(obj, "CheckAll");//修改值
    }

    function bindClick() {

//        $("#chkAllAE1").unbind("click");
//        $("#chkAllAE1").click(function () {
//            bindCheckAll(this);
//        });

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupAEReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupAEReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllAE" + i).unbind("click");
            $("#chkAllAE" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupAIReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupAIReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllAI" + i).unbind("click");
            $("#chkAllAI" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupOEReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupOEReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllOE" + i).unbind("click");
            $("#chkAllOE" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupOIReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupOIReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllOI" + i).unbind("click");
            $("#chkAllOI" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupATReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupATReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllAT" + i).unbind("click");
            $("#chkAllAT" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupOTReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupOTReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllOT" + i).unbind("click");
            $("#chkAllOT" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupDMReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupDMReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllDM" + i).unbind("click");
            $("#chkAllDM" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupTKReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupTKReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllTK" + i).unbind("click");
            $("#chkAllTK" + i).click(function () {
                bindCheckAll(this);
            });
        }

        for (var i = 1; i < 12; i++) {
            $("#ChkGroupBKReport" + i + " input[type='checkbox']").unbind("click");
            $("#ChkGroupBKReport" + i + " input[type='checkbox']").click(function () {
                checkboxClick(this, "");
            });

            $("#chkAllBK" + i).unbind("click");
            $("#chkAllBK" + i).click(function () {
                bindCheckAll(this);
            });
        }
}

function checkboxClick(obj, IsCheckAll) {
    var isCheck = "";
    if (obj.checked) {
        isCheck = "1";
    } else {
        isCheck = "0";
    }
//    alert(Ext.getCmp($(obj).attr("ID")).tag);
    if (Ext.getCmp($(obj).attr("ID")).tag != "" || Ext.getCmp($(obj).attr("ID")).tag != undefined) {

        $.getJSON("DataController.ashx?IsCheck=" + isCheck + "&SeedKey=" + Ext.getCmp($(obj).attr("ID")).tag + "&IsCheckAll=" + IsCheckAll + "&v=" + new Date().getTime(), function (data) {
            if (data == "N") {
                alert("Failed!");
                window.location.reload();
            }
//            else
//                alert("成功!");
        })
    } else {
        alert("请稍后再试!");
    }
}
</script> 
<script type="text/javascript">
    Ext.onReady(function () {
        var isWin = getParam("isWin");
        if (isWin == "1") {//窗体里
            $("#divTitle").css("display", "none");
            tabPanel.setHeight(document.documentElement.clientHeight - 30);
        } else {
            $("#divTitle").css("display", "block");
            tabPanel.setHeight(document.documentElement.clientHeight - 175);
        }

    });

function getParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var schema = window.location.toString(); 
    if (schema.indexOf("?") < 1) {
        return "";
    }
    else {
        schema = schema.substr(schema.indexOf("?") + 1);
    }
    var result = schema.match(reg);
    if (result != null)
        return unescape(result[2]);
    else
        return "";
}
</script>
