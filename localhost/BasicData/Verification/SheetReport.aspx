<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SheetReport.aspx.cs" Inherits="BasicData_Verification_SheetReport" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Report View</title>
   <link href="/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidsheetNo" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidmbl" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidstatus" runat="server"></ext:Hidden>
    <ext:Hidden ID="hidtop" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidbottom" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidleft" runat="server" Text="0.63"></ext:Hidden>
    <ext:Hidden ID="hidright" runat="server" Text="0.63"></ext:Hidden>
    <table width="100%">
    <tr>
    <td align="center">
    <table style="text-align:left">
    <tr><td td align="right"  style="padding-bottom:5px; padding-top:10px" width="100%">
   <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td align="left" width="200px"><ext:Label ID="lbltishi" runat="server"></ext:Label></td>
    <td  align="right" style="font-weight:bold; padding-right:8px">Printer List:</td>
    <td width="250px" align="Right">
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
 <td width="40px" style="padding-left:5px; display:none;">
 <ext:Button ID="LinBtnPDF" runat="server"  Text="Export" Width="65" AutoFocus="true"  AutoShow="true" Selectable="true"  >
                         <DirectEvents>
                                                    <Click OnEvent="LinBtnPDF_Click">
                                                    </Click>
                                                </DirectEvents>
                                                </ext:Button>
 </td>
    <td width="40px" style="padding-left:5px">
                 
                          <ext:Button ID="LinBtnPrint" runat="server"  Text="Print" Width="65" AutoFocus="true"  AutoShow="true" Selectable="true" >
                          <DirectEvents>
                                                    <Click OnEvent="LinBtnPrint_Click">
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
      DisplayToolbar="false" SeparatePages="false" ShowAllPageIds="false" EnableDrillDown="false"/>
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

