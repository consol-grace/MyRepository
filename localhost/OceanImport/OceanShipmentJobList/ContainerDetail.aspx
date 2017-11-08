<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContainerDetail.aspx.cs" Inherits="OceanImport_OceanShipmentJobList_ContainerDetail" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
    <script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>
</head>
<body>

    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">        
    </ext:ResourceManager>
    <ext:Hidden ID="hidID" runat="server"></ext:Hidden><ext:Hidden ID="hidShort" runat="server"></ext:Hidden>
    <div id="location_div01" style=" width:400px;">
<table width="400" border="0" cellpadding="0" cellspacing="0">
<tr>
<td colspan="2" valign="top"><table  border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="table_nav1 font_11bold_1542af" style="padding-left:5px; width:400px;" >OI - BL Description</td>
</tr>
</table></td>
</tr>
<tr>
<td height="10px" colspan="2"></td>
</tr>
<tr>
<td width="71" valign="top" style="padding-left:5px; padding-right:5px">Description<span class="font_red">*</span></td>
<td style="padding-right:5px">
<ext:TextArea ID="txtDescrip" runat="server" StyleSpec="font-family:Arial, Helvetica, sans-serif; font-size:10px; height:60px; width:315px" TabIndex="1">
</ext:TextArea>
</td>
</tr>
<tr>
<td height="10" colspan="2"></td>
</tr>

<tr>
<td colspan="2" align="right" style="padding-right:5px" >
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<ext:Button ID="btnDelete" runat="server" Cls="Submit_70px" Width="70px"  Text="Delete" >
	<DirectEvents>
    <Click OnEvent="btnDelete_Click" >
     <EventMask ShowMask="true" Msg=" Deleting ... " />
     </Click>
     </DirectEvents>
</ext:Button>
</td>
<td style="padding-left:2px" >
<ext:Button ID="btnNext" runat="server" Cls="Submit_70px" Width="70px"  Text="Next">
<Listeners><Click Handler="if(#{txtDescrip}.getValue(true)==''){Ext.Msg.alert('Status', 'Input can not be empty ! ! ! '); return false;}" /></Listeners> 
	<DirectEvents>
    <Click OnEvent="btnNext_Click">
     <EventMask ShowMask="true" Msg=" Saving ... " />
     </Click>
     </DirectEvents>
</ext:Button>
</td>
<td style="padding-left:2px">
<ext:Button ID="btnCancel" runat="server" Cls="Submit_70px" Width="70px"  Text="Cancel">
	<DirectEvents>
    <Click OnEvent="btnCancel_Click">
     <EventMask ShowMask="true" Msg=" Canceling ... " />
     </Click>
     </DirectEvents>
</ext:Button>
</td>
<td style="padding-left:2px">
<ext:Button ID="btnSave" runat="server" Cls="Submit_70px" Width="70px"  Text="Save">
       <Listeners><Click Handler="if(#{txtDescrip}.getValue(true)==''){Ext.Msg.alert('Status', 'Input can not be empty ! ! ! '); return false;}" /></Listeners>  
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
<tr>
<td colspan="2" align="right">&nbsp;</td>
</tr>
<tr>
<td colspan="2" id="GridView">
<ext:GridPanel ID="GridPanelDescription" runat="server" Width="401px" Height="341" TrackMouseOver="true">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreDescription">
                                            <Reader>
                                                <ext:JsonReader IDProperty="st_ROWID">
                                                    <Fields>
                                                        <ext:RecordField Name="st_ROWID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="st_Text" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="st_Short" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel1">
                                        <Columns>
                                            <ext:Column Header="Description" DataIndex="st_Text" Width="380">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                <ext:RowSelectionModel runat="server" ID="RowSelectionModel1" SingleSelect="true">
                  <DirectEvents>
                                                <RowSelect OnEvent="row_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="st_ROWID" Value="this.getSelected().id" Mode="Raw" />
                                                        <ext:Parameter Name="st_Text" Value="record.data.st_Text" Mode="Raw" />
                                                        <ext:Parameter Name="st_Short" Value="record.data.st_Short" Mode="Raw" />
                                                    </ExtraParams>
                                                </RowSelect>
                                            </DirectEvents>               
                </ext:RowSelectionModel>
            </SelectionModel>
 </ext:GridPanel>
</td>
</tr>
</table>
</div>
    </form>
</body>
</html>
