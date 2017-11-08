<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Country</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
	       <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
        <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager1"></ext:ResourceManager>
    <div id="location_div01">
        <table  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table  border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                    <table  border="0" cellspacing="0" cellpadding="0" width="452px">
<tr>
<td class="table_nav1 font_11bold_1542af" style="padding-left:10px" >System Config</td>
</tr>
</table>
                    </td></tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td id="GridView">
                                <ext:Store ID="StoreDomestic" runat="server">
                                    <Reader>
                                        <ext:JsonReader IDProperty="cfg_ROWID">
                                            <Fields>
                                                <ext:RecordField Name="cfg_Code" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="cfg_value" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="cfg_Type" Type="String">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                                <ext:GridPanel ID="GridPanel1" runat="server" Height="342" StoreID="StoreDomestic"
                                    TrackMouseOver="true" StripeRows="true">
                                    <ColumnModel ID="ctl33">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Code" DataIndex="cfg_Code" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="Type" DataIndex="cfg_Type" Width="100">
                                            </ext:Column>
                                            <ext:Column Header="Value" DataIndex="cfg_value" Width="200">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                    
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
