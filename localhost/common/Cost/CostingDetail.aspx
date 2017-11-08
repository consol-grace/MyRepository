<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CostingDetail.aspx.cs" Inherits="common_Cost_CostingDetail" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
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
    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>
    <script type="text/javascript">
//        $(document).ready(function() {
//            $("#cmbShipperCode").focus();
//        });
        function DeleteEmpty(grid) {
            if (grid.store.getTotalCount() > 0 && grid.id == "gridList") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var lot = data.cxd_LotNo;
                    var master = data.cxd_Master;
                    var house = data.cxd_House;
                    
                    if (lot==""&&master==""&&house=="") {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
            
        }
        function ReturnNull() {

            var companycode = "";
            var date = "";
            var invo = "";
            var amount = "";

            companycode = $("#cmbShipperCode").val();
            date = $("#txtDate").val();
            invo = $("#txtInv").val();
            amount = $("#txtAmount").val();
            

            if (companycode == "" || companycode == undefined) {
                $("#cmbShipperCode").focus();
                NullMsg("Company");
                return false;
            }
            else if (date == "" || date == undefined) {
                $("#txtDate").focus();
                NullMsg("Date");
                return false;
            }
            else if (invo == "" || invo == undefined) {
                $("#txtInv").focus();
                NullMsg("Inv. No");
                return false;
            }
            else if (amount == "" || amount == undefined) {
                $("#txtAmount").focus();
                NullMsg("Amount");
                return false;
            }
            else if (gridList.store.getTotalCount()==0) {
                NullMsg("Detail List");
                return false;
            }
            else {
                return true;
            }
        }

        //验证错误信息
        function NullMsg(msg) {
            $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't be empty!");
        }

        var afterEdit = function(e) {
            var name = e.field;
            if (name == "cxd_LotNo") {
                CompanyX.GetData(e.row, 0, e.value);
            }
            else if (name == "cxd_Master") {
              CompanyX.GetData(e.row, 1, e.value);
            } else {
              CompanyX.GetData(e.row, 2, e.value);
            }
        }
        
        function getSelectPos(obj) {
            var esrc = document.getElementById(obj);
            if (esrc == null) {
                esrc = event.srcElement;
            }
            var rtextRange = esrc.createTextRange();
            rtextRange.moveStart('character', esrc.value.length);
            rtextRange.collapse(true);
            rtextRange.select();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
     <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <ext:Hidden ID="hidID" runat="server" Text="0"></ext:Hidden>
    <ext:Hidden ID="hidHeadSeed" runat="server" Text="0"></ext:Hidden>
    <ext:Store runat="server" ID="StoreGetData">
        <Reader>
            <ext:JsonReader  IDProperty="Seed">
                <Fields>
                    <ext:RecordField Name="Seed">
                    </ext:RecordField>
                    <ext:RecordField Name="LotNo">
                    </ext:RecordField>
                    <ext:RecordField Name="Master">
                    </ext:RecordField>
                    <ext:RecordField Name="House">
                    </ext:RecordField>
                     <ext:RecordField Name="GWT">
                    </ext:RecordField>
                     <ext:RecordField Name="VWT">
                    </ext:RecordField>
                     <ext:RecordField Name="Piece">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <div>
      <table width="560" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="5" valign="top" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                           <table cellpadding="0" cellspacing="0" border="0" width="100%"><tr>
                           <td>Costing Detail</td>
                        <td align="right" class="nav_menu_5" style="padding-bottom:2px; padding-right:2px">
                                                     
                                                    </td>         
                           </tr></table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="10px" colspan="5">
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <table border="0" cellspacing="4" cellpadding="0">
                        <tr>
                            <td width="63" height="17" style="padding-left: 2px">
                                Company
                            </td>
                            <td colspan="3">
                               <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="1" clsClass="x-form-text x-form-field text"
                            Query="option=CompanyList" Width="73" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" isDiplay="true" />
                            </td>
                            <td style="padding-left:5px">
                               
                            </td>
                            <td colspan="2">
                               
                            </td>
                        </tr>
                        <tr>
                            <td width="63" style="padding-left: 2px">
                                Date
                            </td>
                            <td width="100">
                                <ext:DateField ID="txtDate" runat="server" Width="100" Cls="text_100px"  Format="dd/m/Y" TabIndex="2">
                                </ext:DateField>
                            </td>
                            <td width="50" style="padding-left:5px">
                                Inv. No
                            </td>
                            <td width="100">
                               <ext:TextField ID="txtInv" runat="server" Cls="text" TabIndex="3" Width="100">
                            </ext:TextField>  
                            </td>
                            <td width="47">
                                Amount
                            </td>
                            <td width="100">
                             <ext:NumberField ID="txtAmount" runat="server" Cls="text" TabIndex="4" Width="100" StyleSpec="text-align:right">
                              <Listeners>
                              <Blur Handler="DeleteEmpty(#{gridList});InsertRow(#{gridList},true,0);txtLot.focus(true);" />
                             </Listeners>
                           </ext:NumberField>
                            </td>
                            <td width="100">
                                <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Text="Save" Width="65"  AutoFocus="true" >
                                   <Listeners>
                                          <Click Handler="DeleteEmpty(#{gridList});return (ValidataText()&&ReturnNull());" />
                                   </Listeners>
                                  <DirectEvents>
                                      <Click OnEvent="btnSave_Click">
                                           <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                   <ext:Parameter Name="gridList" Value="Ext.encode(#{gridList}.getRowsValues())" Mode="Raw">
                                                    </ext:Parameter>
                                             </ExtraParams>
                                      </Click>
                                 </DirectEvents>  
                                </ext:Button>
                               <%--  <ext:KeyNav ID="KeyNav1" runat="server" Target="#{form1}">
                                        <enter handler="btnSave.fireEvent('click')" />
                                    </ext:KeyNav>  --%>
                            </td>
                           
                        </tr>
                    </table>
                </td>
            </tr>
           
            <tr>
                <td height="10" colspan="5">
                </td>
            </tr>
            <tr>
                <td colspan="5" id="GridView">
                    <ext:GridPanel ID="gridList" runat="server" Height="279" TrackMouseOver="true"
                        StripeRows="true" ClicksToEdit="1">
                        <LoadMask ShowMask="true" Msg=" Loading..." />
                        <Store>
                            <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                                AutoLoad="true">
                                <AutoLoadParams>
                                    <ext:Parameter Name="start" Value="={0}" />
                                    <ext:Parameter Name="limit" Value="={100}" />
                                </AutoLoadParams>
                                <Reader>
                                    <ext:JsonReader IDProperty="cxd_ROWID">
                                        <Fields>
                                            <ext:RecordField Name="cxd_ROWID" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxd_LotNo" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxd_Master" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxd_House" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="GWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="VWT" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Piece" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxd_Seed" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="cxd_Sys" Type="String">
                                            </ext:RecordField> 
                                             <ext:RecordField Name="cxd_LotSeed" Type="String">
                                            </ext:RecordField> 
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ColumnModel1">
                            <Columns>
                                <ext:Column Header="Lot" DataIndex="cxd_LotNo" Width="100" Css="text-transform: uppercase;">
                                <Editor>
                                <ext:TextField ID="txtLot" runat="server" StyleSpec="text-transform:uppercase;">
                                <Listeners>
                                <Focus Handler="getSelectPos(this.id);" />
                                </Listeners>
                                </ext:TextField>
                                </Editor>
                                </ext:Column>
                                <ext:Column Header="Master" DataIndex="cxd_Master" Width="130" Align="Center" Css="text-transform: uppercase;">
                                 <Editor>
                                <ext:TextField ID="txtMaster" runat="server" StyleSpec="text-transform:uppercase;">
                                 <Listeners>
                                <Focus Handler="getSelectPos(this.id);" />
                                </Listeners>
                                </ext:TextField>
                                </Editor>
                                </ext:Column>
                                <ext:Column Header="House" DataIndex="cxd_House" Width="130" Align="Center" Css="text-transform: uppercase;">
                                 <Editor>
                                <ext:TextField ID="txtHouse" runat="server" StyleSpec="text-transform:uppercase;">
                                 <Listeners>
                                <Focus Handler="getSelectPos(this.id);" />
                                </Listeners>
                                </ext:TextField>
                                </Editor>
                                </ext:Column>
                                 <ext:NumberColumn Header="GWT" DataIndex="GWT" Width="80" Align="Right" Format="0.000">
                                  </ext:NumberColumn>
                                   <ext:NumberColumn Header="VWT/CBM" DataIndex="VWT" Width="80" Align="Right"  Format="0.000">
                                  </ext:NumberColumn>
                                   <ext:NumberColumn Header="PCS" DataIndex="Piece" Width="60" Align="Right"  Format="0">
                                  </ext:NumberColumn>
                                  
                            </Columns>
                        </ColumnModel>
                         <KeyMap>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="INSERT" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteEmpty(#{gridList});InsertRow(#{gridList},false,0);" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding Ctrl="true">
                                                                            <Keys>
                                                                                <ext:Key Code="DELETE" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteRow(#{gridList})" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="TAB" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="DeleteEmpty(#{gridList});InsertRow(#{gridList},true,0);" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                        <ext:KeyBinding>
                                                                            <Keys>
                                                                                <ext:Key Code="ENTER" />
                                                                            </Keys>
                                                                            <Listeners>
                                                                                <Event Handler="EditRow(#{gridList},0)" />
                                                                            </Listeners>
                                                                        </ext:KeyBinding>
                                                                    </KeyMap>
                                                                    <Listeners>
                                                                        <Click Handler="NewRow(#{gridList},0,0)" />
                                                                        <AfterEdit Fn="afterEdit"/>
                                                                    </Listeners>
                        <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="RowSelectionModel1">
                             <Listeners>
                                  <RowSelect Handler="getRowIndex(rowIndex);" />
                             </Listeners>
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar StoreID="storeList" PageSize="100" runat="server" ID="PagingToolbar1"
                                AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                EmptyMsg="No Data" Hidden="true">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </td>
            </tr>
    
        </table>
    </div>
    </form>
</body>
</html>
