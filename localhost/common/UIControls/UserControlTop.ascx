<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserControlTop.ascx.cs"
    Inherits="common_UIControls_UserControlTop" %>
    <%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<script src="/common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

<script src="/common/ylQuery/ylQuery.js" type="text/javascript"></script>

<script src="/common/Global/global.js" type="text/javascript"></script>

<script src="/common/Global/TopMenu.js" type="text/javascript"></script>
 <style type="text/css">
        .mask
        {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 1000px;
            z-index: 8 !important;
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
            margin-top: 10px !important;
        }
        
         .chbStyle
        {
            /*margin-right:3px !important;
            width:12px !important;
            height:12px !important;
            vertical-align:middle !important;*/
            float:left; 
            margin-top:4px;
        }
    </style>
<script language="javascript" type="text/javascript">
    function showCombineCost() {
        var seed = Request("seed");
        if (seed == "") { seed = Request("HBL") }
        CompanyX.UserControlTop1.ShowLink('Combine Cost', '700,560,/common/Cost/CostingSearch.aspx?postseed=' + seed);
    }
    function Request(paramName) {
        paramValue = "";
        isFound = false;
        if (this.location.search.indexOf("?") == 0 && this.location.search.indexOf("=") > 1) {
            arrSource = unescape(this.location.search).substring(1, this.location.search.length).split("&");
            i = 0;
            while (i < arrSource.length && !isFound) {
                if (arrSource[i].indexOf("=") > 0) {
                    if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                        paramValue = arrSource[i].split("=")[1];
                        isFound = true;
                    }
                }
                i++;
            }
        }
        return paramValue;
    }
</script>
<link href="../../css/menu.css" rel="stylesheet" type="text/css" />
<div style="padding-bottom: 10px;">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td style="padding-left: 10px; padding-right: 10px; background:#000" width="220">
                <a href="/mframe/index.aspx">
                    <img src="../../images/logo.png" width="220" height="50" /></a>
                    <span style="position: absolute; z-index: 555; top: 5px; left: 0px; width: 970px;
                                height: 25px; text-align: center;" id="AllSearch"><span class="menu_btn"><a href="javascript:void(0);"
                                id="btnSearch" style="float: right; font-size: 10px !important;
                                    margin-left: 2px; margin-top: 7px !important;">Search</a> </span>
                        <span style="background-image:url('/images/ico.png'); position: absolute; 
                                    z-index: 555; top: 10px; left: 776px; width: 15px; height:16px;" id="btnCmbChkGroup"></span>  
                        <span id="divChkGroupTitle" style="color: white;font-size: 10px;position: absolute; top: 11px; right: 198px;font-weight:bold;font-family:Verdana;"></span>          
                        <span>
                            <ext:TextField ID="txtAllNo" runat="server" Cls="txtStyle" Width="105" style=" margin-top:6px;">
                            </ext:TextField>
                        </span>
                        <span id="divChkGroup" style="display:none;width:103px;position: absolute; z-index:9999; top: 26px; left: 684px; 
                                                 background-color:white; border-color:#98c0f4 !important; border:1px solid;">
                                        <ext:CheckboxGroup ID="tblChkGroup" runat="server" ColumnsNumber="1">
                                             <Items>
                                                <ext:Checkbox ID="chkAll" BoxLabel="All" runat="server" Tag="all" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkLot" BoxLabel="Lot" runat="server" Tag="lot" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkMaster" BoxLabel="MAWB/MBL" runat="server" Tag="master" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkHouse" BoxLabel="HAWB/HBL" runat="server" Tag="house" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkInvoice" BoxLabel="Invoice" runat="server" Tag="invoice" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkCtnr" BoxLabel="CTNR" runat="server" Tag="ctnr" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkSO" BoxLabel="S/O" runat="server" Tag="s/o" Cls="chbStyle" BoxLabelCls="chbStyle">
                                                </ext:Checkbox>
                                           <%--     <ext:Checkbox ID="chkVoid" BoxLabel="Void" runat="server" Tag="void" LabelAlign="Right">
                                                </ext:Checkbox>--%>
                                            </Items>
                                        </ext:CheckboxGroup>
                                    </span></span>
                            <div id="maskShipment" class="mask">
                            </div>
                            <div id="divShipment" style="position: absolute; z-index: 100; top: 35px; left: 10px;
                                width: 998px; height: 660px; display: none;">
                                <iframe id="IfrShipment" name="IfrShipment" frameborder="0" width="100%" height="100%"
                                    style="background-color: White;"></iframe>
                            </div>
            </td>
            <td align="left" bgcolor="" id="top_Menu1" style="background-color: #000; height: 70px;
                vertical-align: bottom; padding-left: 4px;">
                <%-- nav start--%>
                <%=this.GetMenuList(sys)%>
                <%-- nav end --%>
            </td>
        </tr>
    </table>
    
  <ext:Window ID="WinView" runat="server" Resizable="true" Height="422" Title="View"
        Hidden="true" BodyStyle="background-color:#fff" Draggable="true" Width="963px"
        Modal="false" Maximizable="false" Padding="5" X="195" Y="110" Shadow="None">
        <LoadMask Msg="Loading..." ShowMask="true" />
        <Listeners>
            <Hide Handler="LoadUrl(this);" />
        </Listeners>
    </ext:Window>
</div>
  <script type="text/javascript">

      function openWin() {
          var lot = $('#UserControlTop1_txtAllNo').val();
          var chkAll = document.getElementById("UserControlTop1_chkAll").checked ? "chkAll" : "";
          var chkLot = document.getElementById("UserControlTop1_chkLot").checked ? "chkLot" : "";
          var chkMaster = document.getElementById("UserControlTop1_chkMaster").checked ? "chkMaster" : "";
          var chkHouse = document.getElementById("UserControlTop1_chkHouse").checked ? "chkHouse" : "";
          var chkInvoice = document.getElementById("UserControlTop1_chkInvoice").checked ? "chkInvoice" : "";
          var chkCtnr = document.getElementById("UserControlTop1_chkCtnr").checked ? "chkCtnr" : "";
          //        var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";
          var chkSO = document.getElementById("UserControlTop1_chkSO").checked ? "chkSO" : "";

          if (chkAll == "" && chkLot == "" && chkMaster == "" && chkHouse == "" && chkInvoice == "" && chkCtnr == "" && chkSO == "") {
              Ext.MessageBox.alert("Status", "Please select at least one!");
              return;
          }

          if (lot == "") {
              Ext.MessageBox.alert("Status", "No can't be empty!", function () {
                  $("#UserControlTop1_txtAllNo").focus();
              });
          } else {
              //                    USGROUP.MENU_FRAME.LeftLinkClick('/AllSystem/AllShipment.aspx?AllNo=' + lot);
              //        document.getElementById("IfrShipment").src = "";
              document.getElementById("IfrShipment").src = "/AllSystem/AllShipment.aspx?AllNo=" + lot + "&chkAll=" + chkAll + "&chkLot=" + chkLot + "&chkMaster=" + chkMaster + "&chkHouse=" + chkHouse + "&chkInvoice=" + chkInvoice + "&chkCtnr=" + chkCtnr + "&chkSO=" + chkSO; //+"&chkVoid=" + chkVoid

              $("#divShipment").css("display", "block");
              window.parent.$("#maskShipment").css("display", "block");
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
          $("#UserControlTop1_chkAll").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkLot").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkMaster").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkHouse").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkInvoice").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkCtnr").parent().eq(0).removeClass("x-form-check-wrap");
          $("#UserControlTop1_chkSO").parent().eq(0).removeClass("x-form-check-wrap");
      }

      Ext.onReady(function () {
          removeChkClass();
          // $("#UserControlTop1_ChkGrpStat input, #UserControlTop1_tblChkGroup input, #UserControlTop1_tblChkGroup_Container input").addClass("chbStyle");
          var myDate = new Date();
          var dateNow = myDate.getFullYear() + '-' + (myDate.getMonth() + 1) + '-' + myDate.getDate();
          if (daysBetween(dateNow, "2017-04-13") <= 30) {
              $("#btnSearch").attr("title", "例: LOT NO:HKGAE1609003 文本框可输入HKGAE1609 或 1609003 (建议号码最少录入4位以上,录入越多，查询结果越精准)");
          } else {
              $("#btnSearch").attr("title", "");
          }

          document.getElementById("UserControlTop1_chkAll").checked = true;
          document.getElementById("UserControlTop1_chkLot").checked = true;
          document.getElementById("UserControlTop1_chkMaster").checked = true;
          document.getElementById("UserControlTop1_chkHouse").checked = true;
          document.getElementById("UserControlTop1_chkInvoice").checked = true;
          document.getElementById("UserControlTop1_chkCtnr").checked = true;
          document.getElementById("UserControlTop1_chkSO").checked = true;

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

          $("#UserControlTop1_txtAllNo").keydown(function (event) {
              var e = document.all ? window.event : event;
              if ((e.keyCode || e.which) == 13) {
                  openWin();
              }
          });

          $("#btnSearch").click(function () {
              openWin();
          });


          $("#UserControlTop1_tblChkGroup input[type='checkbox']").click(function () {
              var chkId = $(this).attr("ID");
              var txt = "";

              if (this.checked) {
                  if (chkId == "UserControlTop1_chkAll") {
                      document.getElementById("UserControlTop1_chkLot").checked = true;
                      document.getElementById("UserControlTop1_chkMaster").checked = true;
                      document.getElementById("UserControlTop1_chkHouse").checked = true;
                      document.getElementById("UserControlTop1_chkInvoice").checked = true;
                      document.getElementById("UserControlTop1_chkCtnr").checked = true;
                      document.getElementById("UserControlTop1_chkSO").checked = true;

                      $("#divChkGroupTitle").text("All");
                      //                    document.getElementById("chkVoid").checked = true;
                  }
              } else {
                  if (chkId == "UserControlTop1_chkAll") {
                      document.getElementById("UserControlTop1_chkLot").checked = false;
                      document.getElementById("UserControlTop1_chkMaster").checked = false;
                      document.getElementById("UserControlTop1_chkHouse").checked = false;
                      document.getElementById("UserControlTop1_chkInvoice").checked = false;
                      document.getElementById("UserControlTop1_chkCtnr").checked = false;
                      document.getElementById("UserControlTop1_chkSO").checked = false;
                      $("#divChkGroupTitle").text("");
                      //                    document.getElementById("chkVoid").checked = false;
                  }
                  else {
                      document.getElementById("UserControlTop1_chkAll").checked = false;
                  }
              }

              var chkLot = document.getElementById("UserControlTop1_chkLot").checked ? "chkLot" : "";
              var chkMaster = document.getElementById("UserControlTop1_chkMaster").checked ? "chkMaster" : "";
              var chkHouse = document.getElementById("UserControlTop1_chkHouse").checked ? "chkHouse" : "";
              var chkInvoice = document.getElementById("UserControlTop1_chkInvoice").checked ? "chkInvoice" : "";
              var chkCtnr = document.getElementById("UserControlTop1_chkCtnr").checked ? "chkCtnr" : "";
              //            var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";
              var chkSO = document.getElementById("UserControlTop1_chkSO").checked ? "chkSO" : "";

              if (chkLot == "chkLot" && chkMaster == "chkMaster" && chkHouse == "chkHouse" && chkInvoice == "chkInvoice" && chkCtnr == "chkCtnr" && chkSO == "chkSO") {//&& chkVoid == "chkVoid"
                  document.getElementById("UserControlTop1_chkAll").checked = true;
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
