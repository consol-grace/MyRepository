<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Container.aspx.cs" Inherits="OceanImport_OceanShipmentJobList_Container" %>
<%@ Register src="../../common/UIControls/UserControlTop.ascx" tagname="UserControlTop" tagprefix="uc1" %>
<%@ Register src="../../common/UIControls/UserComboBox.ascx" tagname="UserComboBox" tagprefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Container</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="/common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
    <script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../AjaxServer/Container.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-weight: bold;
            color: #1542af;
            width: 766px;
        }
        .style2
        {
            width: 287px;
        }
        .style3
        {
            width: 257px;
        }
        .style4
        {
            width: 178px;
        }
        .style5
        {
            width: 98px;
        }
    </style>
    <script language="javascript">
        function DeleteMsg() {
            Ext.Msg.confirm('Information', 'Are you sure you want to delete?', function(btn) {
                if (btn == "yes") {

                    CompanyX.btnDelete_Click();
                    return true;
                }
                else {
                    return false;
                }
            });
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
    <ext:Store runat="server" ID="StoreCN" OnRefreshData="StoreCN_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreServiceMode" OnRefreshData="StoreServiceMode_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreDes">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <div id="div_title" style=" width:100%"><uc1:UserControlTop ID="UserControlTop1" runat="server" sys="O"/></div>
    <ext:Container runat="server" ID="div_bottom"></ext:Container>    
    <div id="div_title" style="margin-top:80px; margin-left:10px;z-index:1;">
           <table width="590" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="590" class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                             <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                 alt="View" onclick="createFrom('OIContainer');" />
                               &nbsp; OI - Container&nbsp; 
                            </td>
                        </tr>
                    </table>
                    </div>
        <table width="600" border="0" cellpadding="0" cellspacing="0" style=" margin-top:100px;  margin-bottom:10px; margin-left:10px">
            <tr>
                <td height="10px" colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table border="0" cellspacing="4" cellpadding="0" style="width: 660px">
                        <tr>
                            <td width="65" height="17" style="padding-left: 2px">
                                Container#
                            </td>
                            <td class="font_11px_gray">
                                <ext:TextField ID="txtContainer" runat="server" Cls="text_80px" TabIndex="1">
                                </ext:TextField>
                            </td>
                            <td>
                                Seal#
                            </td>
                            <td class="font_11px_gray">
                                <ext:TextField ID="txtSeal" runat="server" Cls="text_80px" TabIndex="2">
                                </ext:TextField>
                            </td>
                            <td>
                                Size
                            </td>
                            <td width="261" class="font_11px_gray">
                                <table width="100" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="85">
                                              <uc1:UserComboBox runat="server" ID="CmbSize" ListWidth="180" clsClass="select_65"
                                                  TabIndex="3" Query="option=ContainerSize" StoreID="StoreCN" Width="67" winTitle="Container Size"
                                                  winUrl="/BasicData/ContainerSize/ContainerSize.aspx?sys=O" winWidth="450" winHeight="585" />
                                        </td>                                       
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 2px">
                                Ser. Mode
                            </td>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                              <uc1:UserComboBox runat="server" ID="CmbSerMode" ListWidth="180" clsClass="select_65"
                                                  TabIndex="4" Query="option=ServerMode" StoreID="StoreServiceMode" Width="67"
                                                  winTitle="Service Mode" winUrl="/BasicData/ServiceMode/ServiceMode.aspx?sys=O"
                                                  winWidth="516" winHeight="585" />
                                        </td>                                      
                                    </tr>
                                </table>
                            </td>
                            <td>
                                S/O#
                            </td>
                            <td>
                                <ext:TextField ID="txtSO" runat="server" Cls="text_80px" TabIndex="5">
                                </ext:TextField>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="65" style="padding-left: 2px">
                                WT
                            </td>
                            <td width="95">
                                <ext:NumberField ID="txtGWT" runat="server" Cls="text_80px" TabIndex="6" DecimalPrecision="3">
                                </ext:NumberField>
                            </td>
                            <td width="32">
                                CBM
                            </td>
                            <td width="80">
                                <span class="font_11px_gray">
                                    <ext:NumberField ID="txtCBM" runat="server" Cls="text_80px" TabIndex="7"  DecimalPrecision="3">
                                    </ext:NumberField>
                                </span>
                            </td>
                            <td width="39">
                                Pkg(s)
                            </td>
                            <td>
                                <table width="200" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="82">
                                            <ext:NumberField ID="txtPiece" runat="server" Cls="text_80px" TabIndex="8">
                                                <Listeners>
                                                    <Blur Handler="#{lblPiece}.setValue(this.getValue());#{lblUnit}.setText($('#CmbUnit').val())" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        
                                        <td width="105">
                                         <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                             TabIndex="9" StoreID="StoreUnit" Width="58" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx"
                                             winWidth="510" winHeight="585" Handler="$('#lblUnit').html($('#CmbUnit').val())" />
                                        </td>
                                       
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" align="right" style="padding-top:5px; padding-right:68px">
                                <table>
                                    <tr>
                                        <td>
                                            <ext:Button ID="btnDelete" runat="server" Cls="Submit_70px" Width="70px" Text="Delete">
                                                 <Listeners>
                                                <Click Handler="DeleteMsg();" />
                                                </Listeners>
                                                <%--<DirectEvents>
                                                    <Click OnEvent="btnDelete_Click">
                                                        <EventMask ShowMask="true" Msg=" Deleting ... " />
                                                    </Click>
                                                </DirectEvents>--%>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <ext:Button ID="btnNext" runat="server" Cls="Submit_70px" Width="70px" Text="Next">
                                                <DirectEvents>
                                                    <Click OnEvent="btnNext_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <ext:Button ID="btnCancel" runat="server" Cls="Submit_70px" Width="70px" Text="Cancel">
                                                <DirectEvents>
                                                    <Click OnEvent="btnCancel_Click">
                                                        <EventMask ShowMask="true" Msg=" Canceling ... " />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td>
                                            <ext:Button ID="btnSave" runat="server" Cls="Submit_70px" Width="70px" Text="Save">
                                                <DirectEvents>
                                                    <Click OnEvent="btnSave_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom:5px;padding-left:6px; vertical-align:top">
                Import Devanning 
                </td>
            </tr>
            <tr>
                <td style="padding-left:6px">
                    <ext:TextArea ID="txtRemark" runat="server" StyleSpec="font-family:Arial, Helvetica, sans-serif; font-size:11px; height:45px; width:572px" TabIndex="9">
                    </ext:TextArea>
                </td>
            </tr>
            <tr><td style="height:5px"></td></tr>
            
            <tr>
                <td height="10" colspan="2">
                    <table width="590" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF"
                                class="style1" style="padding-left: 5px">
                                BL Information
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top:4px">
                <table cellpadding="0" cellspacing="0" border="0" width="300"><tr>
                <td style="padding-left:6px" class="style2" valign="top">
                <table cellpadding="0" cellspacing="0" border="0"  width="120px">
                <tr>
                 <td>Marks and Numbers</td></tr></table></td>
                <td align="left" style="padding-left:30px; vertical-align:top"><table cellpadding="0" cellspacing="0" border="0" width="50"><tr><td>No. PKGs</td></td></tr></table></td>
                <td style="padding-left:36px"><table  border="0" cellpadding="0" cellspacing="0" width="128px"><tr><td>Description of <br /> Packages and Goods</td></tr></table></td>
                <td style="padding-left:5px"><ext:ComboBox ID="CmbDescrip" runat="server" Cls="select" DisplayField="text" ForceSelection="true" TabIndex="10"
                                                Mode="Local" TriggerAction="All" StoreID="StoreDes"  ValueField="text"
                                                Width="149"      ListWidth="300" >
                                                <DirectEvents>
                                                    <Select OnEvent="CmbDescripSelect_Click">
                                                    </Select>
                                                </DirectEvents>
<Template Visible="False" ID="ctl265" StopIDModeInheritance="False" EnableViewState="False"></Template>
                                            </ext:ComboBox></td>
                <td style="padding-left:3px"><ext:ImageButton ID="imgDes" runat="server" ImageUrl="~/images/select_btn.jpg" > 
                                             <DirectEvents>
                                                    <Click OnEvent="imgDes_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:ImageButton></td>
                </tr>
           </table>
          
        <table border="0" cellpadding="0" cellspacing="4" style="width: 564px">
                        
                        <tr>
                            <td>
                           <div style="float:left;  position:absolute; margin-left:150px;margin-top:3px;width:82px"  >
                           <table cellpadding="0" cellspacing="0" border="0"  style="background-color:#ffffff; border-bottom:1px  solid #b5b8c8" width="82px"><tr>
                           
                                                        <td width="56"  align="right" style="padding-left:2px" >
                                                            <ext:TextField ID="lblPiece" runat="server" Width="56" StyleSpec="border:0; background-image:none; background-color:#fff; text-align:right;padding-bottom:2px;"
                                                                Cls="font_11bold">
                                                            </ext:TextField>                                                        </td>
                                                        <td width="60" style="padding-left: 1px;" align="left" >
                                                           <ext:Label ID="lblUnit" runat="server" Width="60px"  >
                                                            </ext:Label>
                                                        </td>
                                                    </tr>
                                  
                                      </table>
                                            </div>
                             <div> <table><tr><td colspan="5" valign="top" align="left">
                                <div style="overflow:scroll; overflow-x:hidden; height:180px; width:581px " align="left" class="div_line">
                                    <table border="0" cellspacing="0" cellpadding="0" style="width: 66%">
                                        <tr>
                                            <td rowspan="2" valign="top"  align="left"  class="style5">
                                                <ext:TextArea ID="txtMarks1" runat="server"  TabIndex="9" Width="145px" Height="22506px" style="overflow-y:hidden; font-family:Courier New; padding-top:4px" Cls="div_boder" >
                                                </ext:TextArea>
                                            </td>
                                              <td rowspan="2" valign="top" align="left" class="style4" style="padding-left:3px; padding-right:3px">
                                                <ext:TextArea ID="txtmarks3" runat="server"  Width="82px" Height=" 22506px" style="overflow-y:hidden;font-family:Courier New; padding-top:19px"  Cls="div_boder">
                                                </ext:TextArea>
                                            </td>
                                            <td rowspan="2" valign="top" >
                                                <ext:TextArea ID="txtMarks2" runat="server"  Width="331px" Height="22506px" style="overflow-y:hidden;font-family:Courier New; padding-top:4px" TabIndex="12" Cls="div_boder">
                                                </ext:TextArea>
                                            </td>
                                          
                                        </tr>
                                        
                                    </table>
                                </div>
                                </td>
                           </tr></table></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
   
    </form>
</body>
</html>
