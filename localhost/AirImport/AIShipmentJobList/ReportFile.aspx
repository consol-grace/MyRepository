<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportFile.aspx.cs" Inherits="AirImport_AIShipmentJobList_ReportFile" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link href="/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidtype" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidsys" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidtop" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63"></ext:Hidden> 
     <ext:Hidden ID="hidInvDraft" runat="server" Text="1"></ext:Hidden>
    <table width="100%">
    <tr>
    <td align="center">
    <table style="text-align:left">
    <tr><td  align="right"  style="padding-bottom:5px; padding-top:10px" width="100%">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td align="left" width="200px"><ext:Label ID="lbltishi" runat="server"></ext:Label></td>
        <td></td>
    <td  style="font-weight:bold;padding-right:8px;text-align:right; display:block;">Copies</td>
    <td style="padding-left:2px; padding-right:0px;width:45px;display:block;">
                        <ext:ComboBox ID="cmbPrintCount" runat="server" Width="40px" SelectedIndex="0" ListWidth="40px" DisplayField="text" ValueField="value">
                        <Store>
                        <ext:Store ID="storeCopies" runat="server">
                        <Reader>
                        <ext:JsonReader><Fields><ext:RecordField Name="text" /><ext:RecordField Name="value" /></Fields></ext:JsonReader>
                        </Reader>
                        </ext:Store>
                        </Store>
                        </ext:ComboBox>
                        </td>
   <td  align="right" style="font-weight:bold; padding-right:8px;width:45px;">Printer</td>
    <td width="250px" align="right" style="padding-right:5px;">
    <ext:Store runat="server" ID="Store2" >
<Reader>
 <ext:JsonReader>
   <Fields>
            <ext:RecordField Name="text" />
            <ext:RecordField Name="value" />
  </Fields>
 </ext:JsonReader>
</Reader>
</ext:Store>
    <ext:ComboBox ID="CmbPrint"  TabIndex="3"
            runat="server" 
            StoreID="Store2" 
            DisplayField="text"
            ValueField="value"
            Mode="Local"
            ForceSelection="true"
            TriggerAction="All"
            Cls="select"
            width="250"
            SelectOnFocus="true">     
<Template Visible="False" ID="ctl44" StopIDModeInheritance="False"  
            EnableViewState="False"></Template>
</ext:ComboBox>
 </td>
  <td width="56px"  align="center" id="showDraft" runat="server" visible="false">
 <ext:Checkbox ID="chkFlagDraft" runat="server" Checked="true" BoxLabel="Draft"></ext:Checkbox>
 </td>
 <td width="40px" >
 <ext:Button ID="LinBtnPrint" runat="server"  Text="Print" Width="65"  >
                          <DirectEvents>
                                                    <Click OnEvent="LinBtnPrint_Click">
                                                    </Click>
                                                </DirectEvents>
                        </ext:Button>
 </td>
 <td width="40px" id="showBtnDraft" runat="server" visible="false" style="padding-left:5px;"><ext:Button ID="btnInvDraft" runat="server"  Text="Draft" Width="65"  >
                          <DirectEvents>
                                                    <Click OnEvent="btnInvDraft_Click">
                                                    </Click>
                                                </DirectEvents>
                        </ext:Button>
 
 </td>
    <td width="40px" style="padding-left:5px; display:block;">
                 <ext:Button ID="LinBtnPDF" runat="server"  Text="Export" Width="65"  >
                         <DirectEvents>
                                                    <Click OnEvent="LinBtnPDF_Click">
                                                    </Click>
                           </DirectEvents>
                             </ext:Button>
                          
    </td></tr>
    </table>
    </td></tr>
   <tr><td style="border:solid 1px #000;text-align:center;"  colspan="4">
    <table style=" margin:15px;">
    <tr>
    <td style="vertical-align:top; text-align:left; ">
     <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" DisplayGroupTree="false" 
      DisplayToolbar="false" SeparatePages="false" ShowAllPageIds="false"/>
    </td>
    </tr></table>
    </td></tr>
    </table>
    </td>
    </tr>
    </table>
    
    </form>
</body>
</html>
