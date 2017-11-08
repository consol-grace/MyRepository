<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManifestDetail.aspx.cs" Inherits="OceanExport_OEBillOfLading_ManifestDetail" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Container</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../../css/style.css"rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script  type="text/javascript">
        $(document).ready(function() {
        if ($("#Display0").length > 0) {
            if ($("#Display0").css("display") == "none") {
                $("#Display0").css("display", "block");
            }
        }
        });
        function ShowDisplay(obj) {
            for (var i = 0; i < 50; i++) {
                if ($("#Display" + i).length > 0) {
                    $("#Display"+i).css("display", "none");
                }
                else {
                    break;
                }
                       }

           
            if ($("#" + obj).css("display") == "none") {
                $("#" + obj).css("display", "block");
                
            }
            else {
                $("#" + obj).css("display", "none");
            }
       }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidHBL" runat="server">
    </ext:Hidden>

    <div id="div_title" style="margin-left:12px; margin-top:5px;">  
           <table width="576px" border="0" cellspacing="0" cellpadding="0" height="20px">
                        <tr>
                            <td width="576px" class="table_nav1 font_11bold_1542af" style="padding-left: 0px">
                            <table width="100%"><tr><td style="padding-left:5px; line-height:20px"> OE - Container</td>
                            <td align="right" width="55px"><ext:Button ID="btnSave" runat="server" Text="Save" Cls="font_11px_bold2" StyleSpec="margin:0px 2px;" Width="55px">
                                            <DirectEvents>
                                                <Click OnEvent="btnSave_Click">
                                                    <EventMask Msg=" Saving... " ShowMask="true"  Target="Page"/>
                                                </Click>
                                            </DirectEvents>
                               </ext:Button></td>
                               <td  align="right"  width="55px">
                               <ext:Button ID="btnCancel" runat="server" Text="Cancel" Cls="font_11px_bold2" StyleSpec="margin:0px 2px;" Width="55px">
                                            <DirectEvents>
                                                <Click OnEvent="btnCancel_Click">
                                                   <EventMask Msg=" Canceling... " ShowMask="true"  Target="Page"/>
                                                </Click>
                                            </DirectEvents>
                               </ext:Button>
                               </td>
                               </tr></table>
                              
                            </td>
                        </tr>
                    </table>
    </div>
        <br /><br /> 
         <table border="0" cellpadding="0" cellspacing="4" style="width: 575px; margin-left:8px; margin-top:20px">
          <tr>
          <td style="padding-bottom:3px; padding-top:3px">Container Information</td>
          </tr>
          <tr>
          <td width="350px">  <ext:TextArea ID="txtInfor" runat="server"  TabIndex="9" Width="576px" Height="65px" style="font-family:Courier New" Disabled="true" >
                                                </ext:TextArea></td>
          </tr>
          </table>
         
         <table cellpadding="0" cellspacing="0" border="0" width="300" style="margin-left:8px;padding-top:8px"><tbody><tr>
                <td style="padding-left:5px;" class="style2" valign="top">
                <table cellpadding="0" cellspacing="0" border="0" width="144" style="border:1px solid #b5b8c8">
                <tbody>
                <tr>
                 <td style="padding-left:4px">Marks and Numbers</td></tr></tbody></table></td>
                <td align="left" style="vertical-align:top"><table cellpadding="0" cellspacing="0" border="0" width="84" style="border-top:1px solid #b5b8c8; border-bottom:1px solid #b5b8c8;"><tbody><tr><td  style="padding-left:5px">No. PKGs</td></tr></tbody></table></td>
                <td><table border="0" cellpadding="0" cellspacing="0" width="348px" style="border:1px solid #b5b8c8"><tbody><tr><td style="padding-left:5px">Goods Description</td></tr></tbody></table></td>
                <td style="padding-left:5px"></td>
                <td style="padding-left:3px">
                </td>
                </tr>
         </tbody></table>
         <table border="0" cellpadding="0" cellspacing="4" style="margin-left:8px;"> 
                        <tr>
                            <td colspan="5" valign="top" align="left">
                                <asp:Repeater ID="repList" runat="server">
          <ItemTemplate>
                                <table style="margin-left:0px; height:30px"> <tr onclick='ShowDisplay("Display<%# Container.ItemIndex %>");' style="cursor:pointer;" ><td ><img src="../../images/arrows_btn_01.png" /></td><td style="padding-left:10px;color:#1542AF; font-weight:bolder;">
                                <%#Eval("title")%><asp:HiddenField   id="hidID" runat="server" value='<%#Eval("oc_ROWID") %>'/></td></tr></table>
                                <div id="Display<%# Container.ItemIndex %>" style="overflow:scroll;overflow-x:hidden; height:110px; width:584px; margin-bottom:10px;display:none;" align="left" class="div_line">
                                <div  style="float:left;  position:absolute; margin-left:148px; width:78px;">
                                <table cellpadding="0" cellspacing="0" border="0"  style="background-color:#ffffff; border-bottom:1px solid #b5b8c8" >
                                <tr>   
                                <td align="left" class="style4" style="height:14px">
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="50"  align="right" style="padding-left:2px" >
                                                            <span><%#Eval("oc_Piece")%></span>
                                                        </td>
                                                        <td width="60" style="padding-left: 1px;" align="left" >
                                                     
                                                            <span><%#Eval("oc_Unit")%></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td></tr></table>
                                            </div>
                                    <table border="0" cellspacing="0" cellpadding="0" style="width: 66%">
                                        <tr>
                                            <td rowspan="2" valign="top"  align="left"  >  
                                           <%--  <textarea name="txtM"  style="width:145px; height:2251px;vertical-align:top; font-family:Courier New; overflow-y:hidden; padding-top:5px; text-align:left;" class="div_boder" runat="server">
                                             <%#Eval("oc_OrderMarks")%>
                                             </textarea>--%>
                                                <asp:TextBox runat="server" TextMode="MultiLine" ID="txtM" Text='<%#Eval("oc_OrderMarks")%>' style="width:137px; height:2251px;vertical-align:top; font-family:Courier New; overflow-y:hidden; padding:2px 3px; text-align:left; font-size:12px;" class="div_boder" >
                                                  </asp:TextBox> 
                                            </td>
                                               <td valign="top" align="left"  style="padding-left:3px; padding-right:3px">
                                               <%--  <textarea name="txtP"  style="width:82px; height:2250px; vertical-align:top; font-family:Courier New; overflow-y:hidden; padding-top:17px;text-align:left;"  class="div_boder"  runat="server">
                                                 <%#Eval("oc_OrderNoOfPackage")%>
                                                 </textarea>--%>
                                                  <asp:TextBox runat="server" TextMode="MultiLine" ID="txtP" Text='<%#Eval("oc_OrderNoOfPackage")%>' style="width:74px; height:2238px; vertical-align:top; font-family:Courier New; overflow-y:hidden; padding-top:17px;text-align:left; font-size:12px;"  class="div_boder" >
                                                  </asp:TextBox> 
                                            </td>
                                            <td rowspan="2" valign="top" >
                                               <%--  <textarea name="txtD"  style="width:331px; height:2251px;vertical-align:top; font-family:Courier New; overflow-y:hidden; padding-top:5px; text-align:left;" class="div_boder" runat="server">
                                                  <%#Eval("oc_OrderDescription")%></textarea>--%>
                                                  <asp:TextBox runat="server" TextMode="MultiLine" ID="txtD" Text='<%#Eval("oc_OrderDescription")%>'   style='width:332px;height:2251px;vertical-align:top; font-family:Courier New; overflow-y:hidden;  padding:2px 3px; text-align:left;font-size:12px;' class="div_boder">
                                                  </asp:TextBox>
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </div>
                                          
          </ItemTemplate>
          </asp:Repeater>
        
                            </td>
                        </tr>
           </table>
     
                <table cellpadding="0" cellspacing="0" border="0" style="padding-left:95px"><tbody><tr>
                <td align="right">
                Total PKGS</td>
                <td align="left" style="padding-left:4px; vertical-align:top">
                <ext:TextField ID="totalPKGS" runat="server" style="font-family:Courier New"  Disabled="true" Width="78px"></ext:TextField>
                </td>
                <td ></td>
                <td ></td>
                <td >
                </td>
                </tr>
           </tbody></table>
           <br />
    </form>
</body>
</html>
