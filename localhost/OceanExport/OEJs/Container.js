function ReturnNull() {
    var Container = "";
    var SerMode = "";
    var GWT = "";
    var CBM = "";
    var Pkgs = "";
    var SO = "";
    var Seal = "";
    var size = "";
    Container = txtContainer.getValue();
    //SerMode = CmbSerMode.getValue();
    GWT = txtGWT.getValue();
    CBM = txtCBM.getValue();
    Pkgs = txtPiece.getValue();
    SO = txtSO.getValue();
    Seal = txtSeal.getValue();
    size = CmbSize.getValue();
    //    if (Container == "" || Container == undefined) {
    //        txtContainer.focus();
    //        NullMsg("Container");
    //        return false;
    //    }
    //    else if (SerMode == "" || SerMode == undefined) {
    //        CmbSerMode.focus();
    //        NullMsg("SerMode");
    //        return false;
    //    }
    //    else if (GWT == "" || GWT == undefined) {
    //        txtGWT.focus();
    //        NullMsg("GWT");
    //        return false;
    //    }
    //    else if (CBM == "" || CBM == undefined) {
    //        txtCBM.focus();
    //        NullMsg("CBM");
    //        return false;
    //    }
    //    else if (Pkgs == "" || Pkgs == undefined) {
    //        txtPiece.focus();
    //        NullMsg("Pkgs");
    //        return false;
    //    }
    //    else if (Unit == "" || Unit == undefined) {
    //        CmbUnit.focus();
    //        NullMsg("Unit");
    //        return false;
    //    }
    if (Container == "" && size == "" && GWT == "" && CBM == "" && Pkgs == "" && SO == "" && Seal == "") {
        txtContainer.focus();
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: input  can't  empty!");
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

function DeleteMsg() {
    Ext.Msg.confirm('Information', 'Are you sure you want to delete?', function(btn) {
        if (btn == "yes") {

            CompanyX.btnDelete_Click();
            return true;
        }
        else {
            return false;
        }
    });
}

