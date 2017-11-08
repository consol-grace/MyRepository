<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEManageMentList_List" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AE Consol Management</title>
        <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>
    <style type="text/css">
     .x-grid3-cell-inner
        {

            white-space: normal !important;
        }
       
    </style>
    <script language="javascript" type="text/javascript">
        function RefreshList() {
         Ext.getCmp('btnFilter').fireEvent('click', this);
     }
     var afterEdit = function(e) {
         CompanyX.UpdateHawb(e.record.data.RowID, e.value);
     }
     var changeValue = function(e) {
         var str = e.value;
         var strValue = str.replace('+<span style="padding-left:12px;">', '');
         strValue = strValue.replace('└<span style="padding-left:24px;">', '');
         strValue = strValue.replace('</span>', '');
         txtHawbUpdate.setValue(strValue);

     }
    </script>
    
</head>
<body>    
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">            
    </ext:ResourceManager>
    <div style="width:930px; margin-top:10px; margin-left:13px">
        <table width="930px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="925" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="680" align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        AE - Consol Management
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
        <table style="line-height:20px;">
            <tbody>
                <tr>
                    <td width="40" align="left">
                        <table width="40" >
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        HAWB
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                        <ext:TextField ID="txtHawb" runat="server" Cls="text" TabIndex="1"></ext:TextField>
                        
                    </td>
                    <td width="80" align="left">
                        <table width="80" >
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Book No.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                           <ext:TextField ID="txtRef" runat="server" Cls="text" TabIndex="2"></ext:TextField>                  
                    </td>
                    <td width="40" align="left">
                        
                    </td>
                    <td width="80" align="left">
                                               
                    </td>
                    <td width="10" align="left"></td>
                     <td  align="left" style="padding-left:5px">
                        
                    </td>
                     <td  align="left"> 
                    
                     </td>
                      <td  align="left"> 
                      
                     </td>
                      <td  align="left"> 
                      
                     </td>
                     <td  align="left"> 
                     
                     </td>
                </tr>
                <tr>
                    <td width="40" align="left">
                        <table width="40" >
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
                        <ext:TextField ID="txtShipper" runat="server" Cls="text" TabIndex="3"></ext:TextField> 
                    </td>
                    <td width="80" align="left">
                         <table width="80" >
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Date From
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="80" align="left">
                             <ext:DateField ID="txtDateFrom" runat="server" Cls="text" Format="dd/m/Y" Width="90"
                            TabIndex="4">
                        </ext:DateField>                    
                    </td>
                    <td width="60" align="left">
                        
                    </td>
                    <td width="80" align="left">
                                                
                    </td>
                    <td width="10" align="left"></td>
                    <td  align="left" style="padding-left:5px">
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
                     <ext:Button ID="btnMakeConsol" runat="server" Text="Make Consol" Width="80">
         <DirectEvents>
                <Click OnEvent="btnMakeConsol_Click">
                <ExtraParams>
                <ext:Parameter Name="RowID" Value="Ext.encode(#{gridList}.getRowsValues({selectedOnly : true}))" Mode="Raw" />
                </ExtraParams>
                </Click>
                </DirectEvents>
        </ext:Button>
                     </td>
                      <td  align="left"> 
                      <ext:Button ID="btnDirect" runat="server" Text="Coloader Out" Width="80">
        <DirectEvents>
        <Click OnEvent="btnDirect_Click">
        <ExtraParams>
        <ext:Parameter Name="RowID" Mode="Raw" Value="Ext.encode(#{gridList}.getRowsValues({selectedOnly : true}))"></ext:Parameter> 
        </ExtraParams>
        </Click>
        </DirectEvents>
        </ext:Button>
                     </td>
                      <td  align="left"> 
                      <ext:Button ID="btnSub" runat="server" Text="Sub Shipment" Width="80"  >
                <DirectEvents>
                <Click OnEvent="btnSub_Click">
                <ExtraParams>
                <ext:Parameter Name="RowID" Value="Ext.encode(#{gridList}.getRowsValues({selectedOnly : true}))" Mode="Raw" />
                </ExtraParams>
                </Click>
                </DirectEvents>
                </ext:Button>
                     </td>
                     <td  align="left"> 
                      <ext:Button ID="btnDirectMAWB" runat="server" Text="Direct MAWB" Width="80"  >
                <DirectEvents>
                <Click OnEvent="btnDirectMAWB_Click">
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
        <br />  
        <ext:GridPanel ID="gridList" runat="server"  Width="930px"   Height="368" 
            TrackMouseOver="true" StripeRows="true" ColumnLines="True" >
            <LoadMask ShowMask="true" Msg=" Loading..." />
            <Store>
                <ext:Store runat="server" ID="storeList"  OnRefreshData="storeList_OnRefreshData">
                    <Reader>
                        <ext:JsonReader IDProperty="RowID" >
                            <Fields>
                                <ext:RecordField Name="RowID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Seed" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="EstReceipt" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="ActReceipt" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="Shipper" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="BookNo" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Dest" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Hawb" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="GWT" Type="String" >
                                </ext:RecordField>
                                <ext:RecordField Name="VMT" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Cbm" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Ctns" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Pallets" Type="String">
                                </ext:RecordField>
                               <ext:RecordField Name="By" Type="string">
                                </ext:RecordField>
                                <ext:RecordField Name="Do" Type="string">
                                </ext:RecordField>
                                <ext:RecordField Name="SubFlag" Type="String">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel runat="server" ID="ColumnModel1">
                <Columns>
                    <ext:DateColumn Header="Est Receipt" DataIndex="EstReceipt" Width="78" Format="dd/MM/yyyy"></ext:DateColumn>
                    <ext:DateColumn Header="Act Receipt" DataIndex="ActReceipt" Width="78" Format="dd/MM/yyyy"></ext:DateColumn>
                    <ext:Column Header="Shipper" DataIndex="Shipper" Width="86">
                    </ext:Column>
                    <ext:Column Header="Book No." DataIndex="BookNo" Width="110">
                    </ext:Column>
                    <ext:Column Header="Dest." DataIndex="Dest" Width="45" Align="Center">
                    </ext:Column>
                    <ext:Column Header="HAWB No." DataIndex="Hawb" Width="120" Css="text-transform: uppercase;">
                    <Editor>
                    <ext:TextField ID="txtHawbUpdate" runat="server" StyleSpec="text-transform:uppercase;">
                    <Listeners>
                    <Focus Fn="changeValue"/>
                    
                    </Listeners>
                    </ext:TextField>
                    </Editor>
                    </ext:Column>                 
                    <ext:NumberColumn Header="G.WT" DataIndex="GWT" Width="53" Format="0.000" Align="Right"></ext:NumberColumn>
                    <ext:NumberColumn Header="V.WT" DataIndex="VMT" Width="53" Format="0.000" Align="Right"> </ext:NumberColumn>
                    <ext:NumberColumn Header="C.WT" DataIndex="Cbm" Width="53" Format="0.000" Align="Right"> </ext:NumberColumn>              
                    <ext:NumberColumn Header="Ctns" DataIndex="Ctns" Width="48" Format="0"  Align="Right"> </ext:NumberColumn>
                    <ext:NumberColumn Header="Pallets" DataIndex="Pallets" Width="62"  Format="0"  Align="Right"> </ext:NumberColumn>
                    <ext:Column Header="By" DataIndex="By" Width="45" Align="Center">
                    </ext:Column>
                    <ext:TemplateColumn Header="HAWB" Width="58">
                    <Template runat="server">
                    <Html>
                  <%--   
    <button type="button" id="ext-gen14" class=" x-btn-text" onclick={Do} ></button>--%>
   <span style="background-image:url(../../images/btn_hawb.jpg)"><a href="#" class="font_11px" onclick={Do}  style="padding-left:5px; padding-right:5px">HAWB</a></span>
                    </Html>
                    </Template>
                    </ext:TemplateColumn>
                </Columns>             
            </ColumnModel>          
            <SelectionModel>
                <ext:CheckboxSelectionModel runat="server" ID="RowSelectionModel1"  SingleSelect="false" CheckOnly="false">
                </ext:CheckboxSelectionModel>
            </SelectionModel>
            <Listeners>
            <AfterEdit Fn="afterEdit"/>
            </Listeners>
           <%--<Listeners>
                <RowClick Handler="var model=Ext.getCmp('gridList').getSelectionModel();if(model.isSelected(rowIndex)){model.deselectRow(rowIndex,true);} else{model.selectRow(rowIndex);}" />
            </Listeners>--%>
            <BottomBar>
                <ext:PagingToolbar   PageSize="100"  DisplayInfo="true"  ID="PagingToolbar1"  runat="server"></ext:PagingToolbar>
            </BottomBar>
        </ext:GridPanel>
        
    </div>
    </form>
</body>
</html>
