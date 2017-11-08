<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllShipment.aspx.cs" Inherits="AllSystem_AllShipment" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AllShipment</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <style type="text/css"> 
        .tipLeft
        {
            left:14px !important;
            background-color:#ffffff;
        }
        
        .rowStyle
        {
            float:left;
            font-size:10px;
            font-family :Verdana, Arial, Helvetica, sans-serif;
            font-weight:100;   
            height:19px;
         }
             
        .load {       
            position: absolute; 
            width:100%; height:100%; 
            z-index: 9999 !important;      
            text-align:center; 
            display:none;
            background:#ccc; 
            filter:alpha(Opacity=50);
            -moz-opacity:0.5;
            opacity: 0.5;
             
        } 
    </style>
    <script type="text/javascript">
    function closeShipment() {
        window.parent.$('#divShipment').css('display', 'none');
        window.parent.$("#maskShipment").css("display", "none");
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
       <ext:Hidden ID="hidChbStr" runat="server"></ext:Hidden>
    <div style="width: 970px; margin-top: 10px; margin-left: 13px;">
        <div style=" display:none;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" height="25px">
                            <tr>
                                <td>
                                    All System Search
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 35px;">
           <div style="width:50px;float:left;padding-top:11px;">Filter</div>
        <div style="float:left;">
            <ext:CheckboxGroup ID="tblChkGroup" runat="server" LabelAlign="Right" >
                <Items>
                    <ext:Checkbox ID="chkAll" BoxLabel="All" runat="server" Tag="all" LabelAlign="Right" >
                    </ext:Checkbox>
                   <%-- <ext:Checkbox ID="chkLot" BoxLabel="Lot" runat="server" Tag="lot" LabelAlign="Right"
                        LabelWidth="45">
                    </ext:Checkbox>--%>
                    <ext:Checkbox ID="chkMaster" BoxLabel="Master" runat="server" Tag="master" LabelAlign="Right" >
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkHouse" BoxLabel="House" runat="server" Tag="house" LabelAlign="Right" >
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkInvoice" BoxLabel="Invoice" runat="server" Tag="invoice" LabelAlign="Right" >
                    </ext:Checkbox>
                    <ext:Checkbox ID="chkCtnr" BoxLabel="CTNR" runat="server" Tag="ctnr" LabelAlign="Right">
                    </ext:Checkbox>
                      <ext:Checkbox ID="chkVoid" BoxLabel="Void" runat="server" Tag="void" LabelAlign="Right">
                    </ext:Checkbox>
                </Items>
            </ext:CheckboxGroup>
            </div>
          
            <div style="float:right;"><label id="close" onclick="closeShipment();" style=" font-size:12px; font-weight:bold; cursor: pointer; vertical-align:bottom;">×</label></div>
        </div>
        <div id="divLoadMaskAllShipment" class="load"></div>
        <div id="divLoadAllShipment" style="width:130px;position:absolute; top:50%; left:460px; z-index: 99999 !important; display:none;">
            <div style="background-image:url('/extjs/resources/images/default/grid/loading-gif/ext.axd'); background-repeat:no-repeat; float:left; width:25px; height:30px;"></div>
            <div style="float:left; width:100px;"> Loading... </div>
        </div>
        <div>
            <ext:GridPanel ID="gridList" runat="server" Width="970px" TrackMouseOver="true" Height="600"
                StripeRows="true" ColumnLines="True">
                <LoadMask ShowMask="true" Msg=" Loading..." />
                <Store>
                     <ext:Store runat="server" ID="storeList" OnRefreshData="storeList_OnRefreshData"
                        AutoLoad="true">
                        <AutoLoadParams>
                            <ext:Parameter Name="start" Value="={0}" />
                            <ext:Parameter Name="limit" Value="={100}" />
                        </AutoLoadParams>
                        <Reader>
                            <ext:JsonReader IDProperty="RowID">
                                <Fields>
                                    <ext:RecordField Name="type" Type="String">
                                    </ext:RecordField>
                                      <ext:RecordField Name="active" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="allDate" Type="Date">
                                    </ext:RecordField>
                                    <ext:RecordField Name="lotNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="masterNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="houseNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="invoiceNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="ctnrNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="actions" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="flightNo" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="pol" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="pod" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="sales" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="gwt" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="vwt" Type="String">
                                    </ext:RecordField>
                                    <ext:RecordField Name="cwt" Type="String">
                                    </ext:RecordField>
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server" ID="ColumnModel1">
                    <Columns>
                        <ext:Column Header="Type" DataIndex="type" Width="40" Align="Center">
                        </ext:Column>
                         <ext:Column Header="Void" DataIndex="active" Width="50"  Align="Center">
                        </ext:Column>
                        <ext:DateColumn Header="Date" DataIndex="allDate" Width="88" Format="dd/MM/yyyy"
                            Align="Center">
                        </ext:DateColumn>
                        <ext:Column Header="Lot#" DataIndex="lotNo" Width="120">
                        </ext:Column>
                        <ext:Column Header="Master#" DataIndex="masterNo" Width="160">
                        </ext:Column>
                        <ext:Column Header="House#" DataIndex="houseNo" Width="160">
                        </ext:Column>
                        <ext:Column Header="Invoice#" DataIndex="invoiceNo" Width="130">
                        </ext:Column>
                        <ext:Column Header="Ctnr#" DataIndex="ctnrNo" Width="150">
                        </ext:Column>
                        <ext:Column Header="Action" DataIndex="actions" Width="50" Align="Center">
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true">
                    </ext:RowSelectionModel>
                </SelectionModel>
                <BottomBar>
                        <ext:PagingToolbar PageSize="100" DisplayInfo="true" ID="PagingToolbar1" runat="server">
                        </ext:PagingToolbar>
                    <%--    <ext:PagingToolbar StoreID="storeList" PageSize="100" runat="server" ID="PagingToolbar1" HideRefresh="true"
                                    AfterPageText="&nbsp;of {0}" BeforePageText=" Page " DisplayMsg="Displaying {0} - {1} of  {2} "
                                    EmptyMsg="No Data">
                                </ext:PagingToolbar>--%>
                </BottomBar>
            </ext:GridPanel>
                <ext:ToolTip 
            ID="RowTip" 
            runat="server" 
            Target="={#{gridList}.getView().mainBody}"
            Delegate=".x-grid3-row"
            TrackMouse="false"
            width="898px"
            quickShowInterval="500"
            Cls="tipLeft"
            >
            <Listeners>
                <Show Handler="var rowIndex = #{gridList}.view.findRowIndex(this.triggerElement);this.body.dom.innerHTML = 
                '<div style=width:898px;word-break:break-all;><div class=rowStyle style=font-weight:800;width:55px;> Voyage : </div> <div class=rowStyle style=width:175px;>' + #{storeList}.getAt(rowIndex).get('flightNo') + 
                '</div><div class=rowStyle style=font-weight:800;width:35px;> POL : </div><div class=rowStyle style=width:60px;>'+ #{storeList}.getAt(rowIndex).get('pol')+
                '</div><div class=rowStyle style=font-weight:800;width:35px;> POD : </div><div class=rowStyle style=width:60px;>'+ #{storeList}.getAt(rowIndex).get('pod')+
                '</div><div class=rowStyle style=font-weight:800;width:47px;> SALES : </div><div class=rowStyle style=width:85px;>'+ #{storeList}.getAt(rowIndex).get('sales')+
                '</div><div class=rowStyle style=font-weight:800;width:38px;> GWT : </div><div class=rowStyle style=width:75px;>'+ #{storeList}.getAt(rowIndex).get('gwt')+
                '</div><div class=rowStyle style=font-weight:800;width:38px;> VWT : </div><div class=rowStyle style=width:75px;>'+ #{storeList}.getAt(rowIndex).get('vwt')+
                '</div><div class=rowStyle style=font-weight:800;width:38px;> CWT : </div><div class=rowStyle style=width:75px;>'+ #{storeList}.getAt(rowIndex).get('cwt')+'</div></div>';
                $('.x-shadow').css('display','none');
                $('.x-ie-shadow').css('display','none');
                $('.x-tip-tc, .x-tip-tl, .x-tip-tr, .x-tip-bc, .x-tip-bl, .x-tip-br, .x-tip-ml, .x-tip-mr').css('background-image','none');
                $('.x-tip-tl, .x-tip-br').height('0px');
                $('.x-tip-ml').css('padding','4px');
                $('#RowTip').css('border','1px solid #8DB2E3');
                "/>
            </Listeners>
        </ext:ToolTip> 
        </div>
        
    </div>
    </form>
    <script type="text/javascript">
//        var isBind = true;

        //用于获取数据
        function getAllShipment(id) {
//            if (!isBind)
//                return;
//            isBind = false;

            var chkAll = document.getElementById("chkAll").checked ? "chkAll" : "";
//            var chkLot = document.getElementById("chkLot").checked ? "chkLot" : "";
            var chkMaster = document.getElementById("chkMaster").checked ? "chkMaster" : "";
            var chkHouse = document.getElementById("chkHouse").checked ? "chkHouse" : "";
            var chkInvoice = document.getElementById("chkInvoice").checked ? "chkInvoice" : "";
            var chkCtnr = document.getElementById("chkCtnr").checked ? "chkCtnr" : "";
            var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";


           // $("#hidChbStr").val(chkAll + "," + chkLot + "," + chkMaster + "," + chkHouse + "," + chkInvoice + "," + chkCtnr + "," + chkVoid);
            $("#hidChbStr").val(chkAll + "," + chkMaster + "," + chkHouse + "," + chkInvoice + "," + chkCtnr + "," + chkVoid);
            //alert($("#hidChbStr").val());
            //            var ajaxGet = null;

            //            if (ajaxGet) {
            //                ajaxGet.abort();
            //            }

            //            ajaxGet = $.ajax({
            //                type: 'POST',
            //                url: "/common/UIControls/AjaxService/AllShipmentData.ashx?allNo=" + "<%=allNo %>" + "&chkAll=" + chkAll + "&chkLot=" + chkLot + "&chkMaster=" + chkMaster + "&chkHouse=" + chkHouse + "&chkInvoice=" + chkInvoice + "&chkCtnr=" + chkCtnr + "&v=" + new Date().getTime(),
            //                dataType: "json",
            //                success: function (data) {
            //                    alert(data);

            //                    CompanyX.BindData(data);
            //                    $("#tblChkGroup").attr("disabled", ""); //取消禁用

            //                    //                         if (data != "" && data != undefined) {

            //                    //                             alert(data);
            //                    //                            
            //                    //                         }
            //                },
            //                error: function () {
            //                    Ext.MessageBox.alert("Status", "loading failed.Please try later again!");
            //                }
            //            });


            CompanyX.BindData(chkAll, chkMaster, chkHouse, chkInvoice, chkCtnr, chkVoid);
//            $("#tblChkGroup").attr("disabled", ""); //取消禁用
//            isBind = true;
        }


        Ext.onReady(function () {
            //            gridList.setHeight(document.documentElement.clientHeight - 115 - $("#PagingToolbar1").height()); //设置grid高度
            var gridWidth = gridList.getWidth();
            var gridHeight = gridList.getHeight();
          
            if (document.getElementById("chkAll").checked) {
                $("#tblChkGroup").attr("disabled", "disabled"); //禁用

                $("#divLoadMaskAllShipment").css("width", gridWidth);
                $("#divLoadMaskAllShipment").css("height", gridHeight);
                $("#divLoadMaskAllShipment").css("display", "block"); //显示Loading
                $("#divLoadAllShipment").css("display", "block"); //显示Loading

            }
            //            getAllShipment("tblChkGroup");

            CompanyX.BindDataByNo();
            $("#tblChkGroup").focus(function () {
                $("#tblChkGroup").removeClass("x-form-focus");
            });

            $("#tblChkGroup input[type='checkbox']").click(function () {
                var chkId = $(this).attr("ID");

                //                $("#tblChkGroup").attr("disabled", "disabled"); //禁用

                $("#divLoadMaskAllShipment").css("width", gridWidth);
                $("#divLoadMaskAllShipment").css("height", gridHeight);
                $("#divLoadMaskAllShipment").css("display", "block"); //显示Loading
                $("#divLoadAllShipment").css("display", "block"); //显示Loading


                if (this.checked) {
                    if (chkId == "chkAll") {
                        // document.getElementById("chkLot").checked = true;
                        document.getElementById("chkMaster").checked = true;
                        document.getElementById("chkHouse").checked = true;
                        document.getElementById("chkInvoice").checked = true;
                        document.getElementById("chkCtnr").checked = true;
                        document.getElementById("chkVoid").checked = true;
                    }
                } else {
                    if (chkId == "chkAll") {
                        // document.getElementById("chkLot").checked = false;
                        document.getElementById("chkMaster").checked = false;
                        document.getElementById("chkHouse").checked = false;
                        document.getElementById("chkInvoice").checked = false;
                        document.getElementById("chkCtnr").checked = false;
                        document.getElementById("chkVoid").checked = false;
                    }
                    else {
                        document.getElementById("chkAll").checked = false;
                    }
                }


                // var chkLot = document.getElementById("chkLot").checked ? "chkLot" : "";
                var chkMaster = document.getElementById("chkMaster").checked ? "chkMaster" : "";
                var chkHouse = document.getElementById("chkHouse").checked ? "chkHouse" : "";
                var chkInvoice = document.getElementById("chkInvoice").checked ? "chkInvoice" : "";
                var chkCtnr = document.getElementById("chkCtnr").checked ? "chkCtnr" : "";
                var chkVoid = document.getElementById("chkVoid").checked ? "chkVoid" : "";

                //chkLot == "chkLot" && 
                if (chkMaster == "chkMaster" && chkHouse == "chkHouse" && chkInvoice == "chkInvoice" && chkCtnr == "chkCtnr" && chkVoid == "chkVoid") {
                    document.getElementById("chkAll").checked = true;
                }
                getAllShipment(chkId);

            });
        });
    </script>
</body>
</html>
