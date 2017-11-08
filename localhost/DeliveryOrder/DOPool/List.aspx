<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="DeliveryOrder_DOPool_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Src="/common/UIControls/UserComboBox.ascx" TagName="UserComboBox" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Delivery Order Pool</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <style type="text/css">
        th
        {
            border-left: 1px solid rgb(174, 163, 163);
            border-bottom: 1px solid rgb(174, 163, 163);
            text-align: center !important;
            font-weight: bold !important;
        }
        
        .border
        {
            border-left: 1px solid rgb(223, 217, 217);
            border-bottom: 1px solid rgb(223, 217, 217);
            padding:0 2px;
        }
        
        .btn_img
        {
            background-image: url('../../images/DO/btn_search_bg.jpg');border:0 none;
        }
        
        .btn_himg
        {
            cursor:pointer;
            background-image: url('../../images/DO/btn_search_hover_bg.jpg');border:0 none;
        }
        
    </style>
    <script type="text/javascript">
        var DOArray = new Array();
        var DODArray = new Array();
        var j = 0, k = 0;

        function RefreshList() {
            Ext.getCmp('btnSearch').fireEvent('click', this);
        }

        //search按钮的鼠标悬浮
        function btnmouseover() {
                $("#btnSearch").removeClass("btn_img");
                $("#btnSearch").addClass("btn_himg");
        };

        //search按钮的鼠标移开
        function btnmouseout() {
            
            $("#btnSearch").removeClass("btn_himg");
            $("#btnSearch").addClass("btn_img");
        };

        //每行的悬浮
        function mouseover(obj) {
            if (!$(obj).find(":checkbox").attr("checked")) {
                $(obj).css("backgroundColor", "#efefef");
            }
        }

        //每行的离开
        function mouseout(obj) {
            if (!$(obj).find(":checkbox").attr("checked")) {
                $(obj).css("backgroundColor", "");
            }
        }

        //search按钮的点击事件
        function btnSearchClick() {
            clearRowID(); //清空DODrowID,否则会导致点击search后，页面里的行已经没有打勾了，但实际上还是记住了它的ROWID

//            var a = document.getElementById("divLoading");
//            var b = document.getElementById("divGray");
//            a.style.display = "block"; //隐藏 
            //            b.style.display = "block"; //显示 点击search时的Loading效果 如果没有在页面使用updatepanle，就可以直接在前台页面弄好效果，弄一个透明层，点击时设置为显示
            //当JS走完的时候，会自动隐藏
//            $("#divGray").height($("#uu").height() + 32); //在前台JS里设置高度之后还是会恢复原样，估计是因为在updatepanel里的原因
        }

        //每一行的点击事件
        function trClick(obj) {
            //如果当前行点击的地方不是checkbox或者是img按钮的时候
            if ($(event.srcElement || event.target).attr("type") != "checkbox" && $(event.srcElement || event.target).attr("id") != "img") { 
                $(obj).find(":checkbox").attr("checked", !$(obj).find(":checkbox").attr("checked"));

                //                if ($(obj).find(":checkbox").attr("checked")){
                ////                    DOArray[j] = obj.value;
                //                    //                    j++;
                //                    alert($(obj).find(":checkbox")[0].value);
                //                    $(obj).css("backgroundColor", "#dfe8f6");
                //                } else {

                ////                    for (var i = 0; i < DOArray.length; i++) {
                ////                        if (DOArray[i] == obj.value) {
                ////                            DOArray.splice(i, 1);
                ////                            j--;
                ////                        }
                //                    //                    }
                //                    alert($(obj).children(0).children().find("input").value);
                //                    $(obj).css("backgroundColor", "");
                //                }

                //                var s = "";
                //                for (var i = 0; i < DOArray.length; i++) {
                //                    s += DOArray[i] + ",";
                //                }

                //                alert(s);
                //                $("#hidDORowID").val(s);

                
                //                 alert($(this).next("tr").html());

                if ($(obj).attr("class") == "trColor1") { //点击的时候是主行

                    if ($(obj).find(":checkbox").attr("checked")) {
                        $(obj).css("backgroundColor", "#dfe8f6");
                    } else {
                        $(obj).css("backgroundColor", "");
                    }

                    //SetHidDORowID($(obj).find(":checkbox").attr("checked"), $(obj).find(":checkbox")[0], $(obj));  设置打勾的行的DORowID的值 ，暂时不需要传

                    //点击主行时，先清空下当前主行下已经打勾的从行的DODROWID
                    var items = $(obj).next("tr").find("input");

                    for (i = 0; i < items.length; i++) {
                        if (items[i].type == "checkbox") {
                            for (var h = 0; h < DODArray.length; h++) {
                                if (DODArray[h] == items[i].value) {
                                    DODArray.splice(h, 1);      //移除没有打勾的项即ROWID
                                    if (k > 0) {
                                        k--;
                                    }
                                }
                            }
                        }
                    }

                    for (i = 0; i < items.length; i++) {

                        if (items[i].type == "checkbox") {
                            items[i].checked = $(obj).find(":checkbox").attr("checked");
                        }

                        SetHidDODRowID($(obj).find(":checkbox").attr("checked"), items[i], $(items[i]).parent("td").parent("tr"));


                    }
                }
                else { //点击的时候是从行


                    SetHidDODRowID($(obj).find(":checkbox").attr("checked"), $(obj).find(":checkbox")[0], $(obj));

                    if (!$(obj).find(":checkbox").attr("checked")) {
                        $(obj).parent().parent().parent().parent().prev(".trColor1").find("input")[0].checked = $(obj).attr("checked");
                        $(obj).parent().parent().parent().parent().prev(".trColor1").css("backgroundColor", "");
                    }
                    
                }

                var a = "";
                for (var i = 0; i < DODArray.length; i++) {
                    a += DODArray[i] + ",";
                }

//                alert(a);

                $("#hidDODRowID").val(a);
               
            }
        }

        //主行的双击事件,设置从行是否展开
        function dbc(obj) {
            var a = $(obj).next("tr").attr("style");

            if (a.indexOf("none") > 0) {
                $(obj).find("img").attr("src", "../../images/DO/minus.png");
                $(obj).next("tr").show();
            } else {
                $(obj).find("img").attr("src", "../../images/DO/plus.png");
                $(obj).next("tr").hide();
            }
        }

        //展开按钮的Click事件,设置从行是否展开
        function imgClick(obj) {
            if ($(obj).attr("src") == "../../images/DO/plus.png") {
                $(obj).attr("src", "../../images/DO/minus.png");
                $(obj).parent("td").parent("tr").next("tr").show();
            } else {
                $(obj).attr("src", "../../images/DO/plus.png");
                $(obj).parent("td").parent("tr").next("tr").hide();
            }
        }

        //全选的文本框
        function GetAllCheckBox(CheckAll) {
            var items = document.getElementsByTagName("input");

            //清空已经打勾的从行的ROWID
            for (i = 0; i < items.length; i++) {
                if (items[i].type == "checkbox") {
                    for (var h = 0; h < DODArray.length; h++) {
                        if (DODArray[h] == items[i].value) {
                            DODArray.splice(h, 1);      //移除没有打勾的项即ROWID
                            if (k > 0) {
                                k--;
                            }
                        }
                    }
                }
            }

            for (i = 0; i < items.length; i++) {
                if (items[i].type == "checkbox") {
                    items[i].checked = CheckAll.checked;

                    if ($(items[i]).parent("td").parent("tr").attr("class") == "trColor1") {

                        //alert(document.getElementById(items[i].id).value);
                        //SetHidDORowID($(items[i]).is(":checked"), document.getElementById(items[i].id), $(items[i]).parent("td").parent("tr"));
                     
                        if (!$(items[i]).is(":checked"))
                            $(items[i]).parent("td").parent("tr").css("backgroundColor", "");
                        else
                            $(items[i]).parent("td").parent("tr").css("backgroundColor", "#dfe8f6");
                    }

                    if ($(items[i]).parent("td").parent("tr").attr("class") == "trColor2") {
                        SetHidDODRowID($(items[i]).is(":checked"), document.getElementById(items[i].id), $(items[i]).parent("td").parent("tr"));
                    }

                }
            }

            var a = "";
            for (var i = 0; i < DODArray.length; i++) {
                a += DODArray[i] + ",";
            }

//            alert(a);
            $("#hidDODRowID").val(a);
        }

        //清空dodrowid
        function clearRowID() {
            DODArray.length = 0;
            j = 0;
            k = 0;
            $("#hidDODRowID").val("");
        }

        //CheckDO 的click事件
        function CheckDO(obj) {
             if ($(obj).attr("checked")) {
                $(obj).parent("td").parent("tr").css("backgroundColor", "#dfe8f6");
            } else {
                $(obj).parent("td").parent("tr").css("backgroundColor", "");
            }

            var items = $(obj).parent("td").parent("tr").next("tr").find("input");
            for (i = 0; i < items.length; i++) {
                if (items[i].type == "checkbox") {
                    for (var h = 0; h < DODArray.length; h++) {
                        if (DODArray[h] == items[i].value) {
                            DODArray.splice(h, 1);      //移除没有打勾的项即ROWID
                            if (k > 0) {
                                k--;
                            }
                        }
                    }
                }
            }

            for (i = 0; i < items.length; i++) {
                if (items[i].type == "checkbox") {
                    items[i].checked = obj.checked;

                }

                SetHidDODRowID($(items[i]).is(":checked"), items[i], $(items[i]).parent("td").parent("tr"));
            }

            var a = "";
            for (var i = 0; i < DODArray.length; i++) {
                a += DODArray[i] + ",";
            }

            $("#hidDODRowID").val(a);
        }

 
        
        //设置DODROWID的值 在调用处给隐藏文本框DODROWID赋值
        function SetHidDODRowID(isCheck, obj, tr) {
            if (isCheck) {
                DODArray[k] = obj.value;
                k++;
                tr.css("backgroundColor", "#dfe8f6");
            } else {
                for (var h = 0; h < DODArray.length; h++) {
                    if (DODArray[h] == obj.value) {
                        DODArray.splice(h, 1);      //移除没有打勾的项即ROWID
                        if (k > 0) {
                            k--;
                        }
                    }
                }
                tr.css("backgroundColor", "");
            }
        }

        function CheckDOD(obj) {
            SetHidDODRowID($(obj).attr("checked"), obj, $(obj).parent("td").parent("tr"));
            var a = "";
            for (var i = 0; i < DODArray.length; i++) {
                a += DODArray[i] + ",";
            }

            $("#hidDODRowID").val(a);
            //1.打勾变色，当全部勾上的时候自动给父级钩钩打勾
            //            if ($(obj).attr("checked")) {
            //                DODArray[k] = obj.value;
            //                k++;
            //                $(obj).parent("td").parent("tr").css("backgroundColor", "#dfe8f6");
            //            } else {
            //                for (var h = 0; h < DODArray.length; h++) {
            //                    if (DODArray[h] == obj.value) {
            //                        DODArray.splice(h, 1);      //移除没有打勾的项即ROWID
            //                        k--;
            //                    }
            //                }
            //                $(obj).parent("td").parent("tr").css("backgroundColor", "");
            //            }

            //            var a = "";
            //            for (var i = 0; i < DODArray.length; i++) {
            //                a += DODArray[i] + ",";
            //            }

            //           alert(a);
            //           $("#hidDODRowID").val(a);


            //            //var items = $(obj).parent("td").parent(".trColor2").parent().parent().parent().parent().find("input");
            //            var items = $(obj).parent("td").parent(".trColor2").parent().parent().parent().find("input");
            //            for (i = 0; i < items.length; i++) {
            //                if (items[i].type == "checkbox") {
            //                    if (!$(items[i]).is(":checked")) {
            //                        //                        $(obj).parent("td").parent(".trColor2").parent().parent().parent().parent().css("backgroundColor", "");
            //                        break;
            //                    } else if ((i + 1) == items.length) {
            //                        alert(i);
            //                        //$(obj).parent("td").parent(".trColor2").parent().parent().parent().parent().css("backgroundColor", "#dfe8f6");
            //                    }
            //                }
            //            }

            //2.取消钩钩无颜色，当取消了任意一个钩钩的时候，父级钩钩不打勾

            if (!$(obj).attr("checked")) {
                $(obj).parent("td").parent(".trColor2").parent().parent().parent().parent().prev(".trColor1").find("input")[0].checked = $(obj).attr("checked");
                $(obj).parent("td").parent(".trColor2").parent().parent().parent().parent().prev(".trColor1").css("backgroundColor", "");
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <ext:Hidden ID="hidDate" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidTo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidDODRowID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidDORowID" runat="server">
    </ext:Hidden>
    <div style="width: 975px; margin-top: 10px; margin-left: 13px">
        <table width="975px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tbody>
                <tr>
                    <td align="left" background="../../images/bg_line.jpg" bgcolor="#FFFFFF">
                        <table width="965px" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td align="left" style="padding-left: 5px" class="font_11bold_1542af">
                                        Delivery Order Pool
                                    </td>
                                    <td width="288" align="right" valign="top" style="padding-right: 5px; padding-bottom: 2px">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="table" style="padding: 8px 0">
            <tbody>
                <tr>
                    <td align="left" class="font_11bold" style="padding-right: 2px" width="60">
                    <nobr>
                        DO #
                        </nobr>
                    </td>
                    <td align="left" width="110">
                        <ext:TextField ID="txtDO" runat="server" Cls="text" Width="100" TabIndex="1">
                        </ext:TextField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Date
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110" align="left" >
                        <ext:DateField ID="txtDate" runat="server" Cls="text_80px" Format="dd/m/Y" Width="100"
                            TabIndex="2">
                        </ext:DateField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        To
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="110" align="left">
                        <ext:DateField ID="txtTo" runat="server" Cls="text_80px" Format="dd/m/Y" Width="100"
                            TabIndex="3">
                        </ext:DateField>
                    </td>
                    <td width="50" align="left">
                        <table width="50" cellpadding="3">
                            <tbody>
                                <tr>
                                    <td class="font_11bold">
                                        Company
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="100" align="left">
                        <%--  <uc1:UserComboBox runat="server" ID="ACCompany" Query="option=CompanyList" clsClass="select_160px"  Width="100"  TabIndex="5"  StoreID="StoreCompany"  winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                        <%--    <uc1:AutoComplete runat="server" ID="ACCompany" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" isButton="false" showType="text"/>--%>
                        <uc1:AutoComplete runat="server" ID="ACCompany" TabIndex="4" clsClass="text input"
                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                            winWidth="800" winHeight="800" />
                        <%--  <uc1:AutoComplete runat="server" ID="ACCompany" TabIndex="4" clsClass="x-form-text x-form-field text"
                                                                Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                winWidth="800" winHeight="800"/>--%>
                    </td>
                    <td width="25%">
                    </td>
                    <td width="100" align="right">
                        <ext:Button ID="btnNew" runat="server" Text="New Booking" TabIndex="6">
                            <Menu>
                                <ext:Menu ID="Menu1" runat="server">
                                    <Items>
                                        <ext:Button ID="btnAE" runat="server" Text="AE" width="86">
                                            <DirectEvents>
                                                <Click OnEvent="AE_Click">
                                                </Click>
                                                
                                            </DirectEvents>
                                        </ext:Button>
                                          <ext:Button ID="btnOE" runat="server" Text="OE" width="86">
                                            <DirectEvents>
                                                <Click OnEvent="OE_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                          <ext:Button ID="btnTK" runat="server" Text="TK" width="86">
                                            <DirectEvents>
                                                <Click OnEvent="TK_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                       <%-- <ext:MenuItem ID="MIAE" runat="server" Text="AE">
                                        
                                            <DirectEvents>
                                                <Click OnEvent="AE_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:MenuItem>
                                        <ext:MenuItem ID="MIOE" runat="server" Text="OE">
                                            <DirectEvents>
                                                <Click OnEvent="OE_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:MenuItem>
                                        <ext:MenuItem ID="MITK" runat="server" Text="TK">
                                            <DirectEvents>
                                                <Click OnEvent="TK_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:MenuItem>--%>
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>


                         <ext:Button ID="btnOk" runat="server" Width="80px" Text="Ok" Visible="false">
                            <DirectEvents>
                                <Click OnEvent="btnOk_Click">                     
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </td>
                </tr>
            </tbody>
        </table>
            <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
            <ContentTemplate>
                    <div style="position: absolute; z-index: 99999; top: 48px; left: 800px;">
                     <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                               <%-- <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" Width="75px" Height="20px" style="text-transform:lowercase;background-image: url('/images/DO/btng.png');border:0 none;vertical-align:bottom;font-family:Verdana, Arial, Helvetica, sans-serif !important;font-size:10px !important;font-weight:bold;" />--%>
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="" Width="77px" Height="24px" CssClass="btn_img" onmouseover="btnmouseover()" onmouseout="btnmouseout()" OnClientClick="btnSearchClick()"/>
                            </td>
                        </tr>
                    </table>
                </div>
                
        <div class="ext-el-mask" id="divGray" style="width:976px;height:300px;top:84px;left: 14px;display:none;"></div> 
        <div class="ext-el-mask-msg x-mask-loading" id="divLoading" style="left: 431px; top: 85px; display:none;"><div>Searching...</div></div>
                    <%-- min-height:368px;--%>
                     <div style="border: 1px solid #99bbe8;overflow-x:hidden;overflow-y:scroll;width: 975px;" id="uu">
                    <asp:Repeater ID="RepListDO" runat="server" OnItemDataBound="RepListDO_ItemDataBound">
                        <HeaderTemplate>
                            <table cellspacing="0" style="width: 956px; line-height: 22px;" cellpadding="0">
                                <thead>
                                    <tr class="HeaderStyle">
                                        <th>
                                            <input type="checkbox" onclick="GetAllCheckBox(this)" id="CheckAll" />
                                        </th>
                                        <th>
                                        </th>
                                        <th scope="col">
                                            DO #
                                        </th>
                                        <th scope="col">
                                            Date
                                        </th>
                                        <th scope="col">
                                            PO #
                                        </th>
                                        <th scope="col">
                                            Shipper
                                        </th>
                                        <th scope="col">
                                            Pick up place
                                        </th>
                                        <th scope="col">
                                            CTNS
                                        </th>
                                        <th scope="col">
                                            GW
                                        </th>
                                        <th scope="col">
                                            VOL/CBM
                                        </th>
                                        <th scope="col" style="border-right: 1px solid rgb(223, 217, 217);">
                                            Cost
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="trColor1" style="background-color: White; height: 10px;" onmouseover="mouseover(this)"
                                onmouseout="mouseout(this)" onclick="trClick(this)" ondblclick="dbc(this)">
                                <td width="18" class="border" align="center">
                                    <input id="chkDO" runat="server" type="checkbox" value='<%#DataBinder.Eval(Container.DataItem, "RowID")%>'
                                        onclick="CheckDO(this)" />
                                </td>
                                <td width="17px" align="center" class="border">
                                    <img alt="" src="../../images/DO/plus.png" style="width: 10px; height: 10px;" onclick="imgClick(this)"
                                        id="img" />
                                    <%--  <input type="image" name="img" value=" "  src="../../images/DO/plus.jpg" style="width:8px; height:9px;" onclick="imgClick(this)"/>--%>
                                </td>
                                <td width="97" align="left" class="border">
                                    <%#Eval("DO")%>
                                </td>
                                <td width="80" align="left" class="border">
                                    <%#Eval("OrderDate", "{0:dd/MM/yyyy}")%>
                                </td>
                                <td width="96" align="left" class="border">
                                    <%#Eval("DOPO")%>
                                </td>
                                <td width="95" align="left" class="border">
                                    <%# Eval("DOShipper")%>
                                </td>
                                <td width="120" align="left" class="border" style="overflow: hidden;">
                                    <div style="overflow: hidden; width: 120px; height: 22px;">
                                        <%# Eval("ADDR")%></div>
                                </td>
                                <td width="94" align="right" class="border">
                                    <%# Eval("DOCTNS")%>
                                </td>
                                <td width="94" align="right" class="border">
                                    <%# Eval("DOGW", "{0:N3}")%>
                                </td>
                                <td width="94" align="right" class="border">
                                    <%# Eval("DOCBM", "{0:N3}")%>
                                </td>
                                <td width="95" align="right" class="border" style="border-right: 1px solid rgb(223, 217, 217);">
                                    <%# Eval("Cost", "{0:N2}")%>
                                </td>
                            </tr>
                            <tr style="display: none; background-color: White;">
                                <td colspan="11">
                                    <asp:Repeater ID="RepListDOD" runat="server">
                                        <HeaderTemplate>
                                            <table border="0" style="width: 943px; table-layout: fixed" cellspacing="0" cellpadding="0">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="trColor2" onmouseover="mouseover(this)" onmouseout="mouseout(this)" onclick="trClick(this)">
                                                <td width="18px" class="border" align="center">
                                                    <input id="chkDOD" runat="server" type="checkbox" value='<%#DataBinder.Eval(Container.DataItem, "RowID")%>'
                                                        onclick="CheckDOD(this)" />
                                                </td>
                                                <td width="17px" align="center" class="border">
                                                </td>
                                                <td width="97" align="left" class="border">
                                                    <%#Eval("DO")%>
                                                </td>
                                                <td width="80" align="left" class="border">
                                                    <%#Eval("OrderDate", "{0:dd/MM/yyyy}")%>
                                                </td>
                                                <td width="96" align="left" class="border">
                                                    <%#Eval("DODPO")%>
                                                </td>
                                                <td width="95" align="left" class="border">
                                                    <%# Eval("DODShipper")%>
                                                </td>
                                                <td width="120" align="left" class="border">
                                                    <%# Eval("ADDR")%>&nbsp;
                                                </td>
                                                <td width="94" align="right" class="border">
                                                    <%# Eval("DODCTNS")%>
                                                </td>
                                                <td width="94" align="right" class="border">
                                                    <%# Eval("DODGW", "{0:N3}")%>
                                                </td>
                                                <td width="94" align="right" class="border">
                                                    <%# Eval("DODCBM", "{0:N3}")%>
                                                </td>
                                                <td width="95" align="right" class="border" style="border-right: 1px solid rgb(223, 217, 217);">
                                                    <%# Eval("Cost", "{0:N2}")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody> </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    </div>
                    <div style="width: 975px; border-bottom: 1px solid #99bbe8; border-right: 1px solid #99bbe8;
                    border-left: 1px solid #99bbe8; height: 30px; ">
                    <div style="width: 665px; float: left; margin-top: 3px; height: 30px;">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <asp:ImageButton ID="imgBtnFirst" runat="server" OnClick="imgBtnFirst_Click" OnClientClick="clearRowID()" Style="width: 16px;
                                        height: 16px; padding-top: 5px;" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgBtnPrev" runat="server" OnClick="imgBtnPrev_Click" OnClientClick="clearRowID()" Style="width: 16px;
                                        height: 16px; padding-top: 5px;" />
                                </td>
                                <td>
                                    <asp:Image ID="Image1" ImageUrl="/extjs/resources/images/default/grid/grid-blue-split-gif/ext.axd"
                                        runat="server" Style="width: 4px; height: 16px;" />
                                </td>
                                <td>
                                    <span>&nbsp;Page&nbsp;</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPageNum" runat="server" Width="38px" Text="1" Height="16px" Style="padding-top: 5px;
                                        text-align: right;" />
                                </td>
                                <td>
                                    <span>&nbsp;of &nbsp;<%=PageCount %>&nbsp;</span>
                                </td>
                                <td>
                                    <asp:Image ID="Image2" ImageUrl="/extjs/resources/images/default/grid/grid-blue-split-gif/ext.axd"
                                        runat="server" Style="width: 4px; height: 16px;" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgBtnNext" runat="server" OnClick="imgBtnNext_Click" OnClientClick="clearRowID()" Style="width: 16px;
                                        height: 16px;" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgBtnLast" runat="server" OnClick="imgBtnLast_Click" OnClientClick="clearRowID()" Style="width: 16px;
                                        height: 16px;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="padding-top: 10px; width: 310px; float: left;" align="right">
                        <%  if (totalNum == 0)
                            { %>
                        No data&nbsp;
                        <% }
                            else
                            { %>
                        Displaying
                        <%=startNum %>
                        -
                        <%=endNum %>
                        of
                        <%=totalNum %>&nbsp;
                        <% } %>
                    </div>
                </div>
                      </ContentTemplate>
        </asp:UpdatePanel>
        
         
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $("#uu").height(document.documentElement.clientHeight - 200);
        var h = document.documentElement.clientHeight - 200;
        $("#uu").height(h);
        $("#uu").css("max-height", Math.abs(h));
    }); 
</script>