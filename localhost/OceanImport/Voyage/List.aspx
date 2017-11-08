<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanImport_Voyage_List" %>

<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Voyage</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../AjaxServer/gridVoyage.js" type="text/javascript"></script>

</head>
<body style="padding: 0 10px">
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" />
    <ext:Hidden ID="txtVoyageID" runat="server">
    </ext:Hidden>
    <ext:Store runat="server" ID="storeLocation">
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
    <ext:Store runat="server" ID="storeVessel">
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
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td width="345" valign="top" style="padding-top: 8px">
                <table width="300" border="0" cellpadding="0" cellspacing="3">
                    <tr>
                        <td colspan="2">
                            <table width="40" border="0" cellspacing="0" cellpadding="0" class="font_11bold">
                                <tr>
                                    <td>
                                        Vessel
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="172">
                            <table width="100" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <ext:ComboBox ID="cmbVessel" runat="server" Cls="select_160px" Width="160" StoreID="storeVessel"
                                            TabIndex="1" DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true"
                                            TriggerAction="All">
                                            <DirectEvents>
                                                <Select OnEvent="cmbVessel_Select">
                                                </Select>
                                            </DirectEvents>
                                        </ext:ComboBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="84" align="left">
                            <ext:Button ID="btnNew" runat="server" Cls="Submit" Text=" New " Width="60" NavigateUrl="../vessel/vessel.aspx">
                            </ext:Button>
                        </td>
                    </tr>
                    <tr>
                        <td width="40">
                            <table width="40" border="0" cellspacing="0" cellpadding="0" class="font_11bold">
                                <tr>
                                    <td>
                                        Carrier
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="6" class="font_11bold">
                        </td>
                        <td colspan="2">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="font_11px_gray" height="25px" align="left">
                                                    <ext:Label ID="labCarrierCode" runat="server">
                                                    </ext:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table width="160" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="font_11px_gray" height="25" align="left">
                                                    <ext:Label ID="labCarrierText" runat="server">
                                                    </ext:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="255" rowspan="3" valign="top" id="SHOW" style="padding-left: 5px; padding-top: 8px">
                <table width="356" border="0" cellpadding="0" cellspacing="3">
                    <tr>
                        <td width="70" class="font_11bold" style="padding-left: 1px">
                            Voyage
                        </td>
                        <td colspan="2">
                            <ext:TextField ID="txtVoyage" runat="server" Cls="text_100px" Width="100" TabIndex="2">
                            </ext:TextField>
                        </td>
                        <td width="66" align="left">
                            <ext:Button ID="btnAddNew" runat="server" Cls="Submit_65px" Text="New" Width="65">
                                <DirectEvents>
                                    <Click OnEvent="btnAddNew_Click">
                                        <EventMask ShowMask="true" Msg=" Loading ...  " />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td width="100" align="left">
                            <ext:Button ID="btnCopy" runat="server" Cls="Submit_65px" Text="Copy New" Width="65">
                                <DirectEvents>
                                    <Click OnEvent="btnCopy_Click">
                                        <EventMask ShowMask="true" Msg=" Loading ... " />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" height="7">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td width="61" align="right">
                            <ext:Checkbox ID="chcActive" runat="server" Checked="true" Width="30" TabIndex="3">
                            </ext:Checkbox>
                        </td>
                        <td width="42" align="left">
                            <span class="font_11bold" style="padding-left: 3px">Active</span>
                        </td>
                        <td>
                            <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Text="Cancel" Width="65">
                                <DirectEvents>
                                    <Click OnEvent="btnCancel_Click">
                                        <EventMask ShowMask="true" Msg=" Loading ... " />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td>
                            <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Text="Save" Width="67">
                                <DirectEvents>
                                    <Click OnEvent="btnSave_Click">
                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                        <ExtraParams>
                                            <ext:Parameter Name="gridData" Value="Ext.encode(#{gridVoyageRoute}.getRowsValues())"
                                                Mode="Raw">
                                            </ext:Parameter>
                                        </ExtraParams>
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" height="5">
                        </td>
                    </tr>
                </table>
                <table width="360" border="0" cellpadding="0" cellspacing="3">
                    <tr>
                        <td width="69" class="font_11bold" style="padding-left: 1px">
                            POL
                        </td>
                        <td width="107">
                            <table width="100" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <uc1:UserComboBox runat="server" ID="cmbPOL" ListWidth="180" clsClass="select_160px"
                                            TabIndex="5" Query="option=LocationList&sys=O" StoreID="storeLocation" Width="80"
                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                            winHeight="620" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="font_11bold">
                            POD
                        </td>
                        <td>
                            <table width="100" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <uc1:UserComboBox runat="server" ID="cmbPOD" ListWidth="180" clsClass="select_160px"
                                            TabIndex="6" Query="option=LocationList&sys=O" StoreID="storeLocation" Width="80"
                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                            winHeight="620" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="font_11bold">
                            Onboard
                        </td>
                        <td colspan="3">
                            <ext:DateField ID="txtOnboard" runat="server" Width="100" Cls="text_100px" TabIndex="6"
                                Format="dd/m/Y">
                                <Listeners>
                                    <Change Handler="txtETD.setValue(this.getValue());" />
                                </Listeners>
                            </ext:DateField>
                        </td>
                    </tr>
                    <tr>
                        <td class="font_11bold" style="padding-left: 1px">
                            ETD
                        </td>
                        <td>
                            <ext:DateField ID="txtETD" runat="server" Width="100" Cls="text_100px" TabIndex="7"
                                Format="dd/m/Y">
                            </ext:DateField>
                        </td>
                        <td width="62" class="font_11bold">
                            ETA
                        </td>
                        <td width="107">
                            <ext:DateField ID="txtETA" runat="server" Width="100" Cls="text_100px" TabIndex="8"
                                Format="dd/m/Y">
                            </ext:DateField>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="font_11bold" style="padding-left: 1px">CFS Closing</span>
                        </td>
                        <td>
                            <ext:DateField ID="txtCFS" runat="server" Width="100" Cls="text_100px" TabIndex="10"
                                Format="dd/m/Y">
                            </ext:DateField>
                        </td>
                        <td>
                            CY Closing
                        </td>
                        <td>
                            <ext:DateField ID="txtCY" runat="server" Width="100" Cls="text_100px" TabIndex="11"
                                Format="dd/m/Y">
                            </ext:DateField>
                        </td>
                    </tr>
                </table>
                <table width="350" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="5">
                        </td>
                    </tr>
                    <tr>
                        <td id="GridView_2">
                            <ext:GridPanel ID="gridVoyageRoute" runat="server" TrackMouseOver="true" Width="354"
                                Height="130" ClicksToEdit="1">
                                <Store>
                                    <ext:Store runat="server" ID="storeVoyageRoute">
                                        <Reader>
                                            <ext:JsonReader>
                                                <Fields>
                                                    <ext:RecordField Name="POL" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="POD" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="ETD" Type="Date">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="ETA" Type="Date">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="Tovoyage" Type="String">
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <ColumnModel ID="ColumnModel1">
                                    <Columns>
                                        <ext:RowNumbererColumn Header="No." Width="30">
                                        </ext:RowNumbererColumn>
                                        <ext:Column Header="POL" DataIndex="POL" Width="80" Align="Center">
                                            <Editor>
                                                <ext:ComboBox ID="combPOL" runat="server" Cls="select" DisplayField="value" TabIndex="6"
                                                    ForceSelection="true" Mode="Local" StoreID="StoreLocation" TriggerAction="All"
                                                    ValueField="value" ListWidth="250" ItemSelector="tr.list-item" Width="80">
                                                    <Template ID="Template2" runat="server">
                                                        <Html>
                                                        <tpl for=".">  
						                                            <tpl if="[xindex] == 1">						                                              
							                                            <table class="cbStates-list">
								                                            <tr>
									                                            <th>Code</th>
									                                            <th>Name</th>
								                                            </tr>
						                                            </tpl>
						                                            <tr class="list-item">
							                                            <td style="padding:3px 0px; width:100px">{value}</td>
							                                            <td style="padding:3px 0px; width:290px">{text}</td>
						                                            </tr>
						                                            <tpl if="[xcount-xindex]==0">
                </table>
</tpl></tpl>
</html>
</Template> </ext:ComboBox> </Editor> </ext:Column>
<ext:Column Header="POD" DataIndex="POD" Width="80" Align="Center">
    <editor>
                                                 <ext:ComboBox ID="combPOD" runat="server" Cls="select" DisplayField="value" TabIndex="6"
                                                ForceSelection="true" Mode="Local" StoreID="StoreLocation" TriggerAction="All" 
                                                 ValueField="value" ListWidth="250" ItemSelector="tr.list-item" Width="80">
                                                <Template ID="compdds" runat="server">
                                                    <Html>
                                                    <tpl for=".">  
						                                            <tpl if="[xindex] == 1">						                                              
							                                            <table class="cbStates-list">
								                                            <tr>
									                                            <th>Code</th>
									                                            <th>Name</th>
								                                            </tr>
						                                            </tpl>
						                                            <tr class="list-item">
							                                            <td style="padding:3px 0px; width:100px">{value}</td>
							                                            <td style="padding:3px 0px; width:290px">{text}</td>
						                                            </tr>
						                                            <tpl if="[xcount-xindex]==0">
                                </table>
</tpl></tpl>
</html>
</Template> </ext:ComboBox>
                                            </editor>
</ext:Column>
<ext:Column Header="ETD" DataIndex="ETD" Width="80" Align="Center">
    <renderer fn="Ext.util.Format.dateRenderer('d/m/Y')" />
    <editor>
                                                <ext:DateField runat="server" ID="ctl1403"  Format="d/m/Y">
                                                </ext:DateField>
                                            </editor>
</ext:Column>
<ext:Column Header="ETA" DataIndex="ETA" Width="80" Align="Center">
    <renderer fn="Ext.util.Format.dateRenderer('d/m/Y')" />
    <editor>
                                                <ext:DateField ID="DateField1" runat="server" Format="d/m/Y">
                                                </ext:DateField>
                                            </editor>
</ext:Column>
<ext:Column DataIndex="Tovoyage" Hidden="true">
</ext:Column>
</Columns> </ColumnModel>
<keymap>
                                    <ext:KeyBinding>
                                        <Keys>
                                            <ext:Key Code="INSERT" />
                                        </Keys>
                                        <Listeners>
                                            <Event Handler="AutoDeleteRow(#{gridVoyageRoute});InsertRow(#{gridVoyageRoute},true,1)" />
                                        </Listeners>
                                    </ext:KeyBinding>
                                    <ext:KeyBinding Ctrl="true">
                                        <Keys>
                                            <ext:Key Code="DELETE" />
                                        </Keys>
                                        <Listeners>
                                            <Event Handler="DeleteRow(#{gridVoyageRoute})" />
                                        </Listeners>
                                    </ext:KeyBinding>
                                    <ext:KeyBinding>
                                            <Keys><ext:Key  Code="TAB"/></Keys>
                                            <Listeners><Event  Handler="AutoDeleteRow(#{gridVoyageRoute});InsertRow(#{gridVoyageRoute},true,1)"/></Listeners>
                                    </ext:KeyBinding>
                                        <ext:KeyBinding>
                                            <Keys><ext:Key  Code="ENTER"/></Keys>
                                            <Listeners><Event  Handler="EditRow(#{gridVoyageRoute},1)"/></Listeners>
                                    </ext:KeyBinding>
                                </keymap>
<selectionmodel><ext:RowSelectionModel runat="server" ID="ctl1073"><Listeners><RowSelect  Handler="getRowIndex(rowIndex)"/></Listeners>
                                                             </ext:RowSelectionModel>
                                </selectionmodel>
<listeners><Click Handler="NewRow(#{gridVoyageRoute},0,1)" /></listeners>
</ext:GridPanel> </td> </tr> </table> </td> </tr>
<tr>
    <td valign="top" id="GridView_1">
        <ext:GridPanel ID="gridVoyage" runat="server" Width="300" Height="237">
            <Store>
                <ext:Store runat="server" ID="storeVoyage">
                    <Reader>
                        <ext:JsonReader IDProperty="RowID">
                            <Fields>
                                <ext:RecordField Name="Voyage" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="ETD" Type="Date">
                                </ext:RecordField>
                                <ext:RecordField Name="POL" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="POD" Type="String">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>
            <ColumnModel ID="ctl989">
                <Columns>
                    <ext:RowNumbererColumn Header="No." Width="30" Align="Center">
                    </ext:RowNumbererColumn>
                    <ext:Column Header="Voyage" DataIndex="Voyage" Width="70" Align="Center">
                    </ext:Column>
                    <ext:Column Header="ETD" DataIndex="ETD" Width="78" Align="Center">
                        <Renderer Fn="Ext.util.Format.dateRenderer('Y/m/d')" />
                    </ext:Column>
                    <ext:Column Header="POL" DataIndex="POL" Width="50" Align="Center">
                    </ext:Column>
                    <ext:Column Header="POD" DataIndex="POD" Width="50" Align="Center">
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" ID="ctl988">
                    <DirectEvents>
                        <RowSelect OnEvent="gridVoyage_RowSelect">
                            <EventMask ShowMask="true" Msg=" Loading ... " CustomTarget="SHOW" />
                            <ExtraParams>
                                <ext:Parameter Name="RowID" Value="this.getSelected().id" Mode="Raw">
                                </ext:Parameter>
                            </ExtraParams>
                        </RowSelect>
                    </DirectEvents>
                </ext:RowSelectionModel>
            </SelectionModel>
        </ext:GridPanel>
    </td>
</tr>
</table> </form> </body> </html> 