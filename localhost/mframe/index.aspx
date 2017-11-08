<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="mframe_index" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=8"/> 
    <link href="/common/ylQuery/jQuery/css/ui-lightness/jquery-ui-1.8.14.custom.css"
        rel="stylesheet" type="text/css" />

    <script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="/common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>

    <link href="/common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />

    <script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>

    <link href="/App_Themes/LOGIN/mframe.css" rel="stylesheet" type="text/css" />
 <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    <script src="/common/Global/global.js" type="text/javascript"></script>
 <script type="text/javascript" src="/common/ylQuery/KeyListener.js"></script>
    <title></title>
     <style type="text/css">
        .mask
        {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            z-index: 5 !important;
            text-align: center;
            display: none;
            background-color: gray;
            opacity: 0.5;
            filter: alpha(opacity=50);
            -ms-filter: alpha(opacity=50);
            zoom: 1;
            display: none;
            z-index: 1;
            -moz-opacity: 0.5;
        }

        .txtStyle
        {
            font-family: Verdana, Arial, Helvetica, sans-serif !important;
            font-size: 10px !important;
            color: #333333;
            float: right;
            background-image: none !important;
            border: 0px !important;
            padding-top: 1px !important;
            padding-bottom: 0px !important;
            margin-top: 11px !important;
        }


    </style>
</head>
<body style="width: 100%; height: 100%; overflow: hidden">
    <form runat="server" id="form1">
    <%Response.Write("<script type=\"text/javascript\">document.title = \"" + webTitle + "CONSOLDATOR\";</script>");%>
    <%Response.Write("<script src=\"ChangeStat.js?datetime=" + DateTime.Now.ToString("yyyyMMddhhmmssfff") + "\" type=\"text/javascript\"></script>\r\n"); %>
    <%Response.Write("<script src=\"controller.js?datetime=" + DateTime.Now.ToString("yyyyMMdd") + "\" type=\"text/javascript\"></script>\r\n"); %>
    <%Response.Write("<link href=\"/css/style.css?datetime=" + DateTime.Now.ToString("yyyyMMdd") + "\" type=\"text/css\" rel=\"stylesheet\" />"); %>
    <ext:ResourceManager ID="ResourceManager1" runat="server" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <asp:HiddenField ID="hidStat" runat="server" Value="N"/>
    <table id="m_top" width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="left">
                <%--top start--%>

              <%--  <script type="text/javascript">                    var groupID = "<%=DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[8] %>"; </script>--%>

                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="sy_top" style="background: #0354AD">
                    <tr>
                        <td style="padding-left: 5px; padding-right: 10px;" width="220">
                            <img src="../../images/logo.png" width="220" height="50" />
                              <span style="position: absolute; z-index: 555; top: 5px; left: 0px; width: 1157px;
                                height: 25px; text-align: center;" id="AllSearch"><span class="menu_btn"><a href="javascript:void(0);"
                                id="btnSearch" style="float: right; font-size: 10px !important;
                                    margin-left: 2px; margin-top: 8px !important;">Search</a> </span>
                              <span style="background-image:url('/images/ico.png'); position: absolute; 
                                    z-index: 555; top: 10px; right: 184px; width: 15px; height:16px;" id="btnCmbChkGroup"></span>  
                        <span id="divChkGroupTitle" style="color: white;font-size: 10px;position: absolute; top: 11px; right: 201px;font-weight:bold;font-family:Verdana;"></span>          
                        
                                <span style="margin-top: -1px; float: right;">
                                        <ext:TextField ID="txtAllNo" runat="server" Cls="txtStyle" Width="105">
                                        </ext:TextField>
                                    </span><span id="divChkGroup" style="display:none;width:103px;position: absolute; z-index:9999; top: 26px; right: 184px;
                                                 background-color:white; border-color:#98c0f4 !important; border:1px solid;">
                                        <ext:CheckboxGroup ID="tblChkGroup" runat="server" ColumnsNumber="1">
                                           <Items>
                                                <ext:Checkbox ID="chkAll" BoxLabel="All" runat="server" Tag="all" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkLot" BoxLabel="Lot" runat="server" Tag="lot" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkMaster" BoxLabel="MAWB/MBL" runat="server" Tag="master" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkHouse" BoxLabel="HAWB/HBL" runat="server" Tag="house" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkInvoice" BoxLabel="Invoice" runat="server" Tag="invoice" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkCtnr" BoxLabel="CTNR" runat="server" Tag="ctnr" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkSO" BoxLabel="S/O" runat="server" Tag="s/o" StyleSpec="float:left; margin-top:8px;" BoxLabelStyle="float:left;margin-top:7px;">
                                                </ext:Checkbox>
                                           <%--     <ext:Checkbox ID="chkVoid" BoxLabel="Void" runat="server" Tag="void" LabelAlign="Right">
                                                </ext:Checkbox>--%>
                                            </Items>
                                        </ext:CheckboxGroup>
                                    </span></span>
                            <div id="maskShipment" class="mask">
                            </div>
                            <div id="divShipment" style="position: absolute; z-index: 100; top: 35px; left: 165px;
                                width: 998px; height: 660px; display: none;">
                                <iframe id="IfrShipment" name="IfrShipment" frameborder="0" width="100%" height="100%"
                                    style="background-color: White;"></iframe>
                            </div>
                        </td>  
                        <td align="left" bgcolor="" id="top_Menu" style="height: 70px; vertical-align: middle;
                            padding-left: 4px; line-height: 70px;">
                            <%-- nav start--%>
                            <%-- nav end --%>
                        </td>
                    </tr>
                </table>
                <%--top end--%>
            </td>
        </tr>
    </table>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top" id="td_Menu" style="height: 100%; width: 175px;">
                <div id="div_Menu" style="width: 175px;">
                    <table cellpadding="0" cellspacing="0" border="0" style="height: 100%;">
                        <tr>
                            <td height="100%" valign="top" id="tdLeft" style="width: 160px">
                                <!-- left start-->
                                <table border="0" cellspacing="0" cellpadding="0" style="width: 100%">
                                    <tr>
                                        <td height="50" valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" height="50" width="155px">
                                                <tr>
                                                    <td background="../App_Themes/LOGIN/images/left_menu_1.jpg" style="padding-left: 5px;
                                                        padding-bottom: 5px; border-right: 1px solid #94b7d3">
                                                        <table align="left" border="0" cellpadding="0" cellspacing="0" height="26" width="155px"
                                                            style="margin-right: 5px">
                                                            <tr>
                                                                <td align="left" background="../App_Themes/LOGIN/images/left_name_2.jpg" width="10">
                                                                    <img height="26" src="../App_Themes/LOGIN/images/left_name_1.jpg" width="10" />
                                                                </td>
                                                                <td background="../App_Themes/LOGIN/images/left_name_2.jpg" class="font_11px" width="144">
                                                                    <div style="float: left; size: 10px; width:70px; overflow:hidden; color: #666666;" id="div_User">
                                                                        <%= this.UserName %>
                                                                    </div>
                                                                    <div style="float: left; padding-left: 5px; cursor: pointer" id="div_user_edit">
                                                                        <img src="/images/user_edit.png" alt="Edit" title="Edit" />
                                                                    </div>
                                                                    <div style="float: right; padding-bottom: 3px">
                                                                        <%-- <asp:LinkButton ID="lkLogout" runat="server" ForeColor="Black" OnClientClick="javascript:confirm('Are you sure logout?');" 
                                                   onclick="lkLogout_Click">Logout</asp:LinkButton>--%>
                                                                        <ext:LinkButton ID="lkbtn" runat="server" Cls="LogoutCss" Text="Logout" Width="70px">
                                                                            <DirectEvents>
                                                                                <Click OnEvent="lkbtn_Click">
                                                                                </Click>
                                                                            </DirectEvents>
                                                                        </ext:LinkButton>
                                                                    </div>
                                                                </td>
                                                                <td align="right" background="../App_Themes/LOGIN/images/left_name_2.jpg" width="10">
                                                                    <img height="26" src="../App_Themes/LOGIN/images/left_name_3.jpg" width="8" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table width="155px" id="left_Menu" border="0" align="left" cellpadding="0" cellspacing="0"
                                    style="border-right: 1px solid #94b7d3">
                                    <tr>
                                        <td width="155px" valign="top" background="/App_Themes/LOGIN/images/left_line.jpg"
                                            bgcolor="#ECF5FC" style="padding-left: 5px">
                                         
                                              <%--left menu start--%>
                                            <%=CreateMenu() %>
                                            <%--left menu end--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <!-- left end-->
                            <td style="width: 10px; vertical-align: middle" id="tdCenter">
                                <div class="center" style="background-repeat: no-repeat; background-position: center 170px"
                                    id="tdCenter1">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td colspan="2" id="tdContent" valign="top" class="text_bg" style="padding: 0 0 0 0px;
                width: 100%;">
                <%--content start--%>
                <iframe id="ifmContent" name="ifmContent" frameborder="0" scrolling="auto" src="<%=ifmContentUrl %>"
                    width="100%" height="100%"></iframe>
                <%--content end--%>
            </td>
        </tr>
    </table>
    <ext:Window ID="WinView" runat="server" Resizable="true" Height="422" Title="View"
        Hidden="true" BodyStyle="background-color:#fff" Draggable="true" Width="963px"
        Modal="false" Maximizable="false" Padding="5" X="195" Y="110">
        <LoadMask Msg="Loading..." ShowMask="true" />
        <Listeners>
            <Hide Handler="LoadUrl(this);" />
        </Listeners>
    </ext:Window>
    <div id="div_c" style="position: absolute; z-index: 9; top: 0px; left: 170px; border: solid 1px #7EADD9;
        background-color: #ECF5FC; padding: 5px 10px; display: none;">
        <table>
            <tr>
                <td>
                    Stat
                </td>
                <td style="padding: 0 10px;">
                    <ext:ComboBox ID="cmbStat" runat="server" DisplayField="StatText" ValueField="Stat" Mode="Local"
                        ForceSelection="true" TriggerAction="All" Width="110" Cls="select">
                        <Store>
                            <ext:Store runat="server" ID="storeStat">
                                <Reader>
                                    <ext:JsonReader IDProperty="Stat">
                                        <Fields>
                                            <ext:RecordField Name="CompanyID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="District">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Tel">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Fax">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Email">
                                            </ext:RecordField>
                                            <ext:RecordField Name="DIMFloat">
                                            </ext:RecordField>
                                            <ext:RecordField Name="DIMUnit">
                                            </ext:RecordField>
                                            <ext:RecordField Name="DIMRate">
                                            </ext:RecordField>
                                            <ext:RecordField Name="AddressCHS">
                                            </ext:RecordField>
                                            <ext:RecordField Name="AddressENG">
                                            </ext:RecordField>
                                            <ext:RecordField Name="AWBArrange">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Stat">
                                            </ext:RecordField>
  			                     <ext:RecordField Name="StatText">
                                            </ext:RecordField>
                                            <ext:RecordField Name="NameCHS">
                                            </ext:RecordField>
                                            <ext:RecordField Name="NAMEENG">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ChinaMode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ChineseInvoice">
                                            </ext:RecordField>
                                            <ext:RecordField Name="IsServer">
                                            </ext:RecordField>
                                             <ext:RecordField Name="IsLockStat">
                                            </ext:RecordField>
                                        
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                    </ext:ComboBox>
                </td>
                <td>
                    <ext:Button ID="btnOK" runat="server" Text="Change" Cls="button">
                        <DirectEvents>
                            <Click OnEvent="btnOK_Click">
                                <ExtraParams>
                                    <ext:Parameter Name="CompanyID" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.CompanyID)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="DIMFloat" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.DIMFloat)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="DIMUnit" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.DIMUnit)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="DIMRate" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.DIMRate)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="AddressCHS" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.AddressCHS)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="AddressENG" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.AddressENG)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="AWBArrange" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.AWBArrange)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="Stat" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.Stat)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="StatText" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.StatText)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="NameCHS" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.NameCHS)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="NAMEENG" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.NAMEENG)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="District" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.District)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="Tel" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.Tel)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="Fax" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.Fax)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="Email" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.Email)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="ChinaMode" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.ChinaMode)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="ChineseInvoice" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.ChineseInvoice)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="IsServer" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.IsServer)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                    <ext:Parameter Name="IsLockStat" Value="Ext.encode(#{storeStat}.getById(cmbStat.getValue()).data.IsLockStat)"
                                        Mode="Raw">
                                    </ext:Parameter>
                                </ExtraParams>
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_user" style="background-color: #ECF5FC; border: solid 1px #7EADD9; padding: 10px;
        position: absolute; z-index:99999; left: 170px; top: 0; display: none; width: 250px; height: 250px;">
        <label style="position: absolute; top: 3px; right: 5px; cursor: pointer; display: block;
            color: #0354AD; font-weight: bold; font-size: 18px;" onclick="Usclose();">
            ×
        </label>
        <table width="100%" border="0" cellspacing="0">
            <tr>
                <td colspan="2" style="font-weight: bold; padding-bottom: 10PX; border-bottom: dashed 1px #ddd;
                    font-size: 11px; line-height: 0px; text-indent: 0px;">
                    <ext:Label Icon="UserEdit" Text="User information" runat="server" ID="labUserInformation">
                    </ext:Label>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px; padding-top: 5px;">
                    Name CN
                </td>
                <td style="line-height: 30px; padding-top: 5px;">
                    <ext:TextField ID="txtUserName" runat="server" Cls="font_12px_Arial" Width="150">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px;">
                    Name EN
                </td>
                <td>
                    <ext:TextField ID="txtUserNameen" runat="server" Cls="font_12px_Arial" Width="150">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px;">
                    Tel
                </td>
                <td>
                    <ext:TextField ID="txtUserTel" runat="server" Cls="font_12px_Arial" Width="150">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px;">
                    Ext
                </td>
                <td>
                    <ext:TextField ID="txtUserExt" runat="server" Cls="font_12px_Arial" Width="150">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px;">
                    Fax
                </td>
                <td>
                    <ext:TextField ID="txtUserFax" runat="server" Cls="font_12px_Arial" Width="150">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 30px; text-indent: 8px;">
                    Email
                </td>
                <td>
                    <ext:TextField ID="txtUserEmail" runat="server" Cls="font_12px_Arial" Width="150" StyleSpec="text-transform:none">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="line-height: 40px; text-indent: 8px;">
                    &nbsp;
                </td>
                <td style="line-height: 40px;">
                    <ext:Button ID="btnUserOK" runat="server" Text="OK" Width="60">
                        <DirectEvents>
                            <Click OnEvent="btnUserOK_Click">
                                <EventMask ShowMask="true" Msg="Saving..." />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">

    function openWin() {
        var lot = $('#txtAllNo').val();
        var chkAll = document.getElementById("chkAll").checked ? "chkAll" : "";
        var chkLot = document.getElementById("chkLot").checked ? "chkLot" : "";
        var chkMaster = document.getElementById("chkMaster").checked ? "chkMaster" : "";
        var chkHouse = document.getElementById("chkHouse").checked ? "chkHouse" : "";
        var chkInvoice = document.getElementById("chkInvoice").checked ? "chkInvoice" : "";
        var chkCtnr = document.getElementById("chkCtnr").checked ? "chkCtnr" : "";
        //        var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";
        var chkSO = document.getElementById("chkSO").checked ? "chkSO" : "";

        if (chkAll == "" && chkLot == "" && chkMaster == "" && chkHouse == "" && chkInvoice == "" && chkCtnr == "" && chkSO == "") {
            Ext.MessageBox.alert("Status", "Please select at least one!");
            return;
        }

        if (lot == "") {
            Ext.MessageBox.alert("Status", "No can't be empty!", function () {
                $("#txtAllNo").focus();
            });
        } else {
            //                    USGROUP.MENU_FRAME.LeftLinkClick('/AllSystem/AllShipment.aspx?AllNo=' + lot);
            //        document.getElementById("IfrShipment").src = "";
            document.getElementById("IfrShipment").src = "/AllSystem/AllShipment.aspx?AllNo=" + lot + "&chkAll=" + chkAll + "&chkLot=" + chkLot + "&chkMaster=" + chkMaster + "&chkHouse=" + chkHouse + "&chkInvoice=" + chkInvoice + "&chkCtnr=" + chkCtnr + "&chkSO=" + chkSO;//+"&chkVoid=" + chkVoid

            $("#divShipment").css("display", "block");
            $("#maskShipment").css("display", "block");
            $("#divChkGroup").css("display", "none");
        }
    }

    function daysBetween(DateOne, DateTwo) {
        var OneMonth = DateOne.substring(5, DateOne.lastIndexOf('-'));
        var OneDay = DateOne.substring(DateOne.length, DateOne.lastIndexOf('-') + 1);
        var OneYear = DateOne.substring(0, DateOne.indexOf('-'));
        var TwoMonth = DateTwo.substring(5, DateTwo.lastIndexOf('-'));
        var TwoDay = DateTwo.substring(DateTwo.length, DateTwo.lastIndexOf('-') + 1);
        var TwoYear = DateTwo.substring(0, DateTwo.indexOf('-'));

        var cha = ((Date.parse(OneMonth + '/' + OneDay + '/' + OneYear) - Date.parse(TwoMonth + '/' + TwoDay + '/' + TwoYear)) / 86400000);
        return Math.abs(cha);
    }

    function removeChkClass() {
        $("#chkAll").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkLot").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkMaster").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkHouse").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkInvoice").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkCtnr").parent().eq(0).removeClass("x-form-check-wrap");
        $("#chkSO").parent().eq(0).removeClass("x-form-check-wrap");
    }

    Ext.onReady(function () {
        removeChkClass();
        var myDate = new Date();
        var dateNow = myDate.getFullYear() + '-' + (myDate.getMonth() + 1) + '-' + myDate.getDate();
        if (daysBetween(dateNow, "2017-04-13") <= 30) {
            $("#btnSearch").attr("title", "例: LOT NO:HKGAE1609003 文本框可输入HKGAE1609 或 1609003 (建议号码最少录入4位以上,录入越多，查询结果越精准)");
        } else {
            $("#btnSearch").attr("title", "");
        }

        document.getElementById("chkAll").checked = true;
        document.getElementById("chkLot").checked = true;
        document.getElementById("chkMaster").checked = true;
        document.getElementById("chkHouse").checked = true;
        document.getElementById("chkInvoice").checked = true;
        document.getElementById("chkCtnr").checked = true;
        document.getElementById("chkSO").checked = true;
        $("#divChkGroupTitle").text("All");

        $("#btnCmbChkGroup").click(function () {
            if ($("#divChkGroup").css("display") == "none")
                $("#divChkGroup").css("display", "block");
            else
                $("#divChkGroup").css("display", "none");
        });

	$("#divChkGroup").mouseleave(function () {
                $("#divChkGroup").css("display", "none");
        });

        $("#txtAllNo").keydown(function (event) {
            var e = document.all ? window.event : event;
            if ((e.keyCode || e.which) == 13) {
                openWin();
            }
        });

        $("#btnSearch").click(function () {
            openWin();
        });


        $("#tblChkGroup input[type='checkbox']").click(function () {
            var chkId = $(this).attr("ID");
            var txt = "";

            if (this.checked) {
                if (chkId == "chkAll") {
                    document.getElementById("chkLot").checked = true;
                    document.getElementById("chkMaster").checked = true;
                    document.getElementById("chkHouse").checked = true;
                    document.getElementById("chkInvoice").checked = true;
                    document.getElementById("chkCtnr").checked = true;
                    document.getElementById("chkSO").checked = true;
                    //                    document.getElementById("chkVoid").checked = true;
                    $("#divChkGroupTitle").text("All");
                }
            } else {
                if (chkId == "chkAll") {
                    document.getElementById("chkLot").checked = false;
                    document.getElementById("chkMaster").checked = false;
                    document.getElementById("chkHouse").checked = false;
                    document.getElementById("chkInvoice").checked = false;
                    document.getElementById("chkCtnr").checked = false;
                    document.getElementById("chkSO").checked = false;
                    //                    document.getElementById("chkVoid").checked = false;
                    $("#divChkGroupTitle").text("");
                }
                else {
                    document.getElementById("chkAll").checked = false;
                }
            }


            var chkLot = document.getElementById("chkLot").checked ? "chkLot" : "";
            var chkMaster = document.getElementById("chkMaster").checked ? "chkMaster" : "";
            var chkHouse = document.getElementById("chkHouse").checked ? "chkHouse" : "";
            var chkInvoice = document.getElementById("chkInvoice").checked ? "chkInvoice" : "";
            var chkCtnr = document.getElementById("chkCtnr").checked ? "chkCtnr" : "";
            var chkSO = document.getElementById("chkSO").checked ? "chkSO" : "";
            //            var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";

            if (chkLot == "chkLot" && chkMaster == "chkMaster" && chkHouse == "chkHouse" && chkInvoice == "chkInvoice" && chkCtnr == "chkCtnr" && chkSO == "chkSO") {//&& chkVoid == "chkVoid"
                document.getElementById("chkAll").checked = true;
                $("#divChkGroupTitle").text("All");
            } else {//提示
                if (chkLot == "chkLot")
                    txt += "Lot, ";
                if (chkMaster == "chkMaster")
                    txt += "MAWB/MBL, ";
                if (chkHouse == "chkHouse")
                    txt += "HAWB/HBL, ";
                if (chkInvoice == "chkInvoice")
                    txt += "Invoice, ";
                if (chkCtnr == "chkCtnr")
                    txt += "CTNR, ";
                if (chkSO == "chkSO")
                    txt += "S/O, ";

                if (txt.length > 0)
                    $("#divChkGroupTitle").text(txt.substring(0, txt.length - 2));
                else
                    $("#divChkGroupTitle").text(txt);
            }
        });
    });
</script>
