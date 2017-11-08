<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailList.aspx.cs" Inherits="OceanExport_OEJobList_DetailList" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/UIControls/gridHtml.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var sysType = Request("sys");
        var FormatNumber3 = function(obj) {
            if (obj != null) {
                return obj.toFixed(3);
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
     <ext:Hidden ID="hidShowVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidShowInv" runat="server" Text="1">
    </ext:Hidden>
     <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>
    <div>
        <div style="display: none">
            <ext:Button ID="btnCancel" runat="server" Text="Cancel">
                <DirectEvents>
                    <Click OnEvent="btnCancel_Click">
                        <EventMask ShowMask="true" />
                    </Click>
                </DirectEvents>
            </ext:Button>
        </div>
        <div>
            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                <tbody>
                    <tr>
                        <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                            <table width="100%">
                                <tbody>
                                    <tr>
                                        <td width="180" align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                            Other Business-Detail List
                                        </td>
                                         <td width="60px" style="padding:0 0 0 0;">
                                                    <ext:Checkbox ID="chkShowVoid" runat="server" BoxLabel="Void" BoxLabelStyle="color:red;font-weight:bold">
                                                        <Listeners>
                                                            <Check Handler="if(this.checked){hidShowVoid.setValue('1')}else{hidShowVoid.setValue('0')};CompanyX.ShowVoid();" />
                                                        </Listeners>
                                                    </ext:Checkbox>
                                                </td>
                                                <td>
                                                <ext:Checkbox ID="chkShowInv" runat="server" BoxLabel="Invoice" BoxLabelStyle="color:red;font-weight:bold" Checked="true">
                                                        <Listeners>
                                                            <Check Handler="if(this.checked){hidShowInv.setValue('1')}else{hidShowInv.setValue('0')};CompanyX.ShowInv();" />
                                                        </Listeners>
                                                    </ext:Checkbox>
                                                </td>
                                        <td width="348" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px; padding-top:4px;"
                                            class="font_11bold_1542af">
                                            <nobr>Lot#&nbsp;<label id="txtLotNo" runat="server"></label>&nbsp;&nbsp;&nbsp;Master#&nbsp;<label id="txtMawb" runat="server"></label>  </nobr>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table style="margin-top: 10px; width: 100%">
                <tr>
                    <td>
                        <div runat="server" id="txtcontent">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <ext:Store runat="server" ID="StoreCurrInvoice">
            <Reader>
                <ext:JsonReader IDProperty="code">
                    <Fields>
                        <ext:RecordField Name="code">
                        </ext:RecordField>
                        <ext:RecordField Name="foreign">
                        </ext:RecordField>
                        <ext:RecordField Name="local">
                        </ext:RecordField>
                        <ext:RecordField Name="rate">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <div id="win_close" style="background-color: Transparent; padding: 5px 15px; display: none;
            position: absolute; z-index: 2; top: 0px; left: 0px;">
            <img id="win_close_invoice" src="../../images/btn_close.png" style="position: absolute;
                right: 0; top: 0; width: 33px; height: 33px; cursor: pointer;" />
            <div id="NewInvoice" style="width: 320px; margin-top: 15px; padding-bottom: 10px;
                background: #fff; border: outset 2px #fff; padding: 10px;">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tab_Invoice">
                    <tr>
                        <td colspan="2" style="background-image: url(/images/bg_line_3.jpg); height: 27px;
                            border: solid 1px #8DB2E3; text-indent: 10px;" class="font_11bold_1542af">
                            New Invoice
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 15px;">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-top: 2px; padding-left: 40px">
                            Company
                        </td>
                        <td style="width: 210px;">
                            <uc1:Autocomplete ID="txtCompany" runat="server" isAlign="false" TabIndex="45" query="option=CompanyList"
                                Width="100" clsClass="text_82px" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                winWidth="800" winHeight="800" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 40px">
                            Currency
                        </td>
                        <td>
                            <ext:ComboBox ID="cmbCurrency" runat="server" Cls="select_65" StoreID="StoreCurrInvoice"
                                TabIndex="45" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                Width="127" TriggerAction="All" TypeAhead="true" SelectOnFocus="true">
                                <Listeners>
                                    <Select Handler="#{radForeign}.setValue(record.data.foreign); #{radLocal}.setValue(record.data.local)" />
                                </Listeners>
                            </ext:ComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 8px;">
                        </td>
                    </tr>
                    <%if (Convert.ToBoolean(DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[26]))
                      { %>
                    <tr>
                        <td>
                        </td>
                        <td style="vertical-align: middle; line-height: 25px;">
                            <input type="checkbox" id="chkChina" tabindex="45" style="vertical-align: middle;
                                margin-right: 5px;" />
                            Show Chinese
                        </td>
                    </tr>
                    <%} %>
                    <tr style="display: none">
                        <td>
                        </td>
                        <td>
                            <ext:RadioGroup ID="rdNewInvoice" runat="server" SItemCls="x-check-group-base" Width="160px"
                                ReadOnly="true" Enabled="false" TabIndex="31">
                                <Items>
                                    <ext:Radio runat="server" BoxLabel="Foreign" ID="radForeign">
                                    </ext:Radio>
                                    <ext:Radio runat="server" BoxLabel="Local" ID="radLocal">
                                    </ext:Radio>
                                </Items>
                            </ext:RadioGroup>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" value="" id="hid_seed" />
                        </td>
                        <td>
                            <input onclick="NewInvoice('<%=Request["sys"] %>','txtCompany',cmbCurrency,StoreCurrInvoice);"
                                type="button" style="background-image: url(../../images/btn_save_01.jpg); border: 0px;
                                margin-bottom: 12px; width: 82px; height: 22px; cursor: pointer" class="btn_text"
                                tabindex="45" value="New Invoice" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="div_sheet" style="position: absolute; z-index: 3; top: 100px; left: 250px;
            background-color: #fff; padding: 15px; display: none; border: outset 2px #ddd">
            <img id="win_close_sheet" src="../../images/btn_close.png" style="position: absolute;
                right: -20px; top: -20px; width: 33px; height: 33px; cursor: pointer;" />
            <uc2:UserSheet ID="UserSheet1" runat="server" />
        </div>
    </form>
</body>
</html>
<script language="javascript" src="../../common/ylQuery/SetWindow.js" type="text/javascript"></script>
