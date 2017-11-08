<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WareHouse.aspx.cs" Inherits="OceanExport_OEWareHouse_WareHouse" %>

<%@ Register Src="/common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="/common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/UserComboBox.ascx" TagName="UserComboBox" TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/AutoComplete.ascx" TagName="AutoComplete" TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/Costing.ascx" TagName="Costing" TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>OE-WareHouse</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="/common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="/common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="/common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../OEJs/gridList.js" type="text/javascript"></script>

    <style type="text/css">
        .style1
        {
            width: 0px;
        }
        .font_12px_Arial
        {
            font-family: "微软雅黑" , "黑体" !important;
            font-size: 11px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" target="_blank">
    <input type="hidden" value="0" id="hidSetInformation" />
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="rowid" runat="server" Text="">
    </ext:Hidden>
    <ext:Hidden ID="seed" runat="server" Text="">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreVessel" OnRefreshData="StoreVessel_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreVoyage" OnRefreshData="StoreVoyage_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="ETD">
                    </ext:RecordField>
                    <ext:RecordField Name="ETA">
                    </ext:RecordField>
                    <ext:RecordField Name="POL">
                    </ext:RecordField>
                    <ext:RecordField Name="POD">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreLocation" OnRefreshData="StoreLocation_OnRefreshData">
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
    <div id="div_title" style="width: 100%; z-index: 999; left: 0px;">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="O" />
    </div>
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index: 99;">
        <table width="980px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
            <tr>
                <td width="100%" style="padding-left: 3px; padding-top: 2px">
                    <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                        alt="View" onclick="createFrom('OE');" />
                    &nbsp; OE - WareHouse Information &nbsp;
                    <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;
                        display: none;" />
                </td>
                <td>
                    <span style="display: block; width: 35px; padding-left: 10px">MBL# </span>
                </td>
                <td style="padding-right: 5px">
                    <nobr> <ext:Label ID="labMBL" runat="server" StyleSpec=" color:#ff0000;">
                    </ext:Label></nobr>
                </td>
                <td style="padding-left: 10px">
                    <span style="display: block; width: 30px">Lot# </span>
                </td>
                <td style="padding-right: 10px">
                    <nobr><ext:Label runat="server" ID="labImpLotNo" StyleSpec=" color:#ff0000;">
                    </ext:Label></nobr>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-left: 10px; margin-top: 110px; width: 978px; padding-bottom: 40px;
        float: left">
        <table cellpadding="0" cellspacing="5" border="0" width="669px" style="float: left;
            margin-right: 0px; margin-top: 3px;">
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 26px">
                                <div class="font_12px_Arial" style="width: 60px">
                                    客 户</div>
                            </td>
                            <td colspan="3">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <uc1:AutoComplete runat="server" ID="txtCustomer" clsClass="x-form-text x-form-field text"
                                                TabIndex="1" Width="83" winTitle="Company" isDiplay="false" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" Query="option=CompanyList" />
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtCustomerLine" runat="server" Cls="text_80px" ReadOnly="true"
                                                Width="171" StyleSpec="border:0;background:none">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <div style="width: 60px; padding: 0px 0px 0px 10px" class="font_12px_Arial">
                                    通知时间</div>
                            </td>
                            <td>
                                <ext:DateField ID="txtNoticeDate" runat="server" Cls="text_80px" Width="88" TabIndex="2">
                                </ext:DateField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 3px 0px 8px 5px;" class="font_12px_Arial">
                                公 司
                            </td>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <uc1:AutoComplete runat="server" ID="txtCompany" clsClass="x-form-text x-form-field text"
                                                TabIndex="3" Width="83" winTitle="Company" isDiplay="false" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" Query="option=CompanyList" />
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtCompanyName" runat="server" Cls="text_80px" ReadOnly="true"
                                                Width="171" StyleSpec="border:0;background:none">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <div style="width: 55px; height: 12px; padding: 0px 0px 0px 9px" class="font_12px_Arial">
                                    联系电话</div>
                            </td>
                            <td>
                                <ext:TextField ID="txtPhone" runat="server" Cls="text_80px" Width="88" TabIndex="4">
                                </ext:TextField>
                            </td>
                            <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                传 真
                            </td>
                            <td>
                                <ext:TextField ID="txtFax" runat="server" Cls="text_80px" TabIndex="5">
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 3px 0px 3px 5px" class="font_12px_Arial">
                                文 件
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtDcument" runat="server" Cls="text_80px" TabIndex="6" Width="110">
                                            </ext:TextField>
                                        </td>
                                        <td style="padding: 0px 0px 0px 15px" class="font_12px_Arial">
                                            <div style="width: 40px">
                                                分 机</div>
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtDocExt" runat="server" Cls="text_80px" TabIndex="7" Width="118">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="font_12px_Arial" style="padding: 0px 0px 0px 9px">
                                操 作 员
                            </td>
                            <td>
                                <ext:TextField ID="txtOperation" runat="server" Cls="text_80px" Width="88" TabIndex="8">
                                </ext:TextField>
                            </td>
                            <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                分 机
                            </td>
                            <td>
                                <ext:TextField ID="txtOpExt" runat="server" Cls="text_80px" Width="88" TabIndex="9">
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 30px" class="font_12px_Arial">
                                船名/航次
                            </td>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <ext:ComboBox ID="cmbVesselCode" runat="server" Cls="select" Width="110" StoreID="StoreVessel"
                                                    DisplayField="text" TabIndex="10" ValueField="value" Mode="Local" ForceSelection="true"
                                                    TriggerAction="All">
                                                    <DirectEvents>
                                                        <Select OnEvent="cmbVessel_Select">
                                                        </Select>
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                            </td>
                                            <td style="padding-left: 3px">
                                            </td>
                                            <td>
                                                <ext:ComboBox ID="cmbVesselText" runat="server" Cls="select" Width="150" StoreID="StoreVoyage"
                                                    ItemSelector="tr.list-item" ListWidth="130px" DisplayField="text" ValueField="value"
                                                    TabIndex="11" Mode="Local" ForceSelection="true" TriggerAction="All">
                                                    <%--     <Listeners>
                                                                <Select Handler="CompanyX.BindVoyag(this.getValue());" />
                                                            </Listeners>--%>
                                                    <DirectEvents>
                                                        <Select OnEvent="cmbVesselText_Select" />
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                            </td>
                                            <td style="text-align: left;">
                                                <img src="../../images/select_btn.jpg" width="18" height="18" class="cursor" alt=""
                                                    onclick="CompanyX.ShowVoyage();">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td class="font_12px_Arial" style="padding: 0px 0px 0px 8px">
                                目 的 港
                            </td>
                            <td>
                                <uc1:UserComboBox runat="server" ID="txtPOD" ListWidth="180" clsClass="select_160px"
                                    TabIndex="12" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="67"
                                    winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                    winHeight="620" />
                            </td>
                            <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                开航时间
                            </td>
                            <td>
                                <ext:DateField ID="txtETD" runat="server" Cls="text_80px" Width="88" TabIndex="13">
                                </ext:DateField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 8px" colspan="8">
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <table cellpadding="0" cellspacing="0" border="0" width="665px">
                        <tr>
                            <td colspan="8" style="background-image: url(../../images/bg_line_3.jpg); line-height: 22px;
                                border: solid 1px #8db2e3;">
                                <div style="padding: 0px 0px 0px 5px; font-family: '微软雅黑' '黑体' !important;" class="font_12bold">
                                    仓库信息</div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <table cellpadding="0" cellspacing="0" border="0" width="400px">
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 30px" class="font_12px_Arial">
                                <div style="width: 60px">
                                    仓库代码</div>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding: 1px 0px 0px 0px">
                                            <uc1:AutoComplete runat="server" ID="txtwarehouse" clsClass="x-form-text x-form-field text"
                                                TabIndex="14" Width="63" isDiplay="false" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="700" winHeight="800" Query="option=CompanyList" />
                                        </td>
                                        <td style="padding: 0px 0px 0px 3px">
                                            <ext:TextField ID="txtWsheName" Width="188" runat="server" Cls="text_80px" TabIndex="14">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                            <div style="width: 56px;">
                                                关 单 号</div>
                                        </td>
                                        <td colspan="">
                                            <ext:TextField ID="txtDeclareNo" runat="server" Cls="text_80px" Width="149" TabIndex="15">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px" class="font_12px_Arial">
                                仓库地址
                            </td>
                            <td>
                                <ext:TextField ID="txtwhseAdd" Width="283" runat="server" Cls="text_80px" TabIndex="14">
                                </ext:TextField>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                            <div style="width: 56px">
                                                进仓编号</div>
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtNoticeNo" runat="server" Cls="text_80px" TabIndex="16" Width="149">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 30px" class="font_12px_Arial">
                                联 系 人
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtWsheContact" runat="server" Cls="text_80px" Width="110" TabIndex="14">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 15px">
                                            <div style="width: 40px">
                                                电 话</div>
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtWshePhone" runat="server" Cls="text_80px" TabIndex="14" Width="118">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                            <div style="width: 56px">
                                                进仓时间</div>
                                        </td>
                                        <td>
                                            <ext:DateField ID="txtWhseClosing" Format="dd/MM" runat="server" Cls="text_60px"
                                                Width="88" TabIndex="17">
                                            </ext:DateField>
                                        </td>
                                        <td style="padding: 0px 0px 0px 2px">
                                            <ext:TimeField ID="txtWsheTime" MinTime="0:00" MaxTimer="23:00" Format="HH:mm" Increment="60"
                                                runat="server" Cls="text_60px" TabIndex="18" Width="58">
                                            </ext:TimeField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px" class="font_12px_Arial">
                                分 机
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtWsheExt" runat="server" Cls="text_80px" Width="110" TabIndex="14">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 15px">
                                            <div style="width: 40px">
                                                传 真</div>
                                        </td>
                                        <td>
                                            <ext:TextField ID="txtWsheFxt" runat="server" Cls="text_80px" Width="118" TabIndex="14">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 10px">
                                            <div style="width: 56px">
                                                单证时间</div>
                                        </td>
                                        <td>
                                            <ext:DateField ID="txtHandleClosing" runat="server" Cls="text_80px" Width="88" TabIndex="19">
                                            </ext:DateField>
                                        </td>
                                        <td style="padding: 0px 0px 0px 2px">
                                            <ext:TimeField ID="txtHandleTime" MinTime="0:00" MaxTimer="23:00" Format="HH:mm"
                                                Increment="60" runat="server" Cls="text_60px" TabIndex="19" Width="58">
                                            </ext:TimeField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="8" style="height: 8px">
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <table cellpadding="0" cellspacing="0" border="0" width="665px">
                        <tr>
                            <td colspan="8" style="background-image: url(../../images/bg_line_3.jpg); line-height: 22px;
                                border: solid 1px #8db2e3;">
                                <div style="padding: 0px 0px 0px 5px;" class="font_12bold">
                                    单证信息</div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <table cellpadding="0" cellspacing="0" border="0" width="250px">
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 30px">
                                <div style="width: 60px" class="font_12px_Arial">
                                    公司代码</div>
                            </td>
                            <td colspan="3">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding: 1px 0px 0px 0px">
                                            <uc1:AutoComplete runat="server" ID="txtHandle" clsClass="x-form-text x-form-field text"
                                                TabIndex="20" Width="63" isDiplay="false" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="700" winHeight="800" Query="option=CompanyList" />
                                        </td>
                                        <td style="padding: 0px 0px 0px 3px">
                                            <ext:TextField ID="txtHandleName" Width="188" runat="server" Cls="text_80px" TabIndex="21">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px" class="font_12px_Arial">
                                公司地址
                            </td>
                            <td colspan="2">
                                <ext:TextField ID="txtHandleAdd" Width="283" runat="server" Cls="text_80px" TabIndex="21">
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px; line-height: 30px" class="font_12px_Arial">
                                联 系 人
                            </td>
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtHandlContact" runat="server" Cls="text_80px" TabIndex="21"
                                                Width="110">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 15px">
                                            <div style="width: 40px">
                                                电 话</div>
                                        </td>
                                        <td colspan="5">
                                            <ext:TextField ID="txtHandlPhone" runat="server" Cls="text_80px" Width="118" TabIndex="21">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 0px 0px 0px 5px" class="font_12px_Arial">
                                分 机
                            </td>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtHandlExt" runat="server" Cls="text_80px" TabIndex="21" Width="110">
                                            </ext:TextField>
                                        </td>
                                        <td class="font_12px_Arial" style="padding: 0px 0px 0px 15px">
                                            <div style="width: 40px">
                                                传 真</div>
                                        </td>
                                        <td colspan="5">
                                            <ext:TextField ID="txtHandlFxt" runat="server" Cls="text_80px" Width="118" TabIndex="21">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" width="300px" style="float: right">
            <tr>
                <td>
                    <div id="div_top" style="margin-top: 116px">
                        <table width="301" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td width="301" class="font_11bold_1542af">
                                    &nbsp;&nbsp;Action
                                </td>
                            </tr>
                        </table>
                        <table width="260" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="table" style="padding-bottom: 5px; padding-top: 5px; padding-left: 10px;">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center">
                                                <ext:Button ID="btnPrint" runat="server" Cls="Submit_65px" Width="65px" Text="Print">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnPrint_Click">
                                                            <EventMask Msg="Saving..." ShowMask="true" />
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="table">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center">
                                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_65px" Width="65px" Text="Cancel">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnCancel_Click">
                                                            <EventMask Msg="Loading..." ShowMask="true" />
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="table">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center" style="padding-left: 2px">
                                                <ext:Button ID="btnSave" runat="server" Cls="Submit_65px" Width="65px" Text="Save">
                                                    <DirectEvents>
                                                        <Click OnEvent="btnSave_Click">
                                                            <EventMask Msg="Saving..." ShowMask="true" />
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
                </td>
            </tr>
        </table>
    </div>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    </form>
</body>
</html>
