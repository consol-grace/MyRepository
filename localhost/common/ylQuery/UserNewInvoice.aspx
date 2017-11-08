<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserNewInvoice.aspx.cs" Inherits="common_ylQuery_UserNewInvoice" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../UIControls/Autocomplete.ascx" TagName="Autocomplete" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="/css/style.css" rel="stylesheet" type="text/css" />
     <script src="../myplugin/jquery-1.4.1.js" type="text/javascript"></script>
<script src="UserNewInvoice.js" type="text/javascript"></script>
     <script src="../UIControls/CompanyDrpList.js" type="text/javascript"></script>
</head>

<body>
    <form id="form1" runat="server">
      <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div>
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
    <div id="win_close" style="background-color: Transparent; padding: 5px 15px;
    position: absolute; z-index: 9005; top: 200px; left:500px;">
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
                   <%-- <input type="hidden" value="" id="hid_seed" />--%>
                </td>
                <td>
                    <input onclick="OpenInvoice()" type="button"
                        style="background-image: url(../../images/btn_save_01.jpg); border: 0px; margin-bottom: 12px; 
                        width: 82px; height: 22px; cursor: pointer" class="btn_text" tabindex="45" value="New Invoice1111" id ="btnIndexNew" />
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="win_show" style="position: absolute; top: 0;left: 0;width: 100%;height: 100%; z-index:9004;
background: #000;filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5;"></div>
    </div>
    </form>
</body>
</html>
