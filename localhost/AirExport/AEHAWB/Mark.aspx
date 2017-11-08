<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Mark.aspx.cs" Inherits="AirExport_AEHAWB_Mark" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/AE_HAWB.css" rel="stylesheet" type="text/css" />

    <%--<script src="../../JS/AE.js" type="text/javascript"></script>--%>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="base.js"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <style type="text/css">
        .x-form-text, textarea.x-form-field
        {
            background-image: none;
            border-color: White;
        }
        .select
        {
            border-color: #B5B8C8;
            background-image: url("/extjs/resources/images/default/form/text-bg-gif/ext.axd");
        }
        
        .td-padding
        {
            padding-top:0px;
            cursor:default;
        }
        
        .font-10
        {
            font-size:10px;
            color:#b9b9b9;
        }
        
        .font-style
        {
            font-size:11px !important;
            font-family:Courier New !important;
        }
       
       .lab-style
       {
           background-color:transparent;
           line-height:11px;
       }
       
    </style>

    <script type="text/javascript">
        function ShipperColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 5; ++i) {

                $("#txtShipper" + i).css("color", color);
            }
        }

        function ConsigneeColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 5; ++i) {

                $("#txtConsignee" + i).css("color", color);
            }
        }

        function DimensionsColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 6; ++i) {

                $("#txtLine" + i).css("color", color);
            }
        }

        function DescriptionColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 6; i <= 14; ++i) {

                $("#txtLineAll" + i).css("color", color);
            }
        }

        function vwt(obj) {

            if (Number(obj.getValue()) > Number(txtVWT.getValue()))
            { txtCWT1.setValue(formatNumber(obj.getValue(), "###.000#")); }
            else {
                txtCWT1.setValue(formatNumber(txtVWT.getValue(), "###.000#"))
            }
        }

        function SetRateMark() {
            var chkItem = window.parent.$("#chkItem1").val();
            var txtWTPPD = window.parent.$("#txtWTPPD").val();
            var txtWTColl = window.parent.$("#txtWTColl").val();
            CompanyX.SetRateMark(chkItem, txtWTPPD, txtWTColl);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
     <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
     <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidType" runat="server">
    </ext:Hidden>
    <%-- <ext:Hidden ID="hidItem" runat="server">
    </ext:Hidden>
     <ext:Hidden ID="hidWTPPD" runat="server">
    </ext:Hidden>
     <ext:Hidden ID="hidWTColl" runat="server">
    </ext:Hidden>--%>
    <div style="height:215px;  overflow-y:scorll;  overflow-x:hidden; ">
        <table border="0" cellpadding="0" cellspacing="0" width="681px" style="height:200px; margin-top:10px; margin-left:5px; " id="tableMark">
            <tr>
                <td rowspan="2">
                  <%--  <table border="0" cellpadding="0" cellspacing="0"  style=" width:15px; height:542px;  ">
                        <tr>
                             <td class="font-10 left-style" style="height:17px;" align="right">
                                01
                            </td>
                        </tr>
                        <tr>
                            <td style="height:4px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" style="" align="right">
                                02
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                03
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                04
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                05
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                06
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                07
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                08
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                09
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                10
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                11
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                12
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                13
                            </td>
                        </tr>
                           <tr>
                            <td style="height:5px;">
                            </td>
                        </tr>
                         <tr>
                             <td class="font-10 left-style" align="right">
                                14
                            </td>
                        </tr>
                         <tr>
                             <td style="height:325px;" >
                              
                            </td>
                        </tr>
                    </table>--%>
                     <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style=" height:1px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:TextArea ID="txtLineLeft" runat="server" Disabled="true" Width="18px" Height="545px" style="overflow-y:hidden; font-family:Courier New; font-size:12px;" >
                                </ext:TextArea>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width:442px; height:14px;border:1px solid #000000;">
                  <%--  <table border="0" cellpadding="0" cellspacing="0"  style="width:592px; height:20px;">
                         <tr>
                            <td width="52px" valign="top" bgcolor="#FFFFFF" class="font_11bold td-padding"
                                style="padding-left: 1px; ">
                                <ext:NumberField ID="txtRCP1" Cls="text_45" TabIndex="1" runat="server" Width="50"
                                    DecimalPrecision="0" StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRCP1')" />
                                        <Blur Handler="out_text('txtRCP1')" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td valign="top" align="left" bgcolor="#FFFFFF" class="font_11bold td-padding">
                                <ext:TextField ID="txtGWT1" Cls="text_45" TabIndex="2" runat="server" Width="78"
                                    StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtGWT1')" />
                                        <Blur Handler="out_text('txtGWT1');FormatNum(this,3); SetRateMark();" />
                                        <Change Handler="vwt(this);sumTotal();CheckListMark();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" valign="top" bgcolor="#FFFFFF" class="font_11bold td-padding boder_line_04">
                                <ext:TextField ID="txtUnit1" Cls="text_45" TabIndex="3" runat="server" Width="8"
                                    MaxLength="3">
                                    <Listeners>
                                        <Focus Handler="over_text('txtUnit1')" />
                                        <Blur Handler="out_text('txtUnit1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" valign="top" align="left" class="font_11bold td-padding" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: left; background-repeat: repeat-y">
                                <ext:TextField ID="txtRateClass1" Cls="text_45" TabIndex="4" runat="server" Width="20px"
                                    MaxLength="2">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRateClass1')" />
                                        <Blur Handler="out_text('txtRateClass1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" class="boder_line_04 td-padding" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: right; background-repeat: repeat-y">
                                <ext:TextField ID="txtItem1" Cls="text_45" TabIndex="5" runat="server" Width="92"
                                    MaxLength="9">
                                    <Listeners>
                                        <Focus Handler="over_text('txtItem1')" />
                                        <Blur Handler="out_text('txtItem1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="font_11bold td-padding"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                background-repeat: repeat-y">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width: 88px">
                                            <ext:TextField ID="txtCWT1" Cls="text_45" TabIndex="6" runat="server" Width="87"
                                                StyleSpec="text-align:right;margin-right:3px">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCWT1')" />
                                                    <Blur Handler="out_text('txtCWT1');FormatNum(this,3);SetRateMark();" />
                                                    <Change Handler="sumTotal();CheckListMark();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtVWT" runat="server" Hidden="true">
                                            </ext:TextField>
                                        </td>
                                        <td valign="middle" class="x-form-text x-form-field text_45">
                                            <span class="text_45">K</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" valign="top" align="left" bgcolor="#FFFFFF" class="font_11bold td-padding"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                width: 108px; background-repeat: repeat-y">
                                <ext:TextField ID="txtRate1" Cls="text_45" TabIndex="7" runat="server" Width="100"
                                    StyleSpec="text-align:right;margin-right:8px;">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRate1')" />
                                        <Blur Handler="out_text('txtRate1');FormatNum(this,3);" />
                                        <Change Handler="sumTotal();CheckListMark();" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:TextField ID="txtRate2" runat="server" Width="113" Hidden="true" Disabled="true"
                                    Cls="text_45" Text="AS ARRANGE">
                                </ext:TextField>
                            </td>
                            <td valign="top" align="left" bgcolor="#FFFFFF" class="td-padding">
                                <table cellpadding="0" cellspacing="0" border="0" width="120">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtTotal1" Cls="text_45" TabIndex="8" runat="server" Width="120"
                                                StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTotal1')" />
                                                    <Blur Handler="out_text('txtTotal1');" />
                                                    <Change Handler="FormatNum(this,2);CheckListMark();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtTotal11" runat="server" Cls="text_45" Width="120" Disabled="true"
                                                Hidden="true">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>--%>
                      <table border="0" cellpadding="0" cellspacing="0"  style="width:442px; height:14px;">
                         <tr>
                            <td width="36px" valign="bottom" bgcolor="#FFFFFF" class="font_11bold td-padding" align="right"
                                style="padding-left: 1px; ">
                                <%--<ext:NumberField ID="txtRCP1" Cls="text_45" TabIndex="1" runat="server" Width="50"
                                    DecimalPrecision="0" StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRCP1')" />
                                        <Blur Handler="out_text('txtRCP1')" />
                                    </Listeners>
                                </ext:NumberField>--%>
                                <ext:Label ID="txtRCP1" Cls="lab-style font-style" runat="server" Width="35" ></ext:Label>
                            </td>
                            <td valign="bottom" align="right" bgcolor="#FFFFFF" class="font_11bold td-padding" width="57px">
                              <%--  <ext:TextField ID="txtGWT1" Cls="text_45" TabIndex="2" runat="server" Width="78"
                                    StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtGWT1')" />
                                        <Blur Handler="out_text('txtGWT1');FormatNum(this,3); SetRateMark();" />
                                        <Change Handler="vwt(this);sumTotal();CheckListMark();" />
                                    </Listeners>
                                </ext:TextField>--%>
                                     <ext:Label ID="txtGWT1" Cls="lab-style font-style" runat="server" Width="56"></ext:Label>
                            </td>
                            <td align="left" valign="bottom" bgcolor="#FFFFFF" class="font_11bold td-padding boder_line_04" width="8px">
                             <%--   <ext:TextField ID="txtUnit1" Cls="text_45" TabIndex="3" runat="server" Width="8"
                                    MaxLength="3">
                                    <Listeners>
                                        <Focus Handler="over_text('txtUnit1')" />
                                        <Blur Handler="out_text('txtUnit1')" />
                                    </Listeners>
                                </ext:TextField>--%>
                                 <ext:Label ID="txtUnit1" Cls="lab-style font-style" runat="server" Width="8"></ext:Label>
                            </td>
                            <td colspan="2" valign="bottom" align="left" class="font_11bold td-padding" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: left; background-repeat: repeat-y" width="18px">
                            <%--    <ext:TextField ID="txtRateClass1" Cls="text_45" TabIndex="4" runat="server" Width="20px"
                                    MaxLength="2">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRateClass1')" />
                                        <Blur Handler="out_text('txtRateClass1')" />
                                    </Listeners>
                                </ext:TextField>--%>
                                <table border="0" cellpadding="0" cellspacing="0" style=" width:18px;">
                                    <tr>
                                        <td align="center">
                                            <ext:Label ID="txtRateClass1" Cls="lab-style font-style"  runat="server" Width="18" StyleSpec="padding-left:3px;" ></ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" align="left" valign="bottom" class="boder_line_04 td-padding" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: right; background-repeat: repeat-y" width="63px">
                              <%--  <ext:TextField ID="txtItem1" Cls="text_45" TabIndex="5" runat="server" Width="92"
                                    MaxLength="9">
                                    <Listeners>
                                        <Focus Handler="over_text('txtItem1')" />
                                        <Blur Handler="out_text('txtItem1')" />
                                    </Listeners>
                                </ext:TextField>--%>
                                  <table border="0" cellpadding="0" cellspacing="0" style=" width:63px;">
                                    <tr>
                                        <td align="center">          
                                            <ext:Label ID="txtItem1" Cls="lab-style font-style"  runat="server" Width="63"></ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" align="right" valign="bottom" bgcolor="#FFFFFF" class="font_11bold td-padding"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                background-repeat: repeat-y" width="78px">
                                <table cellpadding="0" cellspacing="0" border="0" width="78px"  valign="bottom">
                                    <tr>
                                        <td style="width: 65px" align="right" valign="bottom" >
                                            <%--<ext:TextField ID="txtCWT1" Cls="text_45" TabIndex="6" runat="server" Width="87"
                                                StyleSpec="text-align:right;margin-right:3px">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCWT1')" />
                                                    <Blur Handler="out_text('txtCWT1');FormatNum(this,3);SetRateMark();" />
                                                    <Change Handler="sumTotal();CheckListMark();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtVWT" runat="server" Hidden="true">
                                            </ext:TextField>--%>
                                            <ext:Label ID="txtCWT1" Cls="lab-style font-style" TabIndex="6" runat="server" Width="65" ></ext:Label>
                                            <ext:Label ID="txtVWT" runat="server" Hidden="true"></ext:Label>
                                        </td>
                                        <td valign="bottom" class=" lab-style">
                                            <span class="lab-style font-style" style="padding-left:2px;">K</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" valign="bottom"  align="right" bgcolor="#FFFFFF" class="font_11bold td-padding"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                width: 80px; background-repeat: repeat-y">
                               <%-- <ext:TextField ID="txtRate1" Cls="text_45" TabIndex="7" runat="server" Width="100"
                                    StyleSpec="text-align:right;margin-right:8px;">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRate1')" />
                                        <Blur Handler="out_text('txtRate1');FormatNum(this,3);" />
                                        <Change Handler="sumTotal();CheckListMark();" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:TextField ID="txtRate2" runat="server" Width="113" Hidden="true" Disabled="true"
                                    Cls="text_45" Text="AS ARRANGE">
                                </ext:TextField>--%>
                                <table border="0" cellpadding="0" cellspacing="0" style="width:80px;" >
                                    <tr>
                                        <td align="right">
                                        <ext:Label ID="txtRate1" Cls="lab-style font-style"  runat="server" Width="78" StyleSpec="padding-right:10px;" ></ext:Label>
                                        <ext:Label ID="txtRate2" runat="server" Width="78" Hidden="true" Disabled="true"
                                            Cls="lab-style font-style" Text="AS ARRANGE"></ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="bottom" align="right" bgcolor="#FFFFFF" class="td-padding">
                                <table cellpadding="0" cellspacing="0" border="0" width="100">
                                    <tr>
                                        <td  align="right" style="padding-right:2px;">
                                         <%--   <ext:TextField ID="txtTotal1" Cls="text_45" TabIndex="8" runat="server" Width="120"
                                                StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTotal1')" />
                                                    <Blur Handler="out_text('txtTotal1');" />
                                                    <Change Handler="FormatNum(this,2);CheckListMark();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtTotal11" runat="server" Cls="text_45" Width="120" Disabled="true"
                                                Hidden="true">
                                            </ext:TextField>--%>
                                <ext:Label ID="txtTotal1" Cls="lab-style font-style"  runat="server" Width="100"></ext:Label>
                                <ext:Label ID="txtTotal11" runat="server" Cls="lab-style font-style" Width="100" Disabled="true" Hidden="true"></ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                 <td rowspan="2" style=" width:10px; "  bgcolor="#FFFFFF">
                
                </td>
                <td rowspan="2" style="width:208px;border:1px solid #000000; height:550px;">
              <%--  <ext:TextArea ID="txtLine" runat="server"  Width="272px"   Height="545px" style="font-family:Courier New, Courier, monospace; font-size:16px;word-wrap:break-word;word-break:break-all; overflow-y:hidden;" TabIndex="10">
                   
                </ext:TextArea>--%>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style=" height:1px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                               <ext:TextArea ID="txtLine" runat="server"  TabIndex="10" Width="208px" Height="545px" style="overflow-y:hidden;font-family:Courier New;">
                                   <Listeners>
                                    <Change Handler="CompanyX.SetStrLine();"/>
                                  </Listeners>
                               </ext:TextArea>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr >
                <td  style="width:442px; border:1px solid #000000; border-top:0px !important; height:530px;">
            
                <%-- <ext:TextArea ID="txtLineAll" runat="server" EnableKeyEvents="true"  LabelAlign="Top" Width="588px" Height="530px" style="font-family:droid_sans_monoregular; font-size:16px;word-wrap:break-word;word-break:break-all; overflow-y:hidden; " TabIndex="9" >
                <Listeners>--%>
                <%--  <KeyPress Handler="textCounter(document.getElementById('txtLineAll'), 10, 5);" />--%>
               <%--  <Change Handler="alert('aa');" />--%>
               <%-- </Listeners>
                </ext:TextArea>--%>

                    <ext:TextArea ID="txtLineAll" runat="server"  TabIndex="9" Width="442px" Height="530px" style="overflow-y:hidden; font-family:Courier New;"  >
                      <Listeners>
                        <Change Handler="CompanyX.SetStrLineAll();" />
                      </Listeners>
                    </ext:TextArea>

                <%-- <textarea id="txtLineAll" rows="29" cols="61" style="font-family:Courier New, Courier, monospace; font-size:16px;overflow-x:hidden; overflow-y:hidden; border:0px; "></textarea>--%>
                </td>
            </tr>
             <tr style=" height:3px;"></tr>
          
        </table>
    </div>
                <div id="divSave" style=" z-index:2;width:705px; height:38px; position:fixed;  top:215px;  border-top:1px solid #8DB2E3; background-color:White;" align="right">
            <ext:Button ID="btnSave" Text="OK" runat="server" Width="60" TabIndex="11" StyleSpec=" margin-top:6px; margin-right:10px;">
                <Listeners>
                    <Click Handler="saveData();" />
                </Listeners>
            </ext:Button>
            </div>
    </form>
</body>
</html>

  <script type="text/javascript">
      Ext.onReady(function () {
          $("#txtLineLeft").text("0102030405060708091011121314");

          window.parent.window.document.body.style.overflow = "hidden";
          setAllText("txtRCP1", txtRCP1, 5);
          setAllText("txtGWT1", txtGWT1, 8);
          setAllText("txtUnit1", txtUnit1, 1);
          setAllText("txtRateClass1", txtRateClass1, 2);
          setAllText("txtItem1", txtItem1, 9);
          setAllText("txtCWT1", txtCWT1, 9);
          setAllText("txtVWT", txtVWT, 9);
          setAllText("txtRate1", txtRate1, 10);
          setAllText("txtRate2", txtRate2, 11);
          setAllText("txtTotal1", txtTotal1, 15);
          setAllText("txtTotal11", txtTotal11, 15);
          getTxtLine();
          getTxtLineAll();
      });

      //给窗体赋值 num是显示的字符数 不然会变更宽度
      function setAllText(obj, extObj, num) {

          $("#" + obj).text(window.parent.$("#" + obj).val().substr(0, num));
          //alert(extObj + ":" + window.parent.$("#" + obj).val() + "," + window.parent.$("#" + obj).hasClass("x-item-disabled"));
          if (window.parent.$("#" + obj).hasClass("x-hide-display")) {
              extObj.hide();
          } else {
              extObj.show();
          }

          if (window.parent.$("#" + obj).hasClass("x-item-disabled")) {
              $("#" + obj).addClass("x-item-disabled").attr("disabled", "disabled").css("cursor", "default");
          } else {
              $("#" + obj).removeClass("x-item-disabled").attr("disabled", "");
          }
      }

      function getTxtLine() {
          var txtLine = "";
          for (var i = 1; i <= 14; i++) {
              if (i < 14) {
                  txtLine = txtLine + window.parent.$("#txtLine" + i).val() + "\r\n";
              } else {
                  txtLine = txtLine + window.parent.$("#txtLine" + i).val();
              }
          }

          $("#txtLine").val(txtLine);
      }

      function getTxtLineAll() {
          var txtLineAll = "";
          for (var i = 1; i <= 13; i++) {
              if (i < 13) {
                  txtLineAll = txtLineAll + window.parent.$("#txtLineAll" + i).val() + "\r\n";
              } else {
                  txtLineAll = txtLineAll + window.parent.$("#txtLineAll" + i).val();
              }
          }

          $("#txtLineAll").val(txtLineAll);
      }

      //给父页面赋值
      function setParAllText(obj) {
          window.parent.$("#" + obj).val($("#" + obj).text());
      }

      function setParTxtLine() {
          //            var txtLine = document.getElementById("txtLine").value;
          var txtLine = $("#txtLine").val();
          if (txtLine == "") {
              for (var i = 1; i <= 14; i++) {
                  window.parent.$("#txtLine" + i).val("");
              }
              return;
          }
          var str = new Array();
          str = txtLine.split("\n");
          var line = 1;
          for (i = 0; i <= 13; i++) {
              if (i < str.length) {
                  if (str[i].length > 28) {
                      var s1 = str[i].substring(0, 28);
                      var s2 = str[i].substring(28, str[i].length); //这里是截取文本域中自动换行的时候超过28的长度的部分
                      window.parent.$("#txtLine" + line).val(s1);
                      line++;
                      window.parent.$("#txtLine" + line).val(s2);
                      line++;
                  } else {
                      window.parent.$("#txtLine" + line).val(str[i]);
                      line++;
                  }
              } else {
                  window.parent.$("#txtLine" + (i + 1)).val("");
              }
          }
      }


      function setParTxtLineAll() {
          //            var txtLine = document.getElementById("txtLine").value;
          var txtLineAll = $("#txtLineAll").val();
          if (txtLineAll == "") {
              for (var i = 1; i <= 13; i++) {
                  window.parent.$("#txtLineAll" + i).val("");
              }
              return;
          }

          var str = new Array();
          str = txtLineAll.split("\n");//这里是获得有内容的行数
          var line = 1;
          for (i = 0; i <= 12; i++) {
              if (i < str.length) {
                  if (str[i].length > 61) {
                      var s1 = str[i].substring(0, 61);
                      var s2 = str[i].substring(61, str[i].length); //这里是截取文本域中自动换行的时候超过61的长度的部分
                      window.parent.$("#txtLineAll" + line).val(s1);
                      line++;
                      window.parent.$("#txtLineAll" + line).val(s2);
                      line++;
                  } else {
                      window.parent.$("#txtLineAll" + line).val(str[i]);
                      line++;
                  }
              } else { //给没有任何内容的行赋值
                  window.parent.$("#txtLineAll" + (i + 1)).val("");
              }
          }
      }

      function saveData() {
          setParAllText("txtRCP1");
          setParAllText("txtGWT1");
          setParAllText("txtUnit1");
          setParAllText("txtRateClass1");
          setParAllText("txtItem1");
          setParAllText("txtCWT1");
          setParAllText("txtVWT");
          setParAllText("txtRate1");
          setParAllText("txtRate2");
          setParAllText("txtTotal1");
          setParAllText("txtTotal11");
          setParTxtLine();
          setParTxtLineAll();
          window.parent.window.document.body.style.overflow = "auto";
          window.parent.WindowMark.hide();
          //            window.parent.WindowMark.destroy();
      }
    </script>
