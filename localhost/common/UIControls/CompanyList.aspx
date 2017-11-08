<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompanyList.aspx.cs" Inherits="common_UIControls_CompanyList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ OutputCache Duration="3600" VaryByParam="code" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="/common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="/common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="/common/uicontrols/CompanyDrpList.js" type="text/javascript"></script>

    <script type="text/javascript">
        var selectRow = -1;
        function getRowIndex(rowIndex) {
            selectRow = rowIndex;
        }


        function btnClick(obj, event) {
            event = event || window.event;
            if (event.keyCode == 13 && (!event.ctrlKey)) {
                btnfilter.fireEvent('click');
                gridList.focus();
                gridList.getSelectionModel().selectFirstRow();
                $(obj).focus();
            }
            else if (event.keyCode == 40) {

                //alert();
                event.keyCode = 9;
                //gridList.getSelectionModel().selectFirstRow();
                gridList.focus();
                gridList.view.focusEl.focus();

                gridList.getSelectionModel().selectRow(1);
                event.keyCode = 9;
                event.keyCode = 9;
                //alert(document.activeElement.id);
            }
            else if (event.keyCode == 13 && event.ctrlKey) {

                var record = gridList.getStore().getAt(selectRow);
                if (record != null) { window.parent.GetCompany(Request('control'), record.data.Code, record.data.Name); }
                else { window.parent.GetCompany(Request('control'), '', ''); }

            }

        }

    </script>

</head>
<body style="background-color: #CCD9E8; padding-left: 2px">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="resManage" runat="server">
    </ext:ResourceManager>
    <ext:KeyNav runat="server" ID="KeyNav1" Target="#{form1}">
        <Esc Handler="var record=#{gridList}.getStore().getAt(selectRow);if(record!=null){window.parent.GetCompany(Request('control'),record.data.Code,record.data.Name);}else{ window.parent.GetCompany(Request('control'),'',''); }" />
    </ext:KeyNav>
    <table>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <td style="padding-left: 10px; padding-right: 2px">
                            Code / Name 
                        </td> 
                        <td>
                            <ext:TextField ID="txtCode" runat="server" EnableKeyEvents="true" StyleSpec=" font-family:Arial; font-size:10px"
                                Cls="text" Width="150px">
                                <Listeners>
                                    <KeyUp Handler="btnClick(this,event);" />
                                    <Focus Handler="getSelectPos(this)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td style=" padding-left: 10px; padding-right: 2px">
                            Address
                        </td>
                        <td>
                            <ext:TextField ID="txtAddress" runat="server" EnableKeyEvents="true" StyleSpec=" font-family:Arial; font-size:10px"
                                Width="180" Cls="text">
                                <Listeners>
                                    <KeyUp Handler="btnClick(this,event);" />
                                    <Focus Handler="getSelectPos(this)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td style="padding-left: 21px" valign="middle">
                            <ext:Checkbox ID="all" runat="server" BoxLabel="All">
                                <DirectEvents>
                                    <Check OnEvent="btnfilter_Click">
                                        <EventMask Msg=" Loading... " ShowMask="true" Target="Page" />
                                    </Check>
                                </DirectEvents>                                
                            </ext:Checkbox>
                        </td>
                        <td style="padding-left: 10px">
                            <ext:Button ID="btnfilter" runat="server" Text="Filter" Width="60">
                                <DirectEvents>
                                    <Click OnEvent="btnfilter_Click">
                                        <EventMask Msg=" Loading... " ShowMask="true" Target="Page" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </td>
                        <td style="width:20px;">                            
                        </td>
                        <td>             
                            <ext:Button ID="btnNewCompany" runat="server" Text="New"  Width="60">
                                <Listeners>
                                    <Click Handler="window.open('/BasicData/Customer/detail.aspx?type=list&control='+Request('control'),'_self')" />
                                </Listeners>
                            </ext:Button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <ext:GridPanel runat="server" ID="gridList" Height="500" Width="420px">
                    <Store>
                        <ext:Store runat="server" ID="storeCompany" OnRefreshData="storeList_OnRefreshData"
                            AutoLoad="true">
                            <AutoLoadParams>
                                <ext:Parameter Name="start" Value="={0}" />
                                <ext:Parameter Name="limit" Value="={100}" />
                            </AutoLoadParams>
                            <Reader>
                                <ext:JsonReader>
                                    <Fields>
                                        <ext:RecordField Name="Code">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Name">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Type">
                                        </ext:RecordField>
                                        <ext:RecordField Name="Remark">
                                        </ext:RecordField>
                                    </Fields>
                                </ext:JsonReader>
                            </Reader>
                            <Listeners>
                                <Load Handler="if(typeof gridList=='object'){#{txtRemark}.setValue('');#{gridList}.getSelectionModel().selectFirstRow();}" />
                            </Listeners>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server" ID="ctl39">
                        <Columns>
                            <ext:RowNumbererColumn Header="No" Width="28">
                            </ext:RowNumbererColumn>
                            <ext:Column Header="Code" DataIndex="Code" Width="92">
                            </ext:Column>
                            <ext:Column Header="Name" DataIndex="Name" Width="220">
                            </ext:Column>
                            <ext:Column Header="Type" DataIndex="Type" Width="57">
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" ID="ctl38">
                            <Listeners>
                                <RowSelect Handler="getRowIndex(rowIndex);#{txtRemark}.setValue(record.data.Remark)" />
                            </Listeners>
                        </ext:RowSelectionModel>
                    </SelectionModel>
                    <Listeners>
                        <RowDblClick Handler="var record=this.getStore().getAt(rowIndex);window.parent.GetCompany(Request('control'),record.data.Code,record.data.Name);" />
                        <KeyPress Handler="getSelectPos('txtCode')" />
                    </Listeners>
                    <KeyMap>
                        <ext:KeyBinding Ctrl="true">
                            <Keys>
                                <ext:Key Code="ENTER" />
                            </Keys>
                            <Listeners>
                                <Event Handler="var record=#{gridList}.getStore().getAt(selectRow);window.parent.GetCompany(Request('control'),record.data.Code,record.data.Name,Request('scrollTop'));" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="ENTER" />
                            </Keys>
                            <Listeners>
                                <Event Handler="getSelectPos('txtCode')" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="RIGHT" />
                            </Keys>
                            <Listeners>
                                <Event Handler="#{PagingToolbar1}.moveNext();" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding>
                            <Keys>
                                <ext:Key Code="LEFT" />
                            </Keys>
                            <Listeners>
                                <Event Handler="#{PagingToolbar1}.movePrevious();" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding Ctrl="true">
                            <Keys>
                                <ext:Key Code="LEFT" />
                            </Keys>
                            <Listeners>
                                <Event Handler="#{PagingToolbar1}.moveFirst()" />
                            </Listeners>
                        </ext:KeyBinding>
                        <ext:KeyBinding Ctrl="true">
                            <Keys>
                                <ext:Key Code="RIGHT" />
                            </Keys>
                            <Listeners>
                                <Event Handler="#{PagingToolbar1}.moveLast()" />
                            </Listeners>
                        </ext:KeyBinding>
                    </KeyMap>
                    <BottomBar>
                        <ext:PagingToolbar StoreID="storeCompany" PageSize="100" DisplayInfo="true" ID="PagingToolbar1"
                            runat="server">
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
            </td>
            <td valign="top">
                <p style="background-image: url(../../images/bg_line_3.jpg); border: solid 1px #8DB2E3;
                    padding-left: 8px; height: 24px; font-weight: bold; line-height: 24px; margin-bottom: 5px">
                    Remark
                </p>
                <textarea id="txtRemark" style="width: 307px; border: solid 1px #8DB2E3; height: 465px; background-color:#efefef; font-family: Arial, Helvetica, sans-serif; font-size: 11px; vertical-align: top; overflow: auto" readonly="readonly" disabled="disabled"></textarea>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
