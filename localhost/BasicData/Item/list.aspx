<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <script src="../AjaxServer/CheckCode.js" type="text/javascript"></script>
    <script type="text/javascript">
        function TextFocus() {
            Ext.get("txtCode").focus();
        }
        function Blur_Click() {
            Ext.get("txtCode").focus();
        }
        function input(value) {
            return "<input type='text' value='" + value + "' readonly='readonly' onfocus=this.blur();>";
        }

       
    </script>
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <ext:XScript ID="XScript1" runat="server">
    <script type="text/javascript">
            var applyFilter = function (field) {
                var store = #{GridPanel1}.getStore();
                store.suspendEvents();
                store.filterBy(getRecordFilter());                                
                store.resumeEvents();
                #{GridPanel1}.getView().refresh(false);
            }
             
            var clearFilter = function () {
                #{CodeFilter}.reset();
                #{ShortFilter}.reset();
                #{DescriptionFilter}.reset();
                #{Description_CNFilter}.reset();
                #{FUnitFilter}.reset();
                #{FvaluesFilter}.reset();
                #{FRoundFilter}.reset();
                #{LvaluesFilter}.reset();
                #{LRoundFilter}.reset();
                #{StoreDomestic}.clearFilter();
            }
           
            var filterString = function (value, dataIndex, record) {
                var val = record.get(dataIndex);
                
                if (typeof val != "string") {
                    return value.length == 0;
                }
                
                return val.toLowerCase().indexOf(value.toLowerCase()) > -1;
            };

            var getRecordFilter = function () {
                var f = [];
 
                f.push({
                    filter: function (record) {                         
                        return filterString(#{CodeFilter}.getValue(), "itm_Code", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{ShortFilter}.getValue(), "itm_Short", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{DescriptionFilter}.getValue(), "itm_Description", record);
                    }
                });

                
                f.push({
                    filter: function (record) {                         
                        return filterString(#{Description_CNFilter}.getValue(), "itm_Description_CN", record);
                    }
                });
                  
                f.push({
                    filter: function (record) {                         
                        return filterString(#{FUnitFilter}.getValue(), "itm_FUnit", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{FvaluesFilter}.getValue(), "Fvalues", record);
                    }
                });
               

                f.push({
                    filter: function (record) {                         
                        return filterString(#{FRoundFilter}.getValue(), "itm_FRound", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{LvaluesFilter}.getValue(), "Lvalues", record);
                    }
                });

                f.push({
                    filter: function (record) {                         
                        return filterString(#{LRoundFilter}.getValue(), "itm_LRound", record);
                    }
                });
                var len = f.length;
                 
                return function (record) {
                    for (var i = 0; i < len; i++) {
                        if (!f[i].filter(record)) {
                            return false;
                        }
                    }
                    return true;
                };
            };
    </script>
    </ext:XScript>
    <style type="text/css">
        #GridPanel1 .x-grid3-row input
        {
            border: 0;
            padding: 0;
            margin: 0;
            width: 100%;
            background-color: Transparent;
            font-family: Verdana, Arial, Helvetica, sans-serif !important;
            font-size: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server">
    </ext:ResourceManager>
    <ext:Store ID="storeCaclby" runat="server">
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
    <div id="location_div01" style="padding-bottom: 30px;">
        <table border="0" cellpadding="0" cellspacing="0" class="table_25left">
            <tr>
                <td colspan="3" style="padding-bottom: 2px">
                    <div id="countryControl">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td valign="top">
                                    <table border="0'" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 10px">
                                                Code<span style="padding: 0 5px 0 5px ;" class="font_red">*</span>
                                            </td>
                                            <td>
                                                <ext:TextField AllowBlank="false" ID="txtCode" runat="server" Cls="text_70px" TabIndex="1"
                                                    EnableKeyEvents="true" Width="95px" MaxLength="6" BlankText="Code can't be empty" AutoFocus="true">
                                                    <Listeners>
                                                        <Blur Handler="checkCode('ITEM','txtCode',#{txtRowID}.getValue())" />
                                                        <KeyUp Handler="removeClass('txtCode')" />
                                                        <KeyPress Handler="CheckCode(event,this);" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                            <td class="font_11bold" style="padding-left: 10px">
                                                Short<span style="padding: 0 5px 0 5px ;" class="font_red">*</span>
                                            </td>
                                            <td>
                                                <ext:TextField ID="txtShort" runat="server" Cls="text_70px" Width="95px" TabIndex="2"
                                                    MaxLength="8" AllowBlank="false" BlankText="Short can't be empty">
                                                </ext:TextField>
                                            </td>
                                            <td class="font_11bold" style="padding-left: 10px;">
                                                Description<span class="font_red" style="padding: 0 5px 0 5px ;">*</span>
                                            </td>
                                            <td>
                                                <ext:TextField ID="txtDes" runat="server" Cls="text_160px" Width="200" TabIndex="3"
                                                    AllowBlank="false" EnableKeyEvents="true" MaxLength="70" BlankText="Description can't be empty">
                                                    <Listeners>
                                                        <Blur Handler="checkCode('ITEMDESC','txtDes',#{txtRowID}.getValue())" />
                                                        <KeyUp Handler="removeClass('txtDes')" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100px" style="padding-left: 10px;
                                                    padding-right: 10px">
                                                    <tr>
                                                        <td>
                                                            Description CN
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <ext:TextField ID="txtDesCN" runat="server" Cls="text_160px" Width="200px" TabIndex="3"
                                                    MaxLength="70">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" style="padding: 1px 0px 2px 0px" align="right">
                                </td>
                            </tr>
                        </table>
                        <div style="width: 937px; margin-top: 10px;">
                            <div style="float: left; margin-top: 2px">
                                <ext:CheckboxGroup ID="tblChkGroup" runat="server">
                                </ext:CheckboxGroup>
                            </div>
                            <table style="float: right;" align="right" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="vertical-align: bottom; padding-left: 10px;" colspan="9">
                                        <table cellpadding="0" cellspacing="0" border="0" align="right">
                                            <tr>
                                                <td valign="top" align="right" style="padding-top: 1px;">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <ext:Checkbox ID="chbActive" runat="server" Width="25" TabIndex="5">
                                                                </ext:Checkbox>
                                                            </td>
                                                            <td style="padding-right: 7px">
                                                                Active
                                                            </td>
                                                            <td width="41" style="padding-right: 2px">
                                                                <ext:Button ID="btnNext" runat="server" Cls="Submit_70px" Text="Next" Width="70">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnNext_Click">
                                                                            <EventMask ShowMask="true" Msg="Saving..." />
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                            <td width="46" style="padding-right: 2px">
                                                                <ext:Button ID="btnCancel" runat="server" Cls="Submit_70px" Text="Cancel" Width="70">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnCancel_Click">
                                                                            <EventMask ShowMask="true" Msg="Loading..." />
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                            <td width="46">
                                                                <ext:Button ID="btnSave" runat="server" Cls="Submit_70px" Text="Save" Width="70">
                                                                    <Listeners>
                                                                        <Click Handler="return (Validata('txtCode') && Validata('txtDes'));" />
                                                                    </Listeners>
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnSave_Click">
                                                                            <EventMask ShowMask="true" Msg="Saving..." />
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:Store runat="server" ID="StoreUnit">
                                            <Reader>
                                                <ext:JsonReader>
                                                    <Fields>
                                                        <ext:RecordField Name="text" />
                                                        <ext:RecordField Name="value" />
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="10px"></td>
            </tr>
            <tr>
                <td colspan="2" valign="top" style="padding-bottom: 2px; padding-top: 2px;">
                    <table border="0" cellpadding="0" cellspacing="1" bgcolor="#B1CEED">
                        <tr>
                            <td width="60" bgcolor="#FFFFFF">
                                <table width="75" cellpadding="4">
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 14px">
                                            Foreign
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="4" bgcolor="#FFFFFF" style="padding-bottom: 5px; padding-left: 5px;
                                padding-right: 5px; padding-top: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table width="51" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Currency
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <ext:Store runat="server" ID="StoreForeign">
                                                <Reader>
                                                    <ext:JsonReader>
                                                        <Fields>
                                                            <ext:RecordField Name="text" />
                                                            <ext:RecordField Name="value" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                            <ext:ComboBox ID="cmbFCurrency" TabIndex="6" runat="server" StoreID="StoreForeign"
                                                DisplayField="value" ValueField="value" Mode="Local" Width="60" Cls="select">
                                            </ext:ComboBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td width="55" style="padding-left: 5px">
                                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Min
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField ID="txtFMain" runat="server" Cls="text_70px" Width="60" TabIndex="7"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtFAmount}.setValue('')}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td width="65" style="padding-left: 5px">
                                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Rate
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField ID="txtFRate" runat="server" Cls="text_70px" Width="60" TabIndex="8"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtFAmount}.setValue('')}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Amount
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 11px">
                                            <ext:NumberField ID="txtFAmount" runat="server" Cls="text_70px" Width="80" TabIndex="9"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtFRate}.setValue('');#{txtFMain}.setValue('');}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Unit
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <ext:ComboBox ID="cmbFUnit" TabIndex="10" runat="server" StoreID="StoreUnit" DisplayField="value"
                                                ValueField="value" Mode="Local" Width="60" Cls="select" ListWidth="150" ItemSelector="tr.list-item">
                                            </ext:ComboBox>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Calc. By
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:ComboBox ID="cmbFby" runat="server" TabIndex="11" Width="60" StoreID="storeCaclby"
                                                Mode="Local" DisplayField="value" ValueField="value" Cls="select">
                                            </ext:ComboBox>
                                        </td>
                                        <td width="65" style="padding-left: 5px">
                                            <table width="68" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Round To
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField AllowDecimals="false" ID="txtFRound" runat="server" Cls="text_70px"
                                                StyleSpec="text-align:right" Width="60" TabIndex="12">
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table border="0" cellpadding="0" cellspacing="0" width="70px">
                                                <tr>
                                                    <td>
                                                        <ext:Checkbox ID="chbFUp" runat="server" TabIndex="13">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked==true){#{chbFDown}.setValue(false)}" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td>
                                                        Mark Up
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 10px">
                                            <table width="85" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <ext:Checkbox ID="chbFDown" runat="server" TabIndex="14">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked==true){#{chbFUp}.setValue(false)}" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td style="padding-left: 1px; font-size: 9px;">
                                                        Mark Down
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#FFFFFF">
                                <table width="60" cellpadding="4">
                                    <tr>
                                        <td align="left" style="padding-left: 14px" class="font_11bold">
                                            Local
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="4" bgcolor="#FFFFFF" style="padding-bottom: 5px; padding-left: 5px;
                                padding-right: 5px; padding-top: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="30">
                                            <table width="51" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Currency
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="font_11px_gray" style="">
                                                        <ext:Store runat="server" ID="StoreLocal">
                                                            <Reader>
                                                                <ext:JsonReader>
                                                                    <Fields>
                                                                        <ext:RecordField Name="text" />
                                                                        <ext:RecordField Name="value" />
                                                                    </Fields>
                                                                </ext:JsonReader>
                                                            </Reader>
                                                        </ext:Store>
                                                        <ext:ComboBox ID="labCurrency" TabIndex="16" runat="server" StoreID="StoreLocal"
                                                            DisplayField="value" ValueField="value" Mode="Local" Width="60" Cls="select">
                                                        </ext:ComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Min
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField ID="txtLMin" runat="server" Cls="text_70px" Width="60" TabIndex="16"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtLAmount}.setValue('')}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td width="65" style="padding-left: 5px">
                                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Rate
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField ID="txtLRate" runat="server" Cls="text_70px" Width="60" TabIndex="17"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtLAmount}.setValue('')}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Amount
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 11px">
                                            <ext:NumberField ID="txtLAmount" runat="server" Cls="text_70px" Width="80" TabIndex="18"
                                                StyleSpec="text-align:right" DecimalPrecision="3">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''||this.getValue()=='0'){#{txtLRate}.setValue('');#{txtLMin}.setValue('')}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Unit
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            <ext:ComboBox ID="cmbLUnit" TabIndex="19" runat="server" StoreID="StoreUnit" DisplayField="value"
                                                ValueField="value" Mode="Local" Width="60" Cls="select" ListWidth="150" ItemSelector="tr.list-item">
                                            </ext:ComboBox>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table width="55" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Calc. By
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:ComboBox ID="cmbLby" runat="server" TabIndex="20" Width="60" StoreID="storeCaclby"
                                                Editable="true" DisplayField="value" ValueField="value" Cls="select" Mode="Local">
                                            </ext:ComboBox>
                                        </td>
                                        <td width="65" style="padding-left: 5px">
                                            <table width="68" border="0" cellspacing="0" cellpadding="0" style="height: 25px">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Round To
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <ext:NumberField ID="txtLRound" Cls="text_70px" Width="60" runat="server" TabIndex="21"
                                                StyleSpec="text-align:right" AllowDecimals="false">
                                                <%--  <Listeners><Blur  Fn="Blur_Click" /></Listeners>--%>
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-left: 5px">
                                            <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <ext:Checkbox ID="chbLUp" runat="server" TabIndex="22">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked==true){#{chbLDown}.setValue(false)}" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td>
                                                        Mark Up
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 10px">
                                            <table width="85" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <ext:Checkbox ID="chbLDown" runat="server" TabIndex="23">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked==true){#{chbLUp}.setValue(false)}" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td style="padding-left: 1px; font-size: 9px;">
                                                        Mark Down
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
                <td valign="top" style="padding-left: 5px;">
                    <table border="0" cellpadding="0" cellspacing="1">
                        <tr>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="1" bgcolor="#B1CEED">
                        <tr>
                            <td colspan="4" bgcolor="#FFFFFF" style="padding-bottom: 5px; padding-left: 5px;
                                padding-right: 5px; padding-top: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="30">
                                            <table width="94" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Foreign Values
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table width="200" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="padding-left: 2px" class="font_11px_gray">
                                                        <ext:Label ID="labFvalues" runat="server">
                                                        </ext:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold" style="font-size: 9px;">
                                                        Round to
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 2px" class="font_11px_gray">
                                            <ext:Label ID="labFRound" runat="server">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" bgcolor="#FFFFFF" style="padding-bottom: 5px; padding-left: 5px;
                                padding-right: 5px; padding-top: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="90">
                                            <table width="90" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold">
                                                        Local Values
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="200" class="font_11px_gray" style="padding-left: 2px">
                                            <ext:Label ID="labLValues" runat="server">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="50" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="font_11bold" style="font-size: 9px;">
                                                        Round to
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 2px" class="font_11px_gray">
                                            <ext:Label ID="labLRound" runat="server">
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
        <table border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 8px 0;">
            <tr>
                <td height="3">
                </td>
            </tr>
            <tr>
                <td id="GridView">
                    <ext:Store ID="StoreDomestic" runat="server" AutoLoad="true">
                        <Reader>
                            <ext:JsonReader IDProperty="itm_ROWID">
                                <Fields>
                                    <ext:RecordField Name="itm_ROWID" Type="Int">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_Code" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_Short" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_Description" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_Description_CN" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_FUnit" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_Active" Type="Boolean">
                                    </ext:RecordField>
                                    <ext:RecordField Name="Fvalues" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_FRound" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="Lvalues" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="itm_LRound" Type="String">
                                    </ext:RecordField>
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                    </ext:Store>
                    <ext:GridPanel ID="GridPanel1" runat="server" Height="260" StoreID="StoreDomestic"
                        Width="937px" TrackMouseOver="true" StripeRows="true">
                        <ColumnModel ID="ctl107">
                            <Columns>
                                <ext:RowNumbererColumn Header="No." Width="30">
                                </ext:RowNumbererColumn>
                                <ext:Column Header="Code" DataIndex="itm_Code" Width="50">
                                </ext:Column>
                                <ext:Column Header="Short" DataIndex="itm_Short" Width="70">
                                </ext:Column>
                                <ext:Column Header="Description" DataIndex="itm_Description" Width="120" Align="Left">
                                    <Renderer Fn="input" />
                                </ext:Column>
                                <ext:Column Header="Description_CN" DataIndex="itm_Description_CN" Width="120" Align="Left">
                                    <Renderer Fn="input" />
                                </ext:Column>
                                <ext:Column Header="Unit" DataIndex="itm_FUnit" Width="38" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Foreign " DataIndex="Fvalues" Width="159" Align="Left">
                                    <Renderer Fn="input" />
                                </ext:Column>
                                <ext:Column Header="Round" DataIndex="itm_FRound" Width="64">
                                </ext:Column>
                                <ext:Column Header="Local" DataIndex="Lvalues" Width="159" Align="Left">
                                    <Renderer Fn="input" />
                                </ext:Column>
                                <ext:Column Header="Round" DataIndex="itm_LRound" Width="58">
                                </ext:Column>
                                <ext:CheckColumn Header="Active" DataIndex="itm_Active" Width="47">
                                </ext:CheckColumn>
                            </Columns>
                        </ColumnModel>
                        <DirectEvents>
                        </DirectEvents>
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                                <DirectEvents>
                                    <RowSelect OnEvent="Row_Click">
                                        <ExtraParams>
                                            <%-- <ext:Parameter Name="RowID" Value="this.getSelected().id" Mode="Raw">
                                            </ext:Parameter>--%>
                                            <%--这样会导致用户没有点击行时得到的永远都是第一行的ID--%>
                                            <ext:Parameter Name="itm_ROWID" Value="record.data.itm_ROWID" Mode="Raw" />
                                        </ExtraParams>
                                        <EventMask Msg="Loading..." ShowMask="true" />
                                    </RowSelect>
                                </DirectEvents>
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <View>
                            <ext:GridView ID="GridView1" runat="server">
                                <HeaderRows>
                                    <ext:HeaderRow>
                                        <Columns>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="CodeFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="ShortFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="DescriptionFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="Description_CNFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="FUnitFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="FvaluesFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="FRoundFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="LvaluesFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn Cls="x-small-editor">
                                                <Component>
                                                    <ext:TextField ID="LRoundFilter" runat="server" EnableKeyEvents="true">
                                                        <Listeners>
                                                            <KeyUp Handler="applyFilter(this);" Buffer="250" />
                                                        </Listeners>
                                                    </ext:TextField>
                                                </Component>
                                            </ext:HeaderColumn>
                                            <ext:HeaderColumn>
                                                <Component>
                                                    <ext:Button ID="ClearFilterButton" runat="server" Icon="Cancel">
                                                        <Listeners>
                                                            <Click Handler="clearFilter();" />
                                                        </Listeners>
                                                    </ext:Button>
                                                </Component>
                                            </ext:HeaderColumn>
                                        </Columns>
                                    </ext:HeaderRow>
                                </HeaderRows>
                            </ext:GridView>
                        </View>
                        <LoadMask Msg=" Loading ..." ShowMask="true" />
                    </ext:GridPanel>
                    <ext:Hidden ID="txtRowID" runat="server" Text='0'>
                    </ext:Hidden>
                    <ext:Hidden ID="txtlab" runat="server">
                    </ext:Hidden>
                </td>
            </tr>
        </table>
    </div>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    </form>
</body>
</html>
<script type="text/javascript">
    Ext.onReady(function () {
        var dept = "<%=userDept %>";
        var sys = "<%=stationSys %>";
        var isServer = "<%=isServer %>";

        if ((dept == 'OP' || dept == 'ACCOUNT' || sys == 'N') && isServer == "Y") {
            DisableCombox("cmbFCurrency");
            DisableCombox("cmbFUnit");
            DisableCombox("cmbFby");
            DisableCombox("labCurrency");
            DisableCombox("cmbLUnit");
            DisableCombox("cmbLby");
        }

        SetWinSize();
    });
</script>
