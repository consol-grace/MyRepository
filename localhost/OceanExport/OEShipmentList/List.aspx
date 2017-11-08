<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEShipmentList_List" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
      <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
      <style type="text/css"> 
        .tipLeft
        {
            left:320px !important;
            background-color:#ffffff;
        }
        
        .tipHide{
          padding: 25px;
          background-color: rgba(0,0,0,0);/* IE9、标准浏览器、IE6和部分IE7内核的浏览器(如QQ浏览器)会读懂 */
        }
        @media \0screen\,screen\9 {/* 只支持IE6、7、8 */
          .tipHide{
            background-color:#000000;
            filter:Alpha(opacity=0);
            position:static; /* IE6、7、8只能设置position:static(默认属性) ，否则会导致子元素继承Alpha值 */
            *zoom:1; /* 激活IE6、7的haslayout属性，让它读懂Alpha */
          }
        }
    </style>
     <script type="text/javascript">
        function RefreshList() {
         Ext.getCmp('btnFilter').fireEvent('click', this);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">            
    </ext:ResourceManager>
    <div style="width:965px; margin-top:10px; margin-left:13px">
        <table width="965px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="965" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="680" align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        OE - Booking List
                                    </td>
                                    <td width="288" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px">
                                        
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table  class="table" style=" padding:8px 0">
            <tbody>
                <tr>
                    <td width="40" align="left">
                        <table width="40" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        HBL#
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:TextField ID="txtHawb" runat="server" Cls="text" TabIndex="1"></ext:TextField>
                        
                    </td>
                    <td width="40" align="left">
                        <table width="40" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Shipper
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="2"></ext:TextField>                        
                    </td>
                   
                    <td width="50" align="center">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                     <ext:Checkbox ID="chkVoid" runat="server" BoxLabel="Void">
                                     <Listeners>
                                      <Check Handler="Ext.getCmp('btnFilter').fireEvent('click', this);" />
                                     </Listeners>
                                     </ext:Checkbox>   
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td  align="left">
                        <ext:Button ID="btnFilter" runat="server" Cls ="Submit" Text="Search" Width="80" AutoFocus="true"  AutoShow="true" Selectable="true">
                            <DirectEvents>
                                 <Click OnEvent="btnFilter_Click">
                                        <EventMask  ShowMask="true" Msg="Searching..."  CustomTarget="gridList"/>   
                                 </Click>                                                                                                 
                            </DirectEvents>                            
                        </ext:Button>
                        <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                <Enter  Handler="btnFilter.fireEvent('click');"/>
                        </ext:KeyNav>
                    </td>
                     <td  align="left"> 
                     <ext:Button ID="btnAssign" runat="server" Text="Assign Job" Width="80">
                 <DirectEvents>
                <Click OnEvent="btnAssign_Click">
                <ExtraParams>
                <ext:Parameter Name="RowID" Value="Ext.encode(#{gridList}.getRowsValues({selectedOnly : true}))" Mode="Raw" />
                </ExtraParams>
                </Click>
                </DirectEvents>
        </ext:Button>
                     </td>
                     
                </tr>
            </tbody>
        </table>        
        <ext:GridPanel runat="server" ID="gridList" TrackMouseOver="true" Width="965" Height="368">
                        <LoadMask ShowMask="true" Msg=" Loading ... " />
                        <Store>
                            <ext:Store runat="server" ID="storeHBL" OnRefreshData="storeHBL_OnRefreshData">
                                <Reader>
                                    <ext:JsonReader IDProperty="o_Seed">
                                        <Fields>
                                            <ext:RecordField Name="o_ROWID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_Seed">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_ScheduleDate" Type="Date">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_BookNo">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_HBL">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_Shipper">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_Consignee">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_LocFinal">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_ServiceMode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_PKGS">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_Unit">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_WT">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_CBM">
                                            </ext:RecordField>
                                            <ext:RecordField Name="o_PaymentMode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Action">
                                            </ext:RecordField>
                                             <ext:RecordField Name="TS">
                                            </ext:RecordField>
                                               <ext:RecordField Name="OIHBL">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ctl1762">
                            <Columns>
                               <ext:DateColumn Header="Date" DataIndex="o_ScheduleDate" Width="50px"  Format="dd/m" ></ext:DateColumn>
                               <ext:Column Header="Booking#" DataIndex="o_BookNo" Width="115">
                                </ext:Column>
                                <ext:Column Header="HBL#" DataIndex="o_HBL" Width="112">
                                </ext:Column>
                                 <ext:Column Header="T/S" DataIndex="TS" Width="45" Align="Center">
                                </ext:Column>
                                 <ext:Column Header="Shipper" DataIndex="o_Shipper" Width="85">
                                </ext:Column>
                                <ext:Column Header="Consignee" DataIndex="o_Consignee" Width="85">
                                </ext:Column>
                                <ext:Column Header="Dest" DataIndex="o_LocFinal" Width="50" Align="Center" >
                                </ext:Column>
                                <ext:Column Header="Ser. Mode" DataIndex="o_ServiceMode" Width="70">
                                </ext:Column>
                                <ext:Column Header="P/C" DataIndex="o_PaymentMode" Width="40" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="CBM" DataIndex="o_CBM" Width="60" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="WT" DataIndex="o_WT" Width="65" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="PKGS" DataIndex="o_PKGS" Width="55" Format="0" Align="Right">
                                </ext:NumberColumn>
                                <ext:Column Header="Unit" DataIndex="o_Unit" Width="40" Align="Center">
                                </ext:Column>
                                 <ext:Column Header="Action" DataIndex="Action" Width="50" Align="Center">
                                </ext:Column>
                                <ext:Column Header="ID" DataIndex="o_ROWID" Hidden="true"></ext:Column>
                                <ext:Column Header="Seed" DataIndex="o_Seed" Hidden="true"></ext:Column>
                                <ext:Column Header="OIHBL" DataIndex="OIHBL" Hidden="true"></ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:CheckboxSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="false" CheckOnly="false">
                            </ext:CheckboxSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                <ext:PagingToolbar   PageSize="100"  DisplayInfo="true"  ID="PagingToolbar1"  runat="server"></ext:PagingToolbar>
               </BottomBar>
                    </ext:GridPanel>
         <ext:ToolTip 
            ID="RowTip1" 
            runat="server" 
            Target="={#{gridList}.getView().mainBody}" 
            Delegate=".x-grid3-row" 
            TrackMouse="false" 
            width="250px"
            quickShowInterval="500"
              Cls="tipLeft" 
            >
              <Listeners>
                <Show Handler="var rowIndex = #{gridList}.view.findRowIndex(this.triggerElement);var OIHbl=#{storeHBL}.getAt(rowIndex).get('OIHBL');if(OIHbl!=''){this.body.dom.innerHTML =  #{storeHBL}.getAt(rowIndex).get('OIHBL');
              $('#RowTip1').css('border','1px solid #8DB2E3');$('#RowTip1').removeClass('tipHide');
              }else{ this.body.dom.innerHTML = '';$('#RowTip1').css('border','0px solid #8DB2E3');$('#RowTip1').addClass('tipHide');}
             $('.x-shadow').css('display','none');$('.x-ie-shadow').css('display','none');
             $('.x-tip-tc, .x-tip-tl, .x-tip-tr, .x-tip-bc, .x-tip-bl, .x-tip-br, .x-tip-ml, .x-tip-mr').css('background-image','none');
             "/>
            </Listeners>
             </ext:ToolTip> 
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        setGridSize();
    });
</script>
