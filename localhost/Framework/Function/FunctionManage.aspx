<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FunctionManage.aspx.cs" Inherits="Framework_Function_FunctionManage" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>FunctionManage</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
     <script language="javascript" type="text/javascript">

         //         var selectRowIndex = -1;
         //         function GetRowID(row) {
         //             selectRowIndex = row;
         //         }

         //         function SelectRecord() {
         //             var record = gridList.getStore().getAt(selectRowIndex); // 获取当前行的数据
         //             if (record == null || record == undefined)
         //                 return;
         //             else {
         //                 $("#txtName").val(record.data.Name);
         //                 $("#txtName").removeClass("x-form-invalid").removeClass("bottom_line").attr("validata", "true").removeAttr("title");
         //             
         //                 $("#txtName").attr("disabled", "disabled");
         //                 $("#hidID").val(record.data.ID);
         //                 
         //                 
         //                 CompanyX.SetCheckDataByRowClick(record.data.Sys, record.data.Stat, record.data.Dept);
         //                 $("#txtDes").val(record.data.Description);
         //                 $("#txtName").focus();

         //             }
         //         }

         function checkName() {
             if ($("#txtName").val() == "") {
                 return;
             }
             if ($("#hidID").val() == "-1") {
                 $.getJSON("/common/uicontrols/AjaxService/FnManageHandler.ashx?name=" + $("#txtName").val().trim() + "&type=isExistName", function (data) {
                     if (data == "true") {
                         $("#txtName").attr("validata", "false").addClass("bottom_line").attr("title", "The name already exists .");
                     } else {
                         $("#txtName").removeClass("bottom_line").attr("validata", "true").removeAttr("title");
                     }
                 });
             }
         }
     </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID = "hidID" runat="server" Text="-1"></ext:Hidden>
    <div style=" width:780px;padding-left:10px;padding-top:10px;">
      <div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                    <table cellpadding="0" cellspacing="0" border="0" width="100%" height="25px">
                        <tr>
                            <td>
                                Manage
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div style="height: 10px;">
    </div>
     <div style=" width:780px; ">
        <table border="0" cellpadding="0" cellspacing="0" width="780">
            <tr>
                <td style="width:40px;">
                    Name<span class="font_red" style="padding-left: 17px">*</span>
                </td>
                <td style="width:200px;padding-left:3px;">
                     <ext:TextField ID="txtName" runat="server" Cls="text" TabIndex="1" Width="150" AllowBlank="false" BlankText="Name can't be empty" ClearCls="">
                    <Listeners>
                        <Blur Handler="checkName()" />
                    </Listeners>

                    </ext:TextField>
                </td>
               <td  style="width:80px;">
                    Description
                </td>
                <td style="width:440px;">
                     <ext:TextField ID="txtDes" runat="server" Cls="text" TabIndex="2"  Width="440">
                    </ext:TextField>
                </td>
            </tr>
            <tr style=" height:5px;"></tr>
            <tr>
                <td>
                    Sys
                </td>
                <td colspan="3">
                <ext:Checkbox ID = "chbAllSys" runat="server" BoxLabel="ALL" Tag="ALL"  LabelAlign="Right" StyleSpec="margin-left:3px;">
                </ext:Checkbox>
                <ext:CheckboxGroup ID="tblChkSys" runat="server" LabelAlign="Right" Width="490" Height="30" >
                <Items>
                    <ext:Checkbox ID="chkAE" BoxLabel="AE" runat="server" Tag="AE" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkAI" BoxLabel="AI" runat="server" Tag="AI" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkOE" BoxLabel="OE" runat="server" Tag="OE" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkOI" BoxLabel="OI" runat="server" Tag="OI" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkAT" BoxLabel="AT" runat="server" Tag="AT" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkOT" BoxLabel="OT" runat="server" Tag="OT" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkDM" BoxLabel="DM" runat="server" Tag="DM" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkTK" BoxLabel="TK" runat="server" Tag="TK" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkBK" BoxLabel="BK" runat="server" Tag="BK" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                </Items>
            </ext:CheckboxGroup>
                </td>
            </tr>
            <tr>
            <td>
                Stat
            </td>
            <td colspan="3">
                <ext:Checkbox ID = "chbAllStat" runat="server" BoxLabel="ALL" Tag="ALL"  LabelAlign="Right" StyleSpec="margin-left:3px;">
                </ext:Checkbox>
                 <ext:CheckboxGroup ID="tblChkStat" runat="server" LabelAlign="Right" Width="650"  ColumnsNumber="6" >
                </ext:CheckboxGroup>
            </td>
            </tr>
            
              <tr style=" height:5px;"></tr>
              <tr>
            <td>
                Dept
            </td>
            <td colspan="3">
                <ext:Checkbox ID = "chbAllDept" runat="server" BoxLabel="ALL" Tag="ALL"  LabelAlign="Right" StyleSpec="margin-left:3px;">
                </ext:Checkbox>
                 <ext:CheckboxGroup ID="tblChkDept" runat="server" LabelAlign="Right" Width="435" Height="40" >
                <Items>
                    <ext:Checkbox ID="chkIT" BoxLabel="IT" runat="server" Tag="IT" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkOP" BoxLabel="OP" runat="server" Tag="OP" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkACCOUNT" BoxLabel="ACCOUNT" runat="server" Tag="ACCOUNT" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkAdmin" BoxLabel="ADMIN" runat="server" Tag="ADMIN" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>
                </Items>
            </ext:CheckboxGroup>
            </td>
            </tr>
    <%--        <tr>
                <td>
                    Description
                </td>
                <td>
                     <ext:TextField ID="txtDes" runat="server" Cls="text" TabIndex="2">
                    </ext:TextField>
                </td>
            </tr>--%>
            <tr>
                <td  colspan="4" align="right">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style=" padding-right:5px;">
                                <ext:Button ID="btnSave" runat="server" Width="65px" Text="Save">
                                    <DirectEvents>
                                        <Click OnEvent="btnSave_Click">
                                            <EventMask ShowMask="true" Msg=" Saving ... "  CustomTarget="gridList" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                            <td style=" padding-right:5px;">
                                 <ext:Button ID="btnReset" runat="server" Width="65px" Text="Reset">
                                    <DirectEvents>
                                        <Click OnEvent="btnReset_Click">
                                        </Click>
                                    </DirectEvents>
                                 </ext:Button>
                            </td>
                            <td style=" padding-right:5px; display:none;">
                                 <ext:Button ID="btnDelete" runat="server" Width="65px" Text="Delete">
                                    <DirectEvents>
                                        <Click OnEvent="btnDelete_Click">
                                        <EventMask ShowMask="true" Msg=" Deleting ... " />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                        </tr>
                    </table>
                   
                </td>
            </tr>
        </table>        
    </div>
     <div style=" width:780px; padding-top:10px;">
         <ext:GridPanel ID="gridList" runat="server" Width="780px" TrackMouseOver="true" Height="368" MinHeight="400"
                StripeRows="true" ColumnLines="True" >
                <LoadMask ShowMask="true" Msg=" Loading..." />
                <Store>
                     <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                        AutoLoad="true">
                        <AutoLoadParams> 
                            <ext:Parameter Name="start" Value="={0}" />
                            <ext:Parameter Name="limit" Value="={100}" />
                        </AutoLoadParams>
                        <Reader>
                            <ext:JsonReader IDProperty="ID">
                                <Fields>
                                    <ext:RecordField Name="ID" Type="Int">
                                    </ext:RecordField> 
                                    <ext:RecordField Name="Name" Type="String">
                                    </ext:RecordField> 
                                    <ext:RecordField Name="Sys" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="Stat" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="Dept" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="Description" Type="String">
                                    </ext:RecordField>
                                     <ext:RecordField Name="SeedKey" Type="Int">
                                    </ext:RecordField>
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server" ID="ColumnModel1">
                    <Columns>
                        <ext:RowNumbererColumn Header="No." Width="30" Align="Center">
                        </ext:RowNumbererColumn>
                        <ext:Column Header="SeedKey" DataIndex="SeedKey" Width="90">
                        </ext:Column>
                        <ext:Column Header="Name" DataIndex="Name" Width="110">
                        </ext:Column>
                        <ext:Column Header="Sys" DataIndex="Sys" Width="160">
                        </ext:Column>
                        <ext:Column Header="Stat" DataIndex="Stat" Width="155">
                        </ext:Column>
                         <ext:Column Header="Dept" DataIndex="Dept" Width="115">
                        </ext:Column>
                        <ext:Column Header="Description" DataIndex="Description" Width="100">
                        </ext:Column>
                        <ext:Column Header="ID" DataIndex="ID" Width="30" Hidden="true">
                        </ext:Column>
                    </Columns>
                </ColumnModel>
            <%--      <Listeners>
                    <RowClick Handler="GetRowID(rowIndex);SelectRecord();" />
                </Listeners>--%>
                <SelectionModel>
                      <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                        <DirectEvents>
                            <RowSelect OnEvent="row_Click">
                                <ExtraParams>
                                    <ext:Parameter Name="ID" Value="record.data.ID" Mode="Raw" />
                                    <ext:Parameter Name="Name" Value="record.data.Name" Mode="Raw" />
                                     <ext:Parameter Name="Sys" Value="record.data.Sys" Mode="Raw" />
                                     <ext:Parameter Name="Stat" Value="record.data.Stat" Mode="Raw" />
                                     <ext:Parameter Name="Dept" Value="record.data.Dept" Mode="Raw" />
                                     <ext:Parameter Name="Description" Value="record.data.Description" Mode="Raw" />
                                     <ext:Parameter Name="SeedKey" Value="record.data.SeedKey" Mode="Raw" />
                                </ExtraParams>
                            </RowSelect>
                        </DirectEvents>
                    </ext:RowSelectionModel>
                </SelectionModel>
                <BottomBar>
                        <ext:PagingToolbar PageSize="100" DisplayInfo="true" ID="PagingToolbar1" runat="server" >
                        </ext:PagingToolbar>
                </BottomBar>
            </ext:GridPanel>
    </div>
    </div>
    </form>
</body>
</html>
 <script language="javascript" type="text/javascript">

     function BindClick(chb, chbGroup) {
         // $("#chbAllSys input[type='checkbox']").unbind("click");
         $("#" + chb).click(function () {
             if (this.checked) {
                 $("#" + chbGroup + " input[type='checkbox']").attr("checked", "checked");
             } else {
                 $("#" + chbGroup + " input[type='checkbox']").attr("checked", "");
             }
         });

         $("#" + chbGroup + " input[type='checkbox']").click(function () {
             if (!this.checked) {
                 $("#" + chb).attr("checked", "");
             }
         });
     }

     Ext.onReady(function () {
         BindClick("chbAllSys", "tblChkSys");
         BindClick("chbAllStat", "tblChkStat");
         BindClick("chbAllDept", "tblChkDept");

         gridList.setHeight(document.documentElement.clientHeight - 350 - $("#PagingToolbar1").height()); //设置高度
     });


 </script>