<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invoice.aspx.cs" Inherits="AirImport_AIShipmentJobList_invoice" %>

<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
    <%@ Register Src="../../common/UIControls/Autocomplete.ascx" TagName="Autocomplete"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoice</title> 
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    <script src="AjaxServer/gridInvoice.js" type="text/javascript"></script>
    <script type="text/javascript">

        function res() {
            if (Request("M") != null && Request("M") != "" && Request("M") != undefined)
                return "Add";
            else if (Request("H") != null && Request("H") != "" && Request("H") != undefined)
                return "Add";
            else
                return "";

        }
        var i = 0;
        var make = 0;   

        var deleteRows = function(grid) {
        Ext.Msg.confirm('Delete Rows', 'Are you sure?', function(btn) {
            
                if (btn == 'yes') {
                    CompanyX.Delete(Ext.get('inv_RowID').getValue(true));
                    grid.deleteSelected();
                }
                grid.view.focusEl.focus();
            })
        }

        var EditCategoryID = function(e, value) {
            if (value == "" && value == "0") {
                txtAmount.setValue("");
            } else {
                txtAmount.setValue(value);
            }
            //alert(value);
        }

        function MakeInvoiceDetail() {
            //            var count = gridList.store.getTotalCount();
            //            if (count == 0) {
            if ($("#hidisLock").val() == "false") {
                Ext.Msg.confirm('Make InvoiceDetail', 'Are you sure to retrieve data?', function (btn) {
                    if (btn == 'yes') {
                        make = 1;
                        Ext.getCmp('btnOk').fireEvent('click', this);
                        setTimeout(function () { CompanyX.MakeInvoiceDetail(); }, 2000);
                    }
                });
            }
            //}
        }

        var showTip = function() {
            var rowIndex = gridList.view.findRowIndex(this.triggerElement);
            var record = gridList.getStore().getAt(rowIndex);
            var amount = record.data.Amount;
            var qty = record.data.Qty;
            var rate = record.data.Rate;
            var min = record.data.Min;
            var exrate = record.data.Ex;
            var percent = record.data.Percent;
            var total = Number(record.data.Total).toFixed(2);
            var tax = record.data.Tax;
            var sys = Request("sys");
            if (sys == "AI" || sys == "AE" || sys == "AT") {
                sys = "A";
            }
            var str = "";
            if (amount == "") {
                var minFlag = "N";
                if (min != "") {
                    if (Number(min) > Number(qty) * Number(rate)) {
                        minFlag = "Y";
                    }
                }
                if (hidStat.getValue() == "USG/SIN") {
                    if (minFlag == "Y") {
                        str += "&nbsp;&nbsp;Total<br>=Net Total+Tax Total<br>=NetTotal+NetTotal*Tax<br>=Min*ExRate*(1+Tax)<br>=" + min +"*" +exrate+ "*(1+" + tax + "%)<br>=" + total;
                    }
                    else {
                        if (sys == "A") {
                            str += "&nbsp;&nbsp;Total<br>=Net Total+Tax Total<br>=NetTotal+NetTotal*Tax<br>=CWT*Rate*ExRate*(1+Tax)<br>=" + qty + "*" + rate +"*" +exrate+ "*(1+" + tax + "%)<br>=" + total;
                        }
                        else {
                            str += "&nbsp;&nbsp;Total<br>=Net Total+Tax Total<br>=NetTotal+NetTotal*Tax<br>=Qty*Rate*ExRate*Percent*(1+Tax)<br>=" + qty + "*" + rate + "*" + exrate + "*" + percent + "%*(1+" + tax + "%)<br>=" + total;
                        }
                    }
                }
                else {
                    if (minFlag == "Y") {
                        str += "&nbsp;&nbsp;Total<br>=" + "Min*ExRate<br>="+min+"*"+exrate+"<br>=" + total;
                    }
                    else {
                        if (sys == "A") {
                            str += "&nbsp;&nbsp;Total<br>=" + "CWT*Rate*ExRate<br>=" + qty + "*" + rate + "*" + exrate + "<br>=" + total;
                        }
                        else {
                            str += "&nbsp;&nbsp;Total<br>=" + "Qty*Rate*ExRate*Percent<br>=" + qty + "*" + rate + "*" + exrate + "*" + percent + "%<br>=" + total;
                        }
                    }
                }
            }
            else {
                if (hidStat.getValue() == "USG/SIN") {
                    if (sys == "A") {
                        str += "&nbsp;&nbsp;Total<br>=Net Total+Tax Total<br>=NetTotal+NetTotal*Tax<br>=Amount*ExRate*(1+Tax)<br>=" + amount + "*" + exrate + "*(1+" + tax + "%)<br>=" + total;
                    } else {
                        str += "&nbsp;&nbsp;Total<br>=Net Total+Tax Total<br>=NetTotal+NetTotal*Tax<br>=Amount*ExRate*Percent*(1+Tax)<br>=" + amount + "*" + exrate + "*" + percent + "%*(1+" + tax + "%)<br>=" + total;
                    }
                }
                else {
                    if (sys == "A") {
                        str += "&nbsp;&nbsp;Total<br>=" + "Amount*ExRate<br>=" + amount + "*" + exrate + "<br>=" + total;
                    }
                    else {
                        str += "&nbsp;&nbsp;Total<br>=" + "Amount*ExRate*Percent<br>=" + amount + "*" + exrate + "*" + percent + "%<br>=" + total;
                    }
                }
            }
            this.body.dom.innerHTML = str;
        }
    </script>

    <style type="text/css">
        .style5
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
            width: 28px;
        }
        #td_lsit label
        {
            color: #777;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div_title" style="width: 100%; z-index: 100">

        <script type="text/javascript">         var company = "<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[12]%>"; var b = "<%=b%>";</script>

        <uc1:UserControlTop ID="UserControlTop1" runat="server" />
    </div>
    <div id="div_title" style="padding-left: 10px; margin-top: 80px;">
        <table border="0" cellspacing="0" cellpadding="0" style="width: 983px">
            <tbody>
                <tr>
                    <td width="1000" class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                        <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle;"
                            alt="View" onclick="createFrom(Request('sys')+'Invoice'+res());" />
                        &nbsp;
                        <%=string.IsNullOrEmpty(Request["sys"])?"AI":Request["sys"].ToUpper()%>- Invoice
                        / Credit Note&nbsp;&nbsp;
                        <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;" />&nbsp;&nbsp;
                        <%--<span class="font_11red"> <ext:Label ID="labTransfer" runat="server" Text="Transfered" Hidden="true">
                                                </ext:Label></span>--%><img src="../../images/Transfered.png" runat="server" id="imgTransfer" style="vertical-align: middle;"  visible="false"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
     <ext:ToolTip 
            ID="tooltip" 
            runat="server" 
            Target="={#{gridList}.getView().mainBody}"
            Delegate=".x-grid3-row"
            DismissDelay="20000"
            TrackMouse="true">
            <Listeners>
                <Show Fn="showTip" />
            </Listeners>
        </ext:ToolTip>     
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
          <ext:Hidden ID="hidisLock" runat="server"  Text="false"></ext:Hidden>
    <ext:Store runat="server" ID="StoreItem" OnRefreshData="StoreItem_OnRefreshData">
        <Reader>
            <ext:JsonReader IDProperty="value">
                <Fields>
                    <ext:RecordField Name="itm_ROWID">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="unit">
                    </ext:RecordField>
                    <ext:RecordField Name="CalcQty">
                    </ext:RecordField>
                    <ext:RecordField Name="Min">
                    </ext:RecordField>
                    <ext:RecordField Name="Rate">
                    </ext:RecordField>
                    <ext:RecordField Name="Amount">
                    </ext:RecordField>
                    <ext:RecordField Name="Round">
                    </ext:RecordField>
                    <ext:RecordField Name="MarkUp">
                    </ext:RecordField>
                    <ext:RecordField Name="MarkDown">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store ID="StorecalcQty" runat="server">
        <Reader>
            <ext:JsonReader IDProperty="text">
                <Fields>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="unit">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreUnit" OnRefreshData="StoreUnit_OnRefreshData">
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
    <ext:Store runat="server" ID="StoreCurrInvoice" OnRefreshData="StoreCurrInvoice_OnRefreshData">
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
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidIsVoid" runat="server" Text="">
     </ext:Hidden>
     <ext:Hidden ID="hidParentActive" runat="server" Text="">
     </ext:Hidden>
    <div id="invoice_div" style="margin-top: 105px">
        <table cellpadding="0" cellspacing="0" border="0" style="padding-top: 10px">
            <tr>
                <td valign="top">
                    <table width="360" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                        <tbody>
                            <tr>
                                <td style="padding-left: 8px" class="font_11bold_1542af">
                                    Basic Information
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table width="320" cellpadding="1" style="padding-top: 8px">
                        <tbody>
                            <tr>
                                <td>
                                    <table width="50" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td align="left" class="font_11bold" style="padding-left: 7px">
                                                    DN/CN#
                                                </td>
                                                <td align="right" class="font_11bold">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td width="15" class="font_11px_gray">
                                    <ext:Label ID="labDNNO" runat="server">
                                    </ext:Label>
                                </td>
                                <td width="212" colspan="2" align="left" valign="top" class="font_11red" rowspan="3">
                                    <table cellpadding="0" cellspacing="0" style="border: 1px solid #8db2e3; background: #f4f7fc;
                                        height: 45px; padding-bottom: 2px; padding-left: 2px; padding-right: 2px; padding-top: 2px;">
                                        <tr>
                                            <td width="212" colspan="2" align="center" class="font_11red" style="display: none">
                                                Transfered
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="212" colspan="2" align="center" class="font_11red">
                                                <ext:Label ID="labLocal" runat="server" Hidden="true">
                                                </ext:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="212" colspan="2" align="center" class="font_11red">
                                                <ext:Label ID="labCredit" runat="server" Text="Invoice">
                                                </ext:Label>
                                                <ext:Hidden ID="labCredit1" runat="server">
                                                </ext:Hidden>
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr><td colspan="2"  style="height:12px"></td></tr>
                            <tr>
                                <td valign="top" >
                                    <table border="0" cellpadding="0" cellspacing="0">
                                    
                                            <tr>
                                                <td align="left" class="font_11bold" style="padding-left: 7px" colspan="2" >
                                                    Lot No.#
                                                </td>
                                            </tr>
                                      
                                    </table>
                                </td>
                                <td valign="top">
                                    <table width="100" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="font_11px_gray">
                                                    <ext:Label ID="labLotNo" runat="server">
                                                    </ext:Label>
                                                    <br /> <ext:Label ID="labCurrentLotno" runat="server"> </ext:Label>
                                                </td>
                                            </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td style="height:2px"></td></tr>
                            <tr>
                                <td>
                                    <table width="60" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="left" class="font_11bold" style="padding-left: 7px; padding-top:11px;" colspan="2">
                                                    <ext:Label ID="Mawblab" runat="server">
                                                    </ext:Label>
                                                </td>
                                            </tr>
                                    </table>
                                </td>
                                <td class="font_11px_gray" valign="top" style="padding-top:13px">
                                    <ext:Label ID="labMawb" runat="server">
                                    </ext:Label>
                                </td>
                                <td style="padding-top:7px">
                                    <table width="85px" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="left" class="font_11bold">Invoice Date</td>
                                                <td align="right" class="font_red">*</td>
                                            </tr>
                                 
                                    </table>
                                </td>
                                <td style="padding-top:10px">
                                    <ext:DateField ID="txtInvoiceDate" runat="server" Cls="text" Width="88px"  TabIndex="0" Format="dd/m/Y" Disabled="true">
                                    </ext:DateField>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top:17px">
                                    <table border="0" cellpadding="0" cellspacing="0" style="height:30px">
                                        <tbody>
                                            <tr>
                                                <td align="left" class="font_11bold" style="padding-left: 7px;" valign="middle">
                                                    <ext:Label ID="Hawblab" runat="server">
                                                    </ext:Label>
                                                </td>
                                                <td align="right" class="font_11bold">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td class="font_11px_gray" style="padding-top:16px">
                                    <ext:Label ID="labHawb" runat="server">
                                    </ext:Label>
                                </td>
                                <td style="padding-top:16px">
                                    <table width="85px" border="0" cellpadding="0" cellspacing="0"><tr><td align="left" class="font_11bold">Currency</td></tr></table>
                                </td>
                                <td class="font_11px_gray" style="padding-top:16px">
                                    <ext:Label ID="labCurrency1" runat="server" Hidden="true">
                                    </ext:Label>
                                    <uc1:UserComboBox runat="server" DisplayField="code" StoreID="StoreCurrInvoice" ID="labCurrency"
                                        ListWidth="150" Width="67" TabIndex="0" ValueField="text" Handler="SelectCurrSum()"  
                                        winUrl="/BasicData/Currency/list.aspx" winTitle="Currency" winHeight="585" winWidth="653"
                                        clsClass="text_80px" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" height="1">
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top:7px">
                                    <table width="72" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td align="left" class="style5" style="padding-left: 7px">
                                                    <ext:Label ID="labBookShow" runat="server" Text="Book">
                                    </ext:Label>
                                                </td>
                                                <td align="right" class="font_11bold">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td class="font_11px_gray" style="padding-top:3px">
                                    <ext:Label ID="labBook" runat="server">
                                    </ext:Label>
                                </td>
                                <td valign="top" style="padding-top:4px">
                                    <table width="85px" border="0" cellpadding="0" cellspacing="0">                            
                                            <tr>
                                                <td align="left" class="font_11bold" colspan="2">
                                                    <div style="width: 20px; float: left; line-height: 22px;">
                                                    <ext:Label runat="server" ID="labEx">
                                                    </ext:Label></div>
                                                </td>    
                                                <td class="font_red" align="right" style="padding-bottom:3px;">*</td>                                         
                                            </tr>                                    
                                    </table>
                                </td>
                                <td style="padding-top:4px">
                                    <ext:NumberField ID="txtUSD" runat="server" Cls="text" DecimalPrecision="4" TabIndex="0"
                                        StyleSpec="text-align:right">
                                    </ext:NumberField>
                                </td>
                            </tr>
                            
                            <tr>
                                <td style="padding-top:4px">
                                    <table width="50" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td align="left" class="font_11bold" style="padding-left: 7px" colspan="2">
                                                    Sales
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td class="font_11px_gray"   style="padding-top:4px">
                                    <ext:Label ID="labSales" runat="server">
                                    </ext:Label>
                                </td>
                                <td  style="padding-top:4px">
                                    <table width="85px" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="left" class="font_11bold">Tax</td>
                                                <td align="right" class="font_red" style="padding-bottom:3px;">*</td>
                                            </tr>
                                    </table>
                                </td>
                                <td style="padding-top:2px"  style="padding-top:4px">
                                    <ext:NumberField ID="txtTax" runat="server" Cls="text" MaxLength="8" DecimalPrecision="1"
                                        StyleSpec="background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                        
                                    </ext:NumberField>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td valign="top" style="padding-left: 5px">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <table width="310" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                    <tbody>
                                        <tr>
                                            <td class="font_11bold_1542af" style="padding-left: 8px">
                                                Shipment Information
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="1" style="padding-top: 12px">
                                    <tbody>
                                        <tr>
                                            <td style="line-height:16px;" rowspan="2">
                                                <table width="80" border="0" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="left" class="font_11bold" style="padding-left: 0px; ">
                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr><td width="16px"> <ext:Checkbox ID="chkShipperShow" runat="server" StyleSpec="font-size:10px;" Checked="true">
                                                             <Listeners>
                                                            <Check Handler="if(hidAccount.getValue()=='ACCOUNT'){CompanyX.UpdateStatus();}"/>
                                                            </Listeners>
                                                              </ext:Checkbox></td><td align="left" valign="top"> <ext:Label ID="labShipperShow" runat="server" Text="Shipper">
                                                                </ext:Label></td></tr></table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="80" colspan="3" valign="top">
                                                <table width="100%"  border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="labShipperCode" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                           
                                            <td width="80" colspan="3" valign="top">
                                                <table width="100%"  border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:TextField ID="labShipperText" runat="server" Cls="text_160px" StyleSpec="margin:0px;padding:0px; width:210px; border:0px; background-image:none; color:#777"
                                                                    ReadOnly="true">
                                                                </ext:TextField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" rowspan="2">
                                                <table width="80" border="0" cellpadding="0" cellspacing="0" style="line-height:16px;">
                                                        <tr>
                                                            <td align="left" class="font_11bold" style="padding-left:0px" colspan="2">
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr><td width="16px"><ext:Checkbox  ID="chkConsigneeShow" runat="server" StyleSpec="font-size:10px;" Checked="true">
                                                             <Listeners>
                                                            <Check Handler="if(hidAccount.getValue()=='ACCOUNT'){CompanyX.UpdateStatus();}"/>
                                                            </Listeners>
                                                              </ext:Checkbox></td><td align="left" valign="top"><ext:Label ID="labConsigneeShow" runat="server" Text="Consignee">
                                                                </ext:Label></td></tr></table>
                                                            </td>
                                                        </tr>
                                                 
                                                </table>
                                            </td>
                                            <td>
                                                <table width="90"  border="0" cellpadding="0" cellspacing="1">
                                                        <tr>
                                                            <td class="font_11px_gray" colspan="3">
                                                                <ext:Label ID="labConsigneeCode" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                          
                                            <td width="80" colspan="3"  valign="top">
                                                <table width="100%" border="0" cellpadding="0" cellspacing="1" style="line-height:16px">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:TextField ID="labConsigneeText" runat="server" Cls="text_160px" StyleSpec="margin:0px;padding:0px; width:210px; border:0px; background-image:none; color:#777"
                                                                    ReadOnly="true">
                                                                </ext:TextField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top:2px">
                                                <table width="80" border="0" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="left" class="font_11bold" style="padding-left: 7px">
                                                                Carrier
                                                            </td>
                                                            <td align="right" class="font_11bold">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td colspan="3" style="padding-top:1px">
                                                <table width="90" height="13px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="txtCarrierCode" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="59">
                                                &nbsp;
                                            </td>
                                            <td width="80" colspan="3">
                                                <table width="100%" height="13px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:TextField ID="txtCarrierText" runat="server" Cls="text_160px" StyleSpec="margin:0px;padding:0px; width:210px; border:0px; background-image:none; color:#777"
                                                                    ReadOnly="true">
                                                                </ext:TextField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <table width="80" border="0" cellpadding="0" cellspacing="0"  style="height:35px" >
                                                    <tbody>
                                                        <tr>
                                                            <td align="left" class="font_11bold" style="padding-left: 7px;" valign="middle">
                                                                <ext:Label ID="labVorY" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                            <td class="font_11bold">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td colspan="3" valign="middle">
                                                <table width="200" height="30px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="labVessel" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="labvoyage" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top:7px">
                                                <table width="" border="0" cellpadding="0" cellspacing="0" style="line-height:16px">
                                                
                                                        <tr>
                                                            <td width="" align="left" class="font_11bold" style="padding-left: 7px">
                                                                Depart.
                                                            </td>
                                                            <td align="right" class="font_11bold">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                             
                                                </table>
                                            </td>
                                            <td  style="padding-top:8px">
                                                <table border="0" cellpadding="0" cellspacing="1" height="13px">
                                              
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                               <%-- <ext:Label ID="labDepart" runat="server">
                                                                </ext:Label>--%>
                                                                <ext:TextField ID="labDepart" runat="server" Cls="text_160px"  StyleSpec="margin:0px;padding:0px; width:90px; border:0px; background-image:none; color:#777"
                                                                    ReadOnly="true">
                                                                </ext:TextField>
                                                            </td>
                                                        </tr>
                                                 
                                                </table>
                                            </td>
                                            <td width="28" style="padding-top:7px">
                                                <table width="50" border="0" cellpadding="0" cellspacing="0">
                                            
                                                        <tr>
                                                            <td class="font_11bold" colspan="2">
                                                                <ext:Label ID="labETDShow" runat="server" Text="ETD">
                                                                </ext:Label>
                                                            </td>
                                                        
                                                        </tr>
                                        
                                                </table>
                                            </td>
                                            <td style="padding-top:7px">
                                                <table height="13px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="labETD" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top:6px">
                                                <table width="" border="0" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td width="" align="left" class="font_11bold" style="padding-left: 7px">
                                                                Dest.
                                                            </td>
                                                            <td align="right" class="font_11bold">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td style="padding-top:6px">
                                                <table height="13px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <%--<ext:Label ID="labDest" runat="server">
                                                                </ext:Label>--%>
                                                                  <ext:TextField ID="labDest" runat="server" Cls="text_160px"  StyleSpec="margin:0px;padding:0px; width:90px; border:0px; background-image:none; color:#777"
                                                                    ReadOnly="true"></ext:TextField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td style="padding-top:6px">
                                                <table width="30" border="0" cellpadding="0" cellspacing="0">
                                               
                                                        <tr>
                                                            <td class="font_11bold" colspan="2">
                                                                <ext:Label ID="labETAShow" runat="server" Text="ETA">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                          
                                                </table>
                                            </td>
                                            <td style="padding-top:6px">
                                                <table height="13px" border="0" cellpadding="0" cellspacing="1">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11px_gray">
                                                                <ext:Label ID="labETA" runat="server">
                                                                </ext:Label>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" height="10">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 2px">
                    <table width="303" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                        <tbody>
                            <td class="font_11bold_1542af" style="padding-left: 8px">
                                Action
                            </td>
                        </tbody>
                    </table>
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr align="left">
                            <td>
                                <div id="div_top" style="margin-top: 115px">
                                    <table width="301" border="0" cellpadding="1" cellspacing="0" style="padding-top: 10px;
                                        padding-bottom: 10px">
                                        <tbody>
                                            <tr>
                                                <td style="width: 80px">
                                                    &nbsp;
                                                </td>
                                                <td class="table">
                                                    <ext:Button ID="btnPrint" runat="server" Cls="Submit_80px" Text="Print" Width="70"
                                                        Hidden="false">
                                                        <DirectEvents>
                                                            <Click OnEvent="btnPrint_Click">
                                                                <EventMask ShowMask="true" Msg="Loading..." />
                                                                <ExtraParams>
                                                                    <ext:Parameter Name="gridList" Value="Ext.encode(#{gridList}.getRowsValues())" Mode="Raw">
                                                                    </ext:Parameter>
                                                                </ExtraParams>
                                                            </Click>
                                                        </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                                <td class="table" style="padding-left: 2px">
                                                    <ext:Button ID="btnVoid" runat="server" Cls="Submit_80px" Text="Void" Width="70">
                                                        <DirectEvents>
                                                            <Click OnEvent="btnVoid_Click">
                                                            </Click>
                                                        </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                                <td class="table" style="padding-left: 2px">
                                                    <ext:Button ID="btnCancel" runat="server" Cls="Submit_80px" Text="Cancel" Width="70">
                                                        <DirectEvents>
                                                            <Click OnEvent="btnCancel_Click">
                                                                <EventMask ShowMask="true" Msg="Loading..." />
                                                            </Click>
                                                        </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                                <td class="table" style="padding-left: 2px; padding-right: 7px">
                                                    <ext:Button ID="btnOk" runat="server" Cls="Submit_80px" Text="Save" Width="70">
                                                        <Listeners>
                                                            <Click Handler="Delete(#{gridList});return Validate();" />
                                                        </Listeners>
                                                        <DirectEvents>
                                                            <Click OnEvent="btnOk_Click">
                                                                <EventMask ShowMask="true" Msg="Saving..." />
                                                                <ExtraParams>
                                                                    <ext:Parameter Name="gridList" Value="Ext.encode(#{gridList}.getRowsValues())" Mode="Raw">
                                                                    </ext:Parameter>
                                                                </ExtraParams>
                                                            </Click>
                                                        </DirectEvents>
                                                    </ext:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td height="23">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 5px">
                                <table width="303" height="79" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3"
                                    class="table_25px">
                                    <tbody>
                                        <tr>
                                            <td width="50" height="26" bgcolor="#FFFFFF" class="table_25px">
                                                <span class="font_11bold">
                                                    <% if (Request["sys"] != null)
                                                       {%>
                                                    <% if (Request["sys"] == "AE" || Request["sys"] == "AI" || Request["sys"] == "AT") { Response.Write("GWT"); }
                                                       else
                                                       {
                                                           Response.Write("WT");
                                                       }
                                                       }
                                                       else
                                                       {%>
                                                    <%Response.Write("GWT");
                                                   } %>
                                                </span>
                                            </td>
                                            <td width="91" bgcolor="#FFFFFF" class="table_25px">
                                              
                                                   <%-- <ext:Label ID="txtGWT" runat="server">
                                                    </ext:Label>--%>
                                                   <ext:NumberField ID="txtGWT" runat="server" Cls="text" DecimalPrecision="3" StyleSpec="text-align:right" Width="84" TabIndex="9">
                                                     </ext:NumberField>
                                               
                                            </td>
                                            <td width="60" align="center" bgcolor="#FFFFFF" class="table_25px">
                                                <span class="font_11bold">Piece(s) </span>
                                            </td>
                                            <td width="97" align="center" bgcolor="#FFFFFF" class="table_25px">
                                                <table width="80" border="0" align="center" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" class="font_11px_gray">
                                                               <%-- <ext:Label ID="labPiece" runat="server">
                                                                </ext:Label>--%>
                                                                 <ext:NumberField ID="labPiece" runat="server" Cls="text" DecimalPrecision="3" StyleSpec="text-align:right" Width="90" TabIndex="9">
                                                                 </ext:NumberField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="26" bgcolor="#FFFFFF" class="table_25px">
                                                <span class="font_11bold">
                                                    <ext:Label ID="labcVWT" runat="server" Text="VWT">
                                                    </ext:Label>
                                                </span>
                                            </td>
                                            <td bgcolor="#FFFFFF" class="table_25px">
                                                
                                                  <%--  <ext:Label ID="labVWT" runat="server">
                                                    </ext:Label>--%>
                                                    <ext:NumberField ID="labVWT" runat="server" Cls="text" DecimalPrecision="3" StyleSpec="text-align:right" Width="84" TabIndex="9">
                                                     </ext:NumberField>
                                               
                                            </td>
                                            <td bgcolor="#FFFFFF" class="table_25px font_11bold">
                                                Unit
                                            </td>
                                            <td valign="middle" bgcolor="#FFFFFF" class="table_25px">
                                                <table width="80" border="0" align="center" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" class="font_11px_gray">
                                                                <ext:Label ID="labelUnit" runat="server" Hidden="true">
                                                               </ext:Label>
                                                               <div id="showUnit" runat="server" style="display:block;">
                                                      <uc1:UserComboBox runat="server" ID="labUnit" ListWidth="180" clsClass="select_160px"
                                    StoreID="StoreUnit" Width="67" winTitle="Unit"  winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" TabIndex="9"/>
                                                         </div>   </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="26" bgcolor="#FFFFFF" class="table_25px">
                                                <table width="50" border="0" cellpadding="0" cellspacing="0" align="center"">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11bold" style="padding-left: 8px">
                                                                <ext:Label ID="labCWT" runat="server" Text="CWT">
                                                                </ext:Label>
                                                                <span class="font_red">*</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td bgcolor="#FFFFFF">
                                                <ext:NumberField ID="txtCWT" runat="server" Cls="text_70px" DecimalPrecision="3" TabIndex="9"
                                                    StyleSpec="text-align:right">
                                                    <Listeners>
                                                        <Blur Handler="Qty();" />
                                                    </Listeners>
                                                </ext:NumberField>
                                            </td>
                                            <td bgcolor="#FFFFFF" class="table_25px">
                                                <span class="font_11bold">
                                                    <ext:Label ID="labcPallet" runat="server" Text="Pallet">
                                                    </ext:Label>
                                                </span>
                                            </td>
                                            <td bgcolor="#FFFFFF" class="table_25px">
                                                <table width="80" border="0" align="center" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td align="center" class="font_11px_gray">
                                                                <%--<ext:Label ID="labPallet" runat="server">
                                                                </ext:Label>--%>
                                                                <ext:NumberField ID="labPallet" runat="server" Cls="text" DecimalPrecision="1" StyleSpec="text-align:right" Width="90" TabIndex="9">
                                                     </ext:NumberField>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table style="border: solid 1px #8db2e3; margin-top: 15px; width: 303px; padding: 5px 0;
                        <% if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[25] == "False") { Response.Write("display:none");   }%>">
                        <tr>
                           <td><table cellpadding="0" cellspacing="0" border="0" width="208px"><tr> <td align="left" class="font_12px_Arial" style="padding-left:3px">
                                大陆发票
                            </td>
                            <td align="left">
                                <ext:TextField ID="txtoffical" runat="server" Width="120px" Cls="text_160px"></ext:TextField>     
                            </td>
                            <td>
                                <ext:Button ID="btn_offical" runat="server" Text=" OK "  Width="30px">
                                       <Listeners>
                                            <Click Handler="officalInv();" />
                                       </Listeners>
                                </ext:Button>   
                            </td></tr></table></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td valign="top">
                                <table width="300" border="0" cellpadding="0" cellspacing="4">
                                    <tbody>
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 4px">
                                                <table width="65" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11bold">
                                                                Company
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="101" valign="middle" colspan="2">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td height="25" align="left" class="font_11px_gray">
                                                                <ext:Label ID="labCompany" runat="server" Hidden="true">
                                                                </ext:Label>
                                                                <div id="showShipperCode" runat="server" style="display:block;">
                                                                <uc1:Autocomplete runat="server" ID="CmbShipperCode" TabIndex="1" Width="81" clsClass="text_82px"
                                                            winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800"
                                                            Query="option=CompanyList" isDiplay="false"/>  </div>
                                                                <ext:Hidden ID="labCpyRowID" runat="server">
                                                                </ext:Hidden>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 3px">
                                                &nbsp;
                                            </td>
                                            <td colspan="2" valign="top">
                                                <ext:TextField ID="txtCompany" runat="server" Cls="text_160px" Width="277px" TabIndex="1" Disabled="true">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 4px">
                                                Contact
                                            </td>
                                            <td colspan="2" valign="top">
                                                <ext:TextField ID="txtContact" runat="server" Cls="text_160px" Width="277px" TabIndex="2">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="font_11bold" style="padding-left: 4px">
                                                Phone
                                            </td>
                                            <td colspan="2">
                                                <ext:TextField ID="txtPhone" runat="server" Cls="text_160px" Width="277px" TabIndex="3">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="66" class="font_11bold" style="padding-left: 4px">
                                                Fax
                                            </td>
                                            <td colspan="2">
                                                <ext:TextField ID="txtFax" runat="server" Cls="text_160px" Width="277px" TabIndex="4">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 12px; padding-top: 10px">
                    <table>
                        <tr>
                            <td>
                                <table width="45" border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td class="font_11bold" valign="top">
                                                Address
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="302" valign="top" rowspan="5" style="padding-top: 7px">
                                <ext:TextField ID="txtAddress1" runat="server" MaxLength="43" Width="300" Cls="text_160px"
                                    TabIndex="5" StyleSpec="font-size: 10px;">
                                </ext:TextField>
                                <ext:TextField ID="txtAddress2" runat="server" MaxLength="43" Width="300" Cls="text_160px"
                                    TabIndex="6" StyleSpec="font-size: 10px; margin:4px 0">
                                </ext:TextField>
                                <ext:TextField ID="txtAddress3" runat="server" MaxLength="43" Width="300" Cls="text_160px"
                                    TabIndex="7" StyleSpec="font-size: 10px">
                                </ext:TextField>
                                <ext:TextField ID="txtAddress4" runat="server" MaxLength="43" Width="300" Cls="text_160px"
                                    TabIndex="8" StyleSpec="font-size: 10px ;margin:4px 0">
                                </ext:TextField>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-top: 9px; padding-left: 2px;">
                    <table border="0" cellspacing="1" cellpadding="0">
                        <tbody>
                            <tr>
                                <td width="12" valign="top" style="padding-right: 10px" class="font_11bold">
                                    Remark
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 10px">
                                    <ext:TextArea ID="txtRemark" runat="server" StyleSpec="width: 294px; height: 78px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"
                                        TabIndex="9">
                                    </ext:TextArea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 10px">
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView" colspan="2" style="vertical-align: top; padding-top: 2px;
                    height: 200px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 24px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td style="padding-left:2px">
                                            Invoice Item
                                        </td>
                                        <td align="right" style="padding-right: 5px">
                                            <div id="Invoicedetail" runat="server" visible="false">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td background="../../images/btn_bg_01.jpg" style="width: 4px; height: 19px">
                                                        </td>
                                                        <td background="../../images/btn_bg_02.jpg">
                                                            <% if (!string.IsNullOrEmpty(Request["seed"]) || !string.IsNullOrEmpty(Request["copyseed"])) { Response.Write("<a href=\"javascript:void(0)\"  onclick=\"MakeInvoiceDetail();\" class=\"font_11bold_1542af\"/>Retrieve</a>"); }%>
                                                        </td>
                                                        <td background="../../images/btn_bg_03.jpg" style="width: 6px; height: 19px">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gridList" runat="server" Width="675" Height="200" TrackMouseOver="true"
                                    ColumnLines="True" Selectable="true" AutoShow="true">
                                    <Store>
                                        <ext:Store runat="server" ID="storeInvoice" AutoLoad="true">
                                            <Reader>
                                                <ext:JsonReader>
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ItemCode" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Description" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="CalBy" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Unit" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Qty" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Currency" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Ex" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Min" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Rate" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Amount" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Percent" Type="Float">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="NetTotal" Type="Float">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Tax" Type="Float">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="TaxTotal" Type="Float">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Total" Type="Float">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ShipmentID" Type="Int"> </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                            <Listeners>
                                                <Load Handler="if(i==0){i=1;}else{if(make==1||auto=='Auto'){SumTotal(#{gridList});make=0;} else{SumTotal1(#{gridList});}}" />
                                            </Listeners>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ctl900">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="No." Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Item" Width="40" DataIndex="ItemCode" MenuDisabled="true" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="Description" Width="120" DataIndex="Description" MenuDisabled="true">
                                                <Renderer Fn="ToUpper" />
                                            </ext:Column>
                                            <ext:Column Header="Cal. By" Width="55" DataIndex="CalBy" Align="Center" MenuDisabled="true">
                                            </ext:Column>
                                            <ext:Column Header="Unit" Width="40" DataIndex="Unit" Align="Center" MenuDisabled="true">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Qty" Width="70" DataIndex="Qty" Align="Right" Format="0.000"
                                                MenuDisabled="true">
                                            </ext:NumberColumn>
                                            <ext:Column Header="CUR" Width="40" DataIndex="Currency" Align="Center" MenuDisabled="true">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Ex." Width="60" DataIndex="Ex" Align="Right" Format="0.0000"
                                                MenuDisabled="true">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Min." Width="60" DataIndex="Min" Align="Right" MenuDisabled="true"
                                                Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Rate" Width="60" DataIndex="Rate" Align="Right" MenuDisabled="true"
                                                Format="0.000">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Amount" Width="70" DataIndex="Amount" Align="Right" MenuDisabled="true"
                                                Format="0.00">
                                            </ext:NumberColumn>
                                            <ext:Column Header="%" Width="50" DataIndex="Percent" Align="Center" MenuDisabled="true">
                                                <Renderer Fn="pctChange" />
                                            </ext:Column>
                                            <ext:NumberColumn Header="Net Total" Width="75" DataIndex="NetTotal" Align="Right"
                                                MenuDisabled="true">
                                            </ext:NumberColumn>
                                            <ext:Column Header="Tax %" Width="50" DataIndex="Tax" Align="Center" MenuDisabled="true">
                                            <Renderer Fn="pctChange" />
                                            </ext:Column>
                                            <ext:NumberColumn Header="Tax Total" Width="75" DataIndex="TaxTotal" Align="Right"
                                                MenuDisabled="true">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Total" Width="70" DataIndex="Total" Align="Right" MenuDisabled="true">
                                            </ext:NumberColumn>
                                            <ext:Column DataIndex="RowID" Header="RowID" Hidden="true" MenuDisabled="true">
                                            </ext:Column>
                                            <ext:Column DataIndex="ShipmentID" Header="ShipmentID" Hidden="true" MenuDisabled="true">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <BottomBar>
                                        <ext:StatusBar runat="server" ID="ctl179">
                                            <Items>
                                                <ext:Label ID="txtTotal1" runat="server" Text="">
                                                </ext:Label>
                                                <ext:Label ID="txtTotal2" runat="server" Text="" StyleSpec=" margin:0px 15px">
                                                </ext:Label>
                                                <ext:Label ID="txtTotal3" runat="server" Text="">
                                                </ext:Label>
                                            </Items>
                                        </ext:StatusBar>
                                    </BottomBar>
                                    <Listeners>
                                        <RowClick Handler="getRowIndex(rowIndex);SelectRecord();" />
                                    </Listeners>
                                    <SelectionModel>
                                        <ext:RowSelectionModel>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                                <ext:Hidden ID="labRowIndex" runat="server" Text="0">
                                </ext:Hidden>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" width="307px" id="td_edit" runat="server">
                    <table style="width: 307px" runat="server" id="table_Invoice">
                        <tr>
                            <td style="height: 24px; line-height: 24px; padding-left: 5px; width: 307px" class="font_11bold_1542af table_nav2">
                                Add Invoice
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top" style="padding-top: 10px; padding-left: 4px">
                                            <table cellpadding="0" cellspacing="0" border="0" width="53px">
                                                <tr>
                                                    <td>
                                                        Item
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-top: 8px">
                                            <uc1:UserComboBox runat="server" StoreID="StoreItem" ID="inv_CmbItem" TabIndex="10"
                                                clsClass="select_160px" Width="60" winTitle="Item" winUrl="/BasicData/Item/list.aspx"
                                                winWidth="965" winHeight="480" Handler="selectItem();" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td style="padding-top: 5px; padding-bottom: 3px">
                                            <ext:TextField ID="txtDesc" runat="server" EnableKeyEvents="true" Cls="select_160px"
                                                Width="240" TabIndex="11">
                                                <Listeners>
                                                    <KeyDown Handler="getFocus(event,this);" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="divcalby" runat="server">
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="57px">
                                                <tr>
                                                    <td style="padding-left: 4px">
                                                        Cal.By
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <uc1:UserComboBox runat="server" StoreID="StorecalcQty" Width="60" ID="inv_Cmbcalby"
                                                ListWidth="150" TabIndex="12" clsClass="select_160px" Handler="CalbySelect()"
                                                isButton="false" />
                                        </td>
                                        <td><table border="0"  cellpadding="0" cellspacing="0" width="30px"><tr><td align="center">Unit</td></tr></table></td>
                                        <td>
                                            <uc1:UserComboBox runat="server" StoreID="StoreUnit" Width="48" ID="inv_CmbUnit"
                                                ListWidth="150" clsClass="select_160px" TabIndex="13" winTitle="Unit" winUrl="/BasicData/Unit/list.aspx"
                                                winWidth="510" winHeight="585" />
                                        </td>
                                        <td><table border="0" cellpadding="0" cellspacing="0" width="29px"><tr><td align="center">Qty</td></tr></table></td>
                                        <td>
                                            <ext:NumberField ID="inv_txtQty" runat="server" EnableKeyEvents="true" TabIndex="14"
                                                Cls="text_80px" Width="52" DecimalPrecision="3" StyleSpec="text-align:right">
                                                <Listeners>
                                                    <KeyDown Handler="getFocus(event,this);" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="divCurrency" runat="server">
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="57px">
                                                <tr>
                                                    <td style="padding-top: 3px; padding-left: 4px">
                                                        Currency
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-top: 3px">
                                            <uc1:UserComboBox runat="server" DisplayField="code" StoreID="StoreCurrInvoice" ID="inv_Currency"
                                                ListWidth="150" Width="60" TabIndex="15" ValueField="text" Handler="CurrencySelect()"
                                                winUrl="/BasicData/Currency/list.aspx" winTitle="Currency" winHeight="585" winWidth="653"
                                                clsClass="text_80px" />
                                        </td>
                                        <td style="padding-top: 3px; padding-left: 9px">
                                            <ext:NumberField ID="inv_Ex" runat="server" EnableKeyEvents="true" Width="48" TabIndex="16"
                                                DecimalPrecision="4" Cls="text_80px" StyleSpec="text-align:right">
                                                <Listeners>
                                                    <KeyDown Handler="getFocus(event,this);" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td style="padding-top: 3px; padding-left: 5px">
                                            <ext:NumberField ID="inv_Percent" runat="server" Cls="text" MaxLength="6" DecimalPrecision="2"
                                                Width="60" Text="100" TabIndex="17" StyleSpec="background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding-left: 4px <%if ("OI,OE,OT,BK,TK,DM".Contains(Request["sys"].ToUpper())) { Response.Write(";display:none");
                                            }%>">
                                            <table cellpadding="0" cellspacing="0" border="0" width="98px">
                                                <tr>
                                                    <td id="divMin" runat="server" style="padding-top: 1px; width: 53px">
                                                        Min.
                                                    </td>
                                                    <td id="divMin1" runat="server" style="padding-top: 3px">
                                                        <ext:NumberField ID="inv_Min" runat="server" Width="45" TabIndex="18" Cls="text_80px"
                                                            StyleSpec="text-align:right">
                                                            <Listeners>
                                                                <Blur Handler="if(this.getValue()!=''){#{inv_Amount}.setValue('');}" />
                                                            </Listeners>
                                                        </ext:NumberField>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="57px">
                                                <tr>
                                                    <td style="padding-top: 1px; padding-left:4px<%if ("OI,OE,OT,BK,TK,DM".Contains(Request["sys"].ToUpper())) { Response.Write(";width:45px");
                                                        } %>">
                                                        Rate
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-top: 3px">
                                            <ext:NumberField ID="inv_Rate" runat="server" Width="43" TabIndex="19" DecimalPrecision="3"
                                                Cls="text_80px" StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''){#{inv_Amount}.setValue('');}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                        <td><table width="50px"><tr><td align="right">Amount</td></tr></table></td>
                                        <td style="padding-top: 3px; padding-left:3px">
                                            <ext:NumberField ID="inv_Amount" runat="server" Width="42" TabIndex="20" Cls="text_80px"
                                                StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Blur Handler="if(this.getValue()!=''){#{inv_Min}.setValue('');#{inv_Rate}.setValue('');}" />
                                                </Listeners>
                                            </ext:NumberField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                       <td style="padding-right: 7px;  <%if (hidStat.Text!="USG/SIN") { Response.Write("display:none");
                                                        } %>">
                              <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" width="57px">
                                                <tr>
                                                    <td style="padding-top: 3px; padding-left: 4px">
                                                        Tax
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-top: 3px">
                                         <ext:NumberField ID="inv_Tax" runat="server" Cls="text" MaxLength="4" DecimalPrecision="1"
                                                Width="60"  TabIndex="20" StyleSpec="background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                            </ext:NumberField>   
                              </td></tr></table>
                         </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; padding-top: 8px; padding-right: 6px">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width: 100%">
                                        </td>
                                        <td style="padding-right: 2px">
                                            <input onclick="InsertRecord();" id="btnAddInvoice" runat="server" type="button"
                                                class="button btn_text" tabindex="21" value="Save & Next" />
                                        </td>
                                        <td style="padding-right: 2px">
                                            <input onclick="ResetRecord();" id="Button2" runat="server" type="button" class="button_01 btn_text"
                                                tabindex="22" value="Reset" />
                                        </td>
                                        <td>
                                            <input onclick="DeleteRecord();" id="Button3" runat="server" type="button" class="button_01 btn_text"
                                                tabindex="23" value="Delete" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" width="307px" id="td_lsit" runat="server">
                    <table style="width: 307px" runat="server" id="table1">
                        <tr>
                            <td style="height: 24px; line-height: 24px; padding-left: 5px; width: 307px" class="font_11bold_1542af table_nav2">
                                Invoice Detail
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td valign="top" style="padding-top: 8px; padding-left: 4px">
                                            <table cellpadding="0" cellspacing="0" border="0" width="53px">
                                                <tr>
                                                    <td>
                                                        Item
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-top: 5px">
                                            <table>
                                                <tr>
                                                    <td style="border: 1px solid #e8e8e8; height: 16px; width: 90px; padding-left: 2px">
                                                        <label id="l_item">
                                                        </label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td style="border: 1px solid #e8e8e8; height: 16px; width: 240px; padding-left: 2px">
                                            <label id="l_itemdesc" style="display: block; height: 12px; line-height: 12px;">
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="Tr1" runat="server">
                <td>
                    <table>
                        <tr>
                            <td style="padding-right: 18px; padding-left: 2px">
                                Cal.By
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_calby" style="width: 55px; display: block;">
                                </label>
                            </td>
                            <td style="padding-left: 5px; padding-right: 5px">
                                Unit
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_unit" style="width: 53px; display: block; text-align: left;">
                                </label>
                            </td>
                            <td style="padding-left: 5px; padding-right: 3px">
                                Qty
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_qty" style="width: 55px; display: block; text-align: center">
                                </label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="Tr2" runat="server">
                <td>
                    <table>
                        <tr>
                            <td style="padding-right: 5px; padding-left: 2px">
                                Currency
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_currency" style="width: 55px; display: block;">
                                </label>
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_ex" style="width: 50px; display: block;">
                                </label>
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_percent" style="width: 60px; display: block;background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                </label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td style="padding-left: 4px <%if ("OI,OE,OT,BK,TK,DM".Contains(Request["sys"].ToUpper())) { Response.Write(";display:none");
                                }%>">
                                <table cellpadding="0" cellspacing="0" border="0" width="51px">
                                    <tr>
                                        <td id="Td1" runat="server" style="padding-top: 1px">
                                            <%-- <td id="Td1" runat="server" style="padding-left:2px; padding-right:8px">--%>
                                            Min.
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td id="Td2" runat="server" style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_min" style="width: 40px; display: block;">
                                </label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td style="padding-right: 6px; <%if ("OI,OE,OT,BK,TK,DM".Contains(Request["sys"].ToUpper())) { Response.Write("width:45px");
                                            } %>">
                                            Rate
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_rate" style="width: 50px; display: block;">
                                </label>
                            </td>
                            <td style="padding-top: 1px">
                                <table cellpadding="0" cellspacing="0" border="0" width="48px"><tr><td align="center">Amount</td></tr></table>
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                <label id="l_amount" style="width: 50px; display: block; text-align: center;">
                                </label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" style="padding-left:0px; <%if (hidStat.Text!="USG/SIN") { Response.Write("display:none");
                                                        } %>">
                    <table>
                        <tr>
                            <td style="padding-right:31px; padding-left: 3px">
                                Tax
                            </td>
                            <td style="border: 1px solid #e8e8e8; height: 16px; padding-left: 2px">
                                 <label id="labTax" style="width: 55px; display: block;background-image:url(../../images/icon.gif);background-repeat:no-repeat; background-position:right center;">
                                </label>
                            </td>
                           
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td> </tr> </table>
        <ext:Hidden ID="labgridCalBy" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="labgridAmout" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="labgridMin" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="labgridRate" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="labgridPercent" runat="server" Text="100">
        </ext:Hidden>
        <ext:Hidden ID="labItemRound" runat="server" Text="2">
        </ext:Hidden>
        <ext:Hidden ID="labMarkUp" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="labMarkDown" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="labgridTax" runat="server" Text="10">
        </ext:Hidden>
        <ext:Hidden ID="inv_Seed" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="inv_SYS" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="inv_Total" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="inv_RowID" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="inv_Show" runat="server" Text="1">
        </ext:Hidden>
        <ext:Hidden ID="inv_CopySeed" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidtohouse" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidtomaster" runat="server" Text="0">
        </ext:Hidden>
          <ext:Hidden ID="hidOtherSys" runat="server" Text="O">
        </ext:Hidden>
          <ext:Hidden ID="hidSetInformation" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="hidChinaMode" runat="server" Text="0"></ext:Hidden>
        <ext:Hidden ID="hidIsAc" runat="server" Text="N">
        </ext:Hidden>
        <ext:Hidden ID="hidStat" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="hidNetTotal" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidTaxTotal" runat="server" Text="0">
        </ext:Hidden>
         <ext:Hidden ID="hidAccount" runat="server" Text="">
        </ext:Hidden>
    </div>
    </form>
</body>
</html>
