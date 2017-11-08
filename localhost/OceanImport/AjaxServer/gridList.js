function RetrunText(obj, grid) {

    var Qty, Unit;
    var record = grid.getStore().getAt(selectCostTotalRow);
    var text = obj == "" ? record.data.CalcKind : obj;  //obj.getValue(true);
    if (text == "") return;
    switch (text) {
        case "GWT":
            Qty = txtGWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CBM":
            Qty = txtCBM.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "PCS":
            Qty = txtPiece.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CNTR":
            Qty = txtContainer.getValue();
            Unit = CmbUnit.getValue();
        default: 
            break; 
    }
    record = grid.getStore().getAt(selectCostTotalRow);
    record.set("Qty", Qty);
    record.set("Unit", Unit);
}





function RetrunCalc(text) {

    var Qty = "", Unit = "";
    switch (text) {
        case "GWT":
            Qty = txtGWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CWT":
            Qty = txtCWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "VWT":
            Qty = txtVWT.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "PCS":
            Qty = txtPiece.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CNTR":
            Qty = txtContainer.getValue();
            Unit = CmbUnit.getValue();
            break;
        case "CBM":
            Qty = txtCBM.getValue();
            Unit = CmbUnit.getValue();
    }
    $("#c_Qty").val(Qty);
    $("#c_Unit").val(Unit);

}


var b = "1";
function gridTotals(grid) {
    if (grid == null) return;
    var record = grid.getStore().getAt(selectCostTotalRow);
    var Amount = record.data.Amount;
    var Rate = record.data.Rate;
    var Qty = record.data.Qty;

    if (Rate != "" && b == "1") { record.set("Amount", ""); b = "0"; record = grid.getStore().getAt(selectCostTotalRow); }

    else if (Amount != "" && b == "0") { record.set("Rate", ""); b = "1"; record = grid.getStore().getAt(selectCostTotalRow); }

    record = grid.getStore().getAt(selectCostTotalRow);
    Amount = record.data.Amount;
    Rate = record.data.Rate;

    Qty = isNaN(record.data.Qty) ? 0 : record.data.Qty;

    if (Amount == "")
        Qty = Rate * Qty;
    else
        Qty = Amount;
    record.set("Total", Qty);
}

function AutoDeleteRow(grid) {

    if (grid.store.getTotalCount() > 0) {
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var Qty = grid.getRowsValues({ Selectedonly: true })[i].Qty;
            var Currency = grid.getRowsValues({ Selectedonly: true })[i].Currency
            var PPD = grid.getRowsValues({ Selectedonly: true })[i].PPD;
            var CompanyCode = grid.getRowsValues({ Selectedonly: true })[i].CompanyCode
            var Item = grid.getRowsValues({ Selectedonly: true })[i].Item
            var CalcKind = grid.getRowsValues({ Selectedonly: true })[i].CalcKind
            if (Qty == undefined && PPD == undefined && CompanyCode == "" && Item == "" && CalcKind == "") {
                grid.getSelectionModel().selectRow(i);
                grid.deleteSelected();
            }
        }
    }
}

function Add() {

    //    Ext.MessageBox.confirm("Status", " Please save the data ? ", function(e) {
    //    if (e == "yes") {
    var s = Request("seed");
    Ext.getCmp('btnSave').fireEvent('click', this);
    var lotNo = labImpLotNo.getText();
    setTimeout(function() { window.open("../OceanShipmentJobList/OceanShipmentHouse.aspx?MBL=" + Request("seed"), lotNo) }, 1000);
    //        }
    //    });
}



function ReturnNull() {
    var MBL = "";
    var SerMode = "";
    var PPCC = "";
    var Salesman = "";
    var Carrier = "";
    var Shipper = "";
    var Consignee = "";
    var VesVoy = "";
    var Loading = "";
    var Discharge = "";
    var FinalDest = "";
    var ETD = "";
    var ETA = "";
    var ATD = "";
    var Pieces = "";
    var CBM = "";

    MBL = txtMBL.getValue();
    SerMode = cmbMode.getValue();
    PPCC = cmbPPD.getValue();
    Carrier = $("#cmbCarrierCode").val();
    Shipper = $("#cmbShipperCode").val();
    Consignee = $("#cmbConsigneeCode").val();
    VesVoy = cmbVesselCode.getValue();
    Loading = cmbLoading.getValue();
    Discharge = cmbPort.getValue();
    FinalDest = cmbFinalDest.getValue();
    ETD = txtETD.getValue();
    ETA = txtETADischarge.getValue();
    ATD = txtATD.getValue();


    if (MBL == "" || MBL == undefined) {
        txtMBL.focus();
        NullMsg("MBL");
        return false;
    }
    else if (SerMode == "" || SerMode == undefined) {
        cmbMode.focus();
        NullMsg("Service Mode");
        return false;
    }
    else if (PPCC == "" || PPCC == undefined) {
        cmbPPD.focus();
        NullMsg("PPD/COL");
        return false;
    }
    else if (Carrier == "" || Carrier == undefined) {
        $("#cmbCarrierCode").focus();
        NullMsg("Carrier");
        return false;
    }
    else if (Shipper == "" || Shipper == undefined) {
        $("#cmbShipperCode").focus();
        NullMsg("Shipper");
        return false;
    }
    else if (Consignee == "" || Consignee == undefined) {
        $("#cmbConsigneeCode").focus();
        NullMsg("Consignee");
        return false;
    }
    else if (VesVoy == "" || VesVoy == undefined) {
        cmbVesselCode.focus();
        NullMsg("Vessel");
        return false;
    }
    else if (Loading == "" || Loading == undefined) {
        cmbLoading.focus();
        NullMsg("Loading");
        return false;
    }
    else if (Discharge == "" || Discharge == undefined) {
        cmbPort.focus();
        NullMsg("Discharge Port");
        return false;
    }
    else if (FinalDest == "" || FinalDest == undefined) {
        cmbFinalDest.focus();
        NullMsg("Final Dest");
        return false;
    }
    else if (ETD == "" || ETD == undefined) {
        txtETD.focus();
        NullMsg("ETD");
        return false;
    }
    else if (ETA == "" || ETA == undefined) {
        txtETADischarge.focus();
        NullMsg("ETA");
        return false;
    }
    else if (ATD == "" || ATD == undefined) {
        txtATD.focus();
        NullMsg("txtATD");
        return false;
    }
    else {
        return true;
    }
}

//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't empty!");
}

var vessel = "", vesselid = "";
function getVessel(Vessel, VesselID) {
    vessel = Vessel;
    vesselid = VesselID;
}


function getshowVessel(vessel, voyage) {
    cmbVesselCode.setValue(vessel);
    CompanyX.BindVoyag(voyage);
    Window1.close();
}


function ShowVoyage(vesselID, voyageID) {
    //alert(vessel + "," + voyage);
    var option = "?vesselID=" + vesselID + "&voyageID=" + voyageID + "&controlID=control";
    win = new Ext.Window({
        id: "Window1",
        title: "Vessel/Voyage",
        resizable: false,
        draggable: false,
        //animateTarget: "cmbVesselText",  //--- 此效果会有点卡
        width: 710,
        height: 365,
        modal: true,
        closeAction: "close"
    });

    win.on({ close: function(win) {
        //win.close();
        //win.destroy();
        //StoreVoyage.reload();
        window.parent.window.document.body.style.overflow = "auto";
        getSelectPos('cmbVesselCode');
    }
    });
    win.load("http://" + window.location.host + "/Oceanimport/voyage/list.aspx" + option);
    win.show();
    window.parent.window.document.body.style.overflow = "hidden";
}


function DeleteHBL(grid) {
    grid.deleteSelected();
    var gwt = 0;
    var cbm = 0;
    var wm = 0;
    var piece = 0;
    var status = 0;
    for (var i = 0; i < grid.store.getTotalCount(); ++i) {
        var data = grid.getRowsValues()[i];
        gwt += parseFloat((data.CWT == null || data.CWT == "") ? 0 : data.CWT);
        cbm += parseFloat((data.CBM == null || data.CBM == "") ? 0 : data.CBM);
        wm += parseFloat((data.WM == null || data.WM == "") ? 0 : data.WM);
        piece += parseFloat((data.PKGS == null || data.PKGS == "") ? 0 : data.PKGS);
        status = 1;
    }
    if (status == 1) {
        txtAGWT.setValue(gwt == 0 ? "" : Number(gwt).toFixed(3));
        txtACBM.setValue(cbm == 0 ? "" : Number(cbm).toFixed(3));
        txtAWM.setValue(wm == 0 ? "" : Number(wm).toFixed(3));
        txtAPiece.setValue(piece == 0 ? "" : Number(piece).toFixed(0));
    }
    else {
        txtAGWT.setValue("");
        txtACBM.setValue("");
        txtAWM.setValue("");
        txtAPiece.setValue("");
    }
}