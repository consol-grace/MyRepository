<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OECallNo_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script> 
       <script language="javascript" type="text/javascript">
           var FormatNumber3 = function(obj) {
               if (obj != null) {
                   return obj.toFixed(3);
               }
           }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">        
    </ext:ResourceManager>
    <div>
     <ext:Window 
            ID="Window1" 
            runat="server" 
            Resizable="false"
            Height="200" 
            Title="Call Form"
            Draggable="true"
            Width="230"
            Modal="false"
            Padding="6"
            PageY="150"
            PageX="200"
            Closable="false"
            >
            <Content>
            <table cellpadding="3" cellspacing="2">
            <tr>
            <td  style="padding:1px 0"><ext:Radio runat="server" ID="rdLot" Name="rablist" Checked="true"  Width="23px"></ext:Radio></td>
            <td style="padding-top:5px" class="font_11px">Lot No.</td><td style="padding-top:6px">
            <ext:TextField runat="server" ID="txtLot" TabIndex="1" Cls="text_80px" Width="128" AutoFocus="true">
            <Listeners>
            <Focus Handler="CompanyX.Check('rdLot')" />
            </Listeners>
            </ext:TextField></td>
            </tr>
             <tr>
              <td style=" padding:1px 0"><ext:Radio runat="server" ID="rdBKNo" Name="rablist"  Width="23px"></ext:Radio></td>
            <td style="padding-top:5px"  class="font_11px">BK No.</td><td style="padding-top:5px">
            <ext:TextField runat="server" ID="txtBKNo" TabIndex="2" Cls="text_80px" Width="128">
            <Listeners>
            <Focus Handler="CompanyX.Check('rdBKNo')" />
            </Listeners>
            </ext:TextField></td>
            </tr>
              <tr>
            <td style=" padding:1px 0"><ext:Radio runat="server" ID="rdMbl" Name="rablist"  Width="23px"></ext:Radio></td>
            <td  class="font_11px" style="padding-top:3px">MBL</td><td style="padding-top:5px">
            <ext:TextField runat="server" ID="txtMbl" TabIndex="3" Cls="text_80px" Width="128">
            <Listeners>
            <Focus Handler="CompanyX.Check('rdMbl')" />
            </Listeners>
            </ext:TextField></td>
            </tr>
              <tr>
              <td style=" padding:1px 0"><ext:Radio runat="server" ID="rdHbl" Name="rablist"  Width="23px"></ext:Radio></td>
            <td style="padding-top:5px"  class="font_11px">HBL</td><td style="padding-top:5px">
            <ext:TextField runat="server" ID="txtHbl" TabIndex="4" Cls="text_80px" Width="128">
            <Listeners>
            <Focus Handler="CompanyX.Check('rdHbl')" />
            </Listeners>
            </ext:TextField></td>
            </tr>
             <tr>
             <td style=" padding:1px 0"><ext:Radio runat="server" ID="rdInvoice" Name="rablist"  Width="23px"></ext:Radio></td>
            <td  class="font_11px" style="padding-top:4px; padding-right:3px">Invoice </td><td style="padding-top:4px">
            <ext:TextField runat="server" ID="txtInvoice" TabIndex="5" Cls="text_80px" Width="128">
            <Listeners>
            <Focus Handler="CompanyX.Check('rdInvoice')" />
            </Listeners>
            </ext:TextField></td>
            </tr>
            <tr><td colspan="3" style="padding-left:72px; padding-top:5px"><table width="100%"><tr><td>
            <ext:Button ID="btnDetail" runat="server" Text="Open" Cls="Submit_70px"  Width="59px" Height="18px" >
            <DirectEvents>
            <Click OnEvent="btnDetail_Click">
            <EventMask ShowMask="true" Msg=" Waiting ... " />
            </Click>
            </DirectEvents>
            </ext:Button></td>
            <td><ext:Button ID="btnLotlist" runat="server" Text="Lot Detail" Cls="Submit_70px"  Width="62px" Height="18px">
            <DirectEvents>
            <Click OnEvent="btnLotlist_Click">
            <EventMask ShowMask="true" Msg=" Waiting ... " /></Click>
            </DirectEvents>
            </ext:Button></td></tr></table>
            </td></tr>
            </table>
            </Content>
       </ext:Window>
       
    </div>
    </form>
</body>
</html>
