function ReturnNull() {
    var Shipper = "";
    var Shipper1 = "";
    var Consignee = "";
    var Consignee1 = "";
    var sales = "";
    var etd = "";

    Shipper = $("#CmbShipperCode").val();
    Shipper1 = $("#CmbShipperCode_name").val();
    Consignee = $("#CmbConsigneeCode").val();
    Consignee1 = $("#CmbConsigneeCode_name").val();
    sales = $("#CmbSalesman").val();
    etd = $("#txtDepartDate").val();

    if ((Shipper == "" || Shipper == undefined) && (Shipper1 == "" || Shipper1 == undefined)) {
        $("#CmbShipperCode").focus();
        NullMsg("Shipper");
        return false;
    }
    else if ((Consignee == "" || Consignee == undefined) && (Consignee1 == "" || Consignee1 == undefined)) {
        $("#CmbConsigneeCode").focus();
        NullMsg("Consignee");
        return false;
    }
    else if (sales == "" || sales == undefined) {
        $("#CmbSalesman").focus();
        NullMsg("Sales");
        return false;
    }
    else if (etd == "" || etd == undefined) {
        $("#txtDepartDate").focus();
        NullMsg("ETD");
        return false;
    }
    else {
        return true;
    }
}


//验证错误信息
function NullMsg(msg) {
    $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't be empty!");
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


function SetComValue(obj, name) {
    var hidcode = $("#" + obj + "1").val();
    var code = $("#" + obj).val();
        if (hidcode != code) {
            $("#" + obj + "_name").val(name);
            $("#" + obj + "1").val(code);
        }

    }

    function SelectItem(obj, obj1) {
        var value = $("#"+obj).val();
        var record = StoreLocation.getById(value);
        if (record != null && record != undefined) {
            $("#" + obj1).val(record.data.text);
        }
    }
