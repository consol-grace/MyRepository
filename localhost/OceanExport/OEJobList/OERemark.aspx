<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OERemark.aspx.cs" Inherits="OceanExport_OEJobList_OERemark" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <%-- <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>--%>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
   <%-- <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>  
    <div id="div_title" style="margin-top:2px; margin-left:2px">
           <table width="995" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
                        <tr>
                            <td width="150"  style="padding-left: 5px">OE - <span style="font-size:11px;">托 运 单 备 注</span>
                            </td>
                        </tr>
            </table>
    </div>
    <table style=" margin-top:35px; margin-left:2px;"><tr><td>
    <ext:TextArea ID="txtRemark" runat="server"  Width="584px" Height="100px" style="font-family:Courier New" TabIndex="1"  >
    </ext:TextArea>
    </td><td style="vertical-align:bottom; padding-left:10px;">
    <ext:Button ID="btnSave" runat="server" Cls="Submit_70px" Width="70px" Text="Save" TabIndex="2">
                                                <DirectEvents>
                                                    <Click OnEvent="btnSave_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
    </td></tr></table>    
    
    </form>
</body>
</html>
