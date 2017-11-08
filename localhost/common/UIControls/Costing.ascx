<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Costing.ascx.cs" Inherits="common_UIControls_Costing" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="/common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>  
<script src="/common/UIControls/Costing.js" type="text/javascript"></script>
<ext:Hidden runat="server" ID="hidCostType">
</ext:Hidden>
<ext:Hidden runat="server" ID="hidCostSeed">
</ext:Hidden>
<ext:Hidden runat="server" ID="hidCostSys">
</ext:Hidden>
<ext:Hidden runat="server" ID="hidFCur">
</ext:Hidden>
<ext:Hidden runat="server" ID="hidLCur">
</ext:Hidden>
<ext:Hidden runat="server" ID="hidLockCostSeed">
</ext:Hidden>
 <%--<ext:Button ID="btnSaveCost" runat="server"  Text="Save" Width="70px" Hidden="true">
                                                                <DirectEvents>
                                                                    <Click OnEvent="btnSaveCost_Click">
                                                                        <ExtraParams>
                                                                            <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                            </ext:Parameter>
                                                                        </ExtraParams>
                                                                    </Click>
                                                                </DirectEvents>
                                                            </ext:Button>--%>
 <ext:Button ID="btnCancleCost" runat="server"  Text="Cancle" Width="70px" Hidden="true">
    <DirectEvents>
        <Click OnEvent="btnCancleCost_Click">
        </Click>
    </DirectEvents>
</ext:Button>
<table cellpadding="0" cellspacing="0" border="0"><tr>
 <td>
     <table cellpadding="0" cellspacing="0" border="0"> 
                <tr><td valign="top">
                <table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                        style="border: 1px solid #8db2e3">
                        <tbody>
                            <tr>
                                <td width="100%" align="left" valign="top" bgcolor="#FFFFFF" background="../../../images/bg_line_3.jpg">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                                        <tbody>
                                            <tr>
                                                <td width="48%" align="left" class="font_11bold_1542af" style="padding-left: 5px;
                                                    line-height: 26px; height:26px">
                                                    <ext:Label ID="labCosting" runat="server" Text="Costing"></ext:Label>&nbsp;&nbsp;<ext:Label ID="labLockCost" runat="server" Text="(Lock)"  StyleSpec="color:red;font-weight:bold;" Hidden="true"></ext:Label>
                                                </td>
                                                <td align="right" style="padding-right:2px;" class="nav_menu_6"><a href="javascript:void(0)"  onclick="OpenCosting($('#hidSeed').val())" style="display:block; text-align:center">Combine Cost</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td></tr>
                <tr>
                <td id="GridView_3" valign="top">
                 <table id="costTotalAll" style="margin-top:0px;border-left: 1px solid #8db2e3; border-right: 1px solid #8db2e3;border-bottom: 1px solid #8db2e3" cellpadding="0" cellspacing="0" border="0">
                 <tr>
                 <td valign="top">
                    <div id="costTotal">
                    </div>
                </td>
                </tr>
                </table>  
                    <ext:GridPanel runat="server" ID="gridCost" TrackMouseOver="true" 
                        Title="Costing"  Hidden="true">
                        <Store>
                            <ext:Store runat="server" ID="StoreCosting">
                                <Reader>
                                    <ext:JsonReader IDProperty="RowID">
                                        <Fields>
                                            <ext:RecordField Name="RowID" Type="Int">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PPD" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CompanyCode" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CompanyName" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Item" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Description" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Total" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CalcKind" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Qty" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Unit" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Currency" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="EX" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Rate" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Amount" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="curStatus" Type="String">
                                            </ext:RecordField>
                                             <ext:RecordField Name="Remark" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="si_BillCurrency" Type="String">
                                             </ext:RecordField>
                                              <ext:RecordField Name="Min" Type="String">
                                             </ext:RecordField>
                                              <ext:RecordField Name="Percent" Type="String">
                                             </ext:RecordField>
                                              <ext:RecordField Name="Show" Type="String">
                                             </ext:RecordField>
                                             <ext:RecordField Name="FTotal" Type="String">
                                             </ext:RecordField>
                                             <ext:RecordField Name="ATotal" Type="String">
                                             </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                               
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModel3">
                            <Columns>
                                <ext:Column Header="Status" DataIndex="curStatus" Width="50" Align="Center">
                                </ext:Column>
                                <ext:Column Header="A/L" DataIndex="PPD" Width="50" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Company" DataIndex="CompanyCode" Width="105">
                                </ext:Column>
                                <ext:NumberColumn Header="Total" DataIndex="Total" Width="70" Format="0.00" Align="Right">
                                </ext:NumberColumn>
                                <ext:Column Header="CUR" DataIndex="Currency" Width="38" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right" Format="0.00">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" Width="10">
                                </ext:NumberColumn>
                            </Columns>
                        </ColumnModel>
                         <SelectionModel>
                            <ext:RowSelectionModel runat="server" ID="ctl1606">  
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        
                    </ext:GridPanel>
                </td></tr></table>
  </td>
   <td valign="top" align="left" style="padding-left: 6px; padding-top:0px;" id="td_assCosting">
        <div  id="addCosting">
                        <table id="addCostAll" cellpadding="0" cellspacing="0" width="303"  >
                            <tr>
                                <td   style="padding-left: 5px; height: 24px" class="font_11bold_1542af table_nav2" >
                                    <ext:Label ID="labaddcosting" runat="server" Text="Add Costing"></ext:Label>
                                </td>
                            </tr>
                            <tr>
                            <td>
                            <div id="LockCostRight" style="position:relative;">
                            <table cellpadding="0" cellspacing="0" border="0" id="tb_addCost">
                            <tr id="addCost1" style="display:block;">
                             <td ><table cellpadding="0" cellspacing="0" border="0" width="72px" ><tr>   <td class="tb_01" style="vertical-align: top; padding-top: 12px; padding-left: 6px">
                                    Agent/Local
                                </td></tr></table></td>
                                <td colspan="5" style="padding-top: 12px">
                                    <ext:ComboBox runat="server" ID="cos_PPD" StoreID="StoreAgentLocal" DisplayField="text" ValueField="value" 
                                        Mode="Local" ForceSelection="true" TriggerAction="All" Cls="select_160px" Width="90"   StyleSpec="text-transform:capitalize">
                                     <Listeners>
                                     <Select Handler="CurDefault();if($('#ucCost_hidCostSys').val() == 'A'){GetItemData('ucCost_cos_PPD','cos_ItemA','ucCost_cos_Calc','ucCost_cos_Qty','ucCost_cos_Unit','ucCost_cos_Currency','ucCost_cos_Rate','ucCost_cos_Amount','ucCost_cos_EX');}else{GetItemData('ucCost_cos_PPD','cos_Item','ucCost_cos_Calc','ucCost_cos_Qty','ucCost_cos_Unit','ucCost_cos_Currency','ucCost_cos_Rate','ucCost_cos_Amount','ucCost_cos_EX');}" />
                                     </Listeners>
                                    </ext:ComboBox>
                                </td>
                            </tr>
                            <tr  id="addCost2" style="display:block;">
                                <td id="td_Company" class="tb_01" style="padding-top: 7px; padding-left: 6px" valign="top">
                                    Company
                                </td>
                                <td colspan="5" style="padding-top: 6px">
                                  <table cellpadding="0" cellspacing="0" border="0" width="210px" id="tb_Company"><tr><td>
                                    
                                    <uc1:AutoComplete runat="server" ID="cos_Company" clsClass="x-form-text x-form-field text_82px" 
                                         isText="true" isAlign="false" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                         winWidth="800" winHeight="800" Query="option=CompanyList"  />
                                  </td></tr></table>
                                </td>
                            </tr>
                            <tr  id="addCost3" style="display:block;">
                                <td id="td_Item" class="tb_01" style="vertical-align: top; padding-left: 7px; padding-top: 3px">
                                    Item
                                </td>
                                <td colspan="5">
                                    <div id="cos_Item_O" style="display:block;">
                                    <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="cos_Item" isText="true" 
                                        clsClass="select_160px" Width="69" winTitle="Item"  winUrl="/BasicData/Item/list.aspx?sys=O"
                                        winWidth="965" winHeight="480"  Handler="GetItemData('ucCost_cos_PPD','cos_Item','ucCost_cos_Calc','ucCost_cos_Qty','ucCost_cos_Unit','ucCost_cos_Currency','ucCost_cos_Rate','ucCost_cos_Amount','ucCost_cos_EX')"/>
                                    </div>
                                    <div id="cos_Item_A" style="display:none;">
                                       <uc1:UserComboBox runat="server" StoreID="StoreGetItem" ID="cos_ItemA" isText="true" 
                                        clsClass="select_160px" Width="69" winTitle="Item"  winUrl="/BasicData/Item/list.aspx?sys=A"
                                        winWidth="965" winHeight="480"  Handler="GetItemData('ucCost_cos_PPD','cos_ItemA','ucCost_cos_Calc','ucCost_cos_Qty','ucCost_cos_Unit','ucCost_cos_Currency','ucCost_cos_Rate','ucCost_cos_Amount','ucCost_cos_EX')"/>
                                    </div>
                                </td>
                            </tr>
                            <tr  id="addCost4" style="display:block;">
                                <td id="td_Calc" class="tb_01" style="padding-left: 7px">
                                    Calc
                                </td>
                                <td colspan="5" >
                                    <table cellpadding="0" cellspacing="0" id="tb_Calc">
                                        <tr>
                                            <td>
                                                <ext:ComboBox runat="server" ID="cos_Calc" Cls="select_160px" StoreID="StoreKind" 
                                                    DisplayField="value" ValueField="value" Width="61"   ForceSelection="true" TriggerAction="All" Mode="Local">
                                                    <Listeners>
                                                        <Select Handler="SelectCalc('ucCost_cos_Calc','ucCost_cos_Qty','ucCost_cos_Unit')" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </td>
                                            
                                            <td><table width="30px"><tr><td align="center">Unit</td></tr></table></td>
                                            <td>
                                               
                                                <ext:ComboBox ID="cos_Unit" runat="server" DisplayField="value" ValueField="value"
                                                    ListWidth="250" ItemSelector="tr.list-item" StoreID="StoreUnit" Mode="Local"
                                                    ForceSelection="true" TriggerAction="All" Width="56" Cls="select_160px" >
                                                </ext:ComboBox>
                                            </td>
                                            <td>
                                               <table width="32px" id="td_Qty"><tr><td style="text-align:center">Qty</td></tr></table>
                                            </td>
                                            <td id="td_cosQty">
                                                <ext:NumberField ID="cos_Qty" runat="server" Width="40"  Cls="select_160px" StyleSpec="text-align:right"  DecimalPrecision="3">
                                                </ext:NumberField>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr  id="addCost5" style="display:block;">
                                <td id="td_Bill" class="tb_01" style="padding-left: 7px; padding-top:5px">
                                    Bill
                                </td>
                                <td colspan="5" style="padding-top:5px">
                                    <table cellpadding="0" cellspacing="0" id="tb_Bill">
                                        <tr>
                                       <td><ext:ComboBox ID="billcurrency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                                Width="61" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                                TriggerAction="All" >
                                                                <Listeners>
                                                                <Select Handler="SetCurRate('ucCost_cos_Currency','ucCost_cos_EX');" />
                                                                </Listeners>
                                                            </ext:ComboBox>
                                                        </td>
                                            <td id="td_Currency"><table width="32px"><tr><td align="center">Currency</td></tr></table></td>
                                            <td>
                                                <ext:ComboBox ID="cos_Currency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                                    Width="61"  DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                                    TriggerAction="All" >
                                                    <Listeners>
                                                         <Select Handler="SetCurRate('ucCost_cos_Currency','ucCost_cos_EX');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </td>
                                            <td id="td_EX" style="padding-left:5px">
                                                <ext:NumberField ID="cos_EX" runat="server" Width="40px" DecimalPrecision="4"  StyleSpec="text-align:right" 
                                                    Cls="select_160px">
                                                </ext:NumberField>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr  id="addCost6" style="display:block;">
                                <td id="addCost61"  style="padding-left: 7px; padding-top:5px;"><%--display:block;--%>
                                    Min
                                </td>
                                <td id="addCost62"  style="padding-top: 5px;"><%--display:block;--%>
                                   <ext:NumberField ID="cos_Min" runat="server" Width="60" Cls="text_80px"
                                            StyleSpec="text-align:right">
                                            <Listeners>
                                                <Blur Handler="if(this.getValue()!=''){#{cos_amount}.setValue()}" />
                                            </Listeners>
                                        </ext:NumberField> 
                                </td>
                                <td colspan="4" style="padding-top:5px">
                                 <table cellpadding="0" cellspacing="0" id="tb_Min"><tr>
                                <td>
                                    <table width="33px" id="tb_Rate"><tr><td align="center">Rate</td></tr></table>
                                </td>
                                <td >
                                    <ext:NumberField ID="cos_Rate" runat="server" Width="61"  Cls="select_65" StyleSpec="text-align:right" DecimalPrecision="3">
                                        <Listeners>
                                            <Blur Handler="if(this.getValue()!=''){#{cos_Amount}.setValue()}" />
                                        </Listeners>
                                    </ext:NumberField>
                                </td>
                                <td ><table width="53px" id="tb_Amount"><tr><td align="center">Amount</td></tr></table>
                                </td>
                                <td id="td_cosAmount">
                                    <ext:NumberField ID="cos_Amount" runat="server" Width="90"  Cls="select_65" StyleSpec="text-align:right" DecimalPrecision="2">
                                        <Listeners>
                                            <Blur Handler="if(this.getValue()!=''){#{cos_Rate}.setValue();#{cos_Min}.setValue();}" />
                                        </Listeners>
                                    </ext:NumberField>
                                </td>
                                </tr></table>
                                </td>
                            </tr>
                            <tr  id="addCost7" style="display:none;">
                             <td style="padding-left: 7px; padding-top:6px;display:none;" valign="top">
                                                            Percent
                                                        </td>
                                                        <td style="vertical-align: top; padding-top: 5px;display:none;">
                                                           <ext:NumberField ID="cos_Percent" runat="server" Cls="text" MaxLength="4" DecimalPrecision="1"
                                                Width="60" Text="100"  StyleSpec="background-image:url(/images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                            </ext:NumberField>
                                                        </td>
                                                        <td style="padding-left: 7px; padding-top: 6px" valign="top" id="td_Show">
                                                            Show
                                                        </td>
                                                        <td colspan="3" style="vertical-align: top; padding-top: 5px">
                                                            <ext:ComboBox ID="cos_Show" runat="server"  DisplayField="text"
                                            Cls="select_65" Text="DN" ValueField="value" Mode="Local" ForceSelection="true"
                                            TriggerAction="All" Width="60"></ext:ComboBox>
                                                        </td>
                                                    </tr>
                            <tr  id="addCost8" style="display:block;">
                                                        <td id="td_Remark" style="padding-left: 7px; padding-top: 6px" valign="top">
                                                            Remark
                                                        </td>
                                                        <td colspan="5" style="vertical-align: top; padding-top: 5px" >
                                                            <ext:TextField ID="cos_Remark" runat="server" Cls="select_160px" Width="219">
                                                            </ext:TextField>
                                                        </td>
                                                    </tr>
                            <tr>
                                <td colspan="6" style="padding-right: 9px; padding-top: 10px" align="right">
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td>
                                            <table cellpadding="0" cellspacing="0" border="0"><tr>
                                            <td class="btn_L"></td>
                                            <td><input id="btnCostInsert" onclick="CostInsertRecord()"  type="button" style="cursor: pointer" tabindex="44" class="btn_text btn_C" value="Save & Next" /></td>
                                            <td class="btn_R"></td>
                                            </tr></table>
                                            </td>
                                            <td style="padding-left:2px">
                                            <table cellpadding="0" cellspacing="0" border="0"><tr>
                                            <td class="btn_L"></td>
                                            <td><input id="btnCostReset" onclick="CostResetRecord()"  type="button" style="cursor: pointer" tabindex="44" class="btn_text btn_C" value="Reset" /></td>
                                            <td class="btn_R"></td>
                                            </tr></table>
                                            </td>
                                            <td style="padding-left:3px">
                                            <table cellpadding="0" cellspacing="0" border="0"><tr>
                                            <td class="btn_L"></td>
                                            <td><input id="btnCostDelete" onclick="CostDeleteRecord()"  type="button" style="cursor: pointer" tabindex="44" class="btn_text btn_C" value="Delete" />  </td>
                                            <td class="btn_R"></td>
                                            </tr></table>
                                                 
                                            </td>
                                        </tr>
                                    </table>
                                    
                                </td>
                            </tr>
                            </table>
                            <div id="LockCostMask" style="display:none;position: absolute; filter: alpha(opacity=50); width: 100%;height: 100%; background: #fff; top: 0px; left: 0px; opacity: 0.5;"/>
                            </div>
                            </td>
                            </tr>
                        </table>
                        
          </div>
    </td>
</tr></table>
  