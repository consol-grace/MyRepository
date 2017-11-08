<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="Framework_Menu_list" Theme="FORM" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <link href="../../css/style.css" rel="stylesheet" type="text/css" />
      <%--  <link href="../../Common/myplugin/myplugin.css" rel="stylesheet" type="text/css" />
        <script src="../../Common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/jquery.ui.custom.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.core.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.ui.js" type="text/javascript"></script>
        <script src="jscript-menu.js" type="text/javascript"></script>--%>
    </head>
    <body>
        <form id="form1" runat="server">
        <ext:Hidden ID="txtRowID" runat="server">
        </ext:Hidden>
        <ext:ResourceManager runat="server" ID="ResouceID" DirectMethodNamespace="CompanyX">
        </ext:ResourceManager>
        <div style="margin-left: 1px; width: 710px;">
            <table>
                <tr>
                    <td height="10">
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="724px" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                            background="../../images/bg_line.jpg" style="border: 1px solid #81b8ff; color: #1542AF">
                            <tr>
                                <td class="font_11bold_1542af" style="padding-left: 4px; padding-top: 1px">
                                    &nbsp; Menu Control&nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="1" style="padding-bottom: 8px; line-height:20px;
                padding-top: 8px; padding-right: 5px">
                <tr>
                    <td style="padding-left:12px">
                        Root
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" ID="txtRoot" runat="server" Cls="text_80px" Width="113px" TabIndex="1">
                        </ext:TextField>
                    </td>
                    <td style="padding-left:10px">
                        Parant
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" ID="txtParant" runat="server" Cls="text_80px" Width="113px"  TabIndex="2">
                        </ext:TextField>
                    </td>
                    <td style="padding-left:10px">
                        Menu
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" ID="txtMenu" runat="server" Cls="text_80px" Width="113px" TabIndex="3" >
                        </ext:TextField>
                    </td>
                    <td style="padding-left:10px; padding-right:3px">
                        Remark
                    </td>
                    <td>
                        <ext:TextField ID="txtRemark" runat="server" Cls="text_80px" Width="113px"  TabIndex="4">
                        </ext:TextField>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:12px">
                       <table width="70" cellpadding="0" cellspacing="0" border="0"><tr><td> Name (CHS)</td></tr></table>
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" ID="txtNameCHS" runat="server" Cls="UpperCase text_80px"  Width="113px" TabIndex="5" >
                        </ext:TextField>
                    </td>
                    <td style="padding-left:10px">
                        <table cellpadding="0" cellspacing="0" border="0" width="70px"><tr><td>Name (ENG)</td></tr></table>
                    </td>
                    <td>
                        <ext:TextField AllowBlank="false" ID="txtNameENG" runat="server" Cls="UpperCase text_80px"   Width="113px" TabIndex="6">
                        </ext:TextField>
                    </td>
                    <td style="padding-left:10px; padding-right:4px">
                        Order
                    </td>
                    <td>
                        <ext:NumberField AllowBlank="false" ID="txtOrder" runat="server" Cls="text_80px" Width="113px"  StyleSpec="text-align:right" TabIndex="7">
                        </ext:NumberField>
                    </td>
                    <td style="padding-left:10px">
                        Level
                    </td>
                    <td>
                        <ext:NumberField AllowBlank="false" ID="txtLevel" runat="server" Cls="text_80px" Width="113px" StyleSpec="text-align:right" TabIndex="8">
                        </ext:NumberField>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:12px">
                        Hyper Link
                    </td>
                    <td colspan="3">
                        <ext:TextField AllowBlank="false" ID="txtHyperLink" runat="server" Cls="UpperCase text_80px" Width="309px" TabIndex="9">
                        </ext:TextField>
                    </td>
                </tr>
            </table>
            <table width="725px" border="0" cellpadding="0" cellspacing="0" style="padding-bottom: 8px;
                padding-top: 3px;">
                <tr>
                    <td colspan="2" >
                        &nbsp;
                    </td>
                    <td align="right" width="70px">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="btn_L">
                                </td>
                                <td>
                                    <input type="button" id="btnNext" value="Next" runat="server" onclick="CompanyX.btnAddSave_Click();"
                                        style="cursor: pointer; width: 65px" class="btn_C btn_text" tabindex="10" />
                                </td>
                                <td class="btn_R">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right" width="70px" style="padding-left: 3px">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="btn_L">
                                </td>
                                <td>
                                    <input type="button" id="btnDelete" value="Delete" runat="server" onclick="Ext.Msg.confirm('status','Are you sure you want to delete',function(btn){if(btn=='yes'){CompanyX.btnCancel_click();}});"
                                        class="btn_text btn_C" style="cursor: pointer; width: 65px" tabindex="11" />
                                </td>
                                <td class="btn_R">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="right" width="70px" style="padding-right: 1px; padding-left: 3px">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="btn_L">
                                </td>
                                <td>
                                    <input type="button" id="btnSave" value="Save" runat="server" onclick="CompanyX.btnSave_Click();"
                                        tabindex="12" class="btn_text btn_C" style="cursor: pointer; width: 65px" />
                                </td>
                                <td class="btn_R">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="gridpanel">
                <ext:Store runat="server" ID="GridStore">
                    <Reader>
                        <ext:JsonReader IDProperty="RowID">
                            <Fields>
                                <ext:RecordField Name="RowID" Type="Int">
                                </ext:RecordField>
                                <ext:RecordField Name="RootID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="ParentID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="MenuID" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="NameCHS" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="NameENG" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Hyperlink" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="OrderBy" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="LevelIndex" Type="String">
                                </ext:RecordField>
                                <ext:RecordField Name="Remark" Type="String">
                                </ext:RecordField>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
                <ext:GridPanel ID="GridPanel" runat="server" StoreID="GridStore" Width="724px" Height="342px"
                    TrackMouseOver="true" StripeRows="true" ColumnLines="True">
                    <ColumnModel ID="ctl33">
                        <Columns>
                            <ext:RowNumbererColumn Header="No." Width="30">
                            </ext:RowNumbererColumn>
                            <ext:Column Header="Root" DataIndex="RootID" Width="50">
                            </ext:Column>
                            <ext:Column Header="Parent" DataIndex="ParentID" Width="50">
                            </ext:Column>
                            <ext:Column Header="Menu" DataIndex="MenuID" Width="50">
                            </ext:Column>
                            <ext:Column Header="Order" DataIndex="OrderBy" Width="60" Align="Right">
                            </ext:Column>
                            <ext:Column Header="Level" DataIndex="LevelIndex" Width="60" Align="Right">
                            </ext:Column>
                            <ext:Column Header="Name (CHS)" DataIndex="NameCHS" Width="120">
                            </ext:Column>
                            <ext:Column Header="Name (ENG)" DataIndex="NameENG" Width="120">
                            </ext:Column>
                            <ext:Column Header="Hyperlink" DataIndex="Hyperlink" Width="163">
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server">
                            <DirectEvents>
                                <RowSelect OnEvent="row_Click">
                                    <ExtraParams>
                                        <ext:Parameter Name="RowID" Value="record.data.RowID" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="RootID" Value="record.data.RootID" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="ParentID" Value="record.data.ParentID" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="MenuID" Value="record.data.MenuID" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="NameCHS" Value="record.data.NameCHS" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="NameENG" Value="record.data.NameENG" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="Hyperlink" Value="record.data.Hyperlink" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="OrderBy" Value="record.data.OrderBy" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="LevelIndex" Value="record.data.LevelIndex" Mode="Raw">
                                        </ext:Parameter>
                                        <ext:Parameter Name="Remark" Value="record.data.Remark" Mode="Raw">
                                        </ext:Parameter>
                                    </ExtraParams>
                                </RowSelect>
                            </DirectEvents>
                        </ext:RowSelectionModel>
                    </SelectionModel>
                </ext:GridPanel>
            </div>
        </div>
        
        
            <%--<div class="clear">
                <div class="float-left splitor-right pDiv">
                    <div runat="server" id="divTreeList"></div>
                </div>
                <div class="float-left pDiv">
                    <div class="mypanel">
                        <table id="table-menu-main" cellpadding="0" cellspacing="0" border="0" style="width:600px">
                            <tr>
                                <th>上级编号</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="ParentID" name="ParentID" value="M01" />
                                    <input type="hidden" id="RootID" name="RootID" />
                                </td>
                                <th>上级名称</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="PNameCHS" name="PNameCHS" value="基本资料" />
                                </td>
                            </tr>
                            <tr>
                                <th>菜单编号</th>
                                <td>
                                    <input type="text" id="MenuID" name="MenuID" value="M0101" />
                                </td>
                                <th>菜单名称</th>
                                <td>
                                    <input type="text" id="NameCHS" name="NameCHS" value="区域设置" />
                                </td>
                            </tr>
                            <tr>
                                <th>超链</th>
                                <td colspan="3">
                                    <input type="text" id="Hyperlink" name="Hyperlink" style="width:98%" value="#1" />
                                </td>
                            </tr>
                        </table>
                        
                        <div class="pDivSplitor">
                            <button type="button" id="btnSub">子级</button><button type="button" id="btnMain">同级</button><button type="button" id="btnDelete">删除</button><button type="button" id="btnSave1">保存</button>
                        </div>
                    </div>    
                    
                    
                    
                    <div id="pMainOrSub" class="mypanel">
                        <table id="table-menu-sub" cellpadding="0" cellspacing="0" border="0" style="width:600px">
                            <caption>新增同级</caption>
                            <tr>
                                <th>上级编号</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="ParentID1" name="ParentID1" />
                                    <input type="hidden" id="RootID1" name="RootID1" />
                                </td>
                                <th>上级名称</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="PNameCHS1" name="PNameCHS1" />
                                </td>
                            </tr>
                            <tr>
                                <th>菜单编号</th>
                                <td>
                                    <input type="text" id="MenuID1" name="MenuID1" />
                                </td>
                                <th>菜单名称</th>
                                <td>
                                    <input type="text" id="NameCHS1" name="NameCHS1" />
                                </td>
                            </tr>
                            <tr>
                                <th>超链</th>
                                <td colspan="3">
                                    <input type="text" id="Hyperlink1" name="Hyperlink1" style="width:98%" value="#1" />
                                </td>
                            </tr>
                        </table>
                        <div class="pDivSplitor">
                            <button type="button" id="btnCancel">取消</button><button type="button" id="btnSave2">保存</button>
                        </div>
                    </div>                
                </div> 
            </div>--%>
        
        </form>
    </body>
</html>
