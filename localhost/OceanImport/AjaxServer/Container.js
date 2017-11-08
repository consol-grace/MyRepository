function ReturnNull() {
    var Container = "";
    var SerMode = "";
    var GWT = "";
    var CBM = "";
    var Pkgs = "";
    var Unit = "";
    Container = txtContainer.getValue();
    SerMode = CmbSerMode.getValue();
    GWT = txtGWT.getValue();
    CBM = txtCBM.getValue();
    Pkgs = txtPiece.getValue();
    Unit = CmbUnit.getValue();
    if (Container == "" || Container == undefined) {
        txtContainer.focus();
        NullMsg("Container");
        return false;
    }
    else if (SerMode == "" || SerMode == undefined) {
        CmbSerMode.focus();
        NullMsg("SerMode");
        return false;
    }
    else if (GWT == "" || GWT == undefined) {
        txtGWT.focus();
        NullMsg("GWT");
        return false;
    }
    else if (CBM == "" || CBM == undefined) {
        txtCBM.focus();
        NullMsg("CBM");
        return false;
    }
    else if (Pkgs == "" || Pkgs == undefined) {
        txtPiece.focus();
        NullMsg("Pkgs");
        return false;
    }
    else if (Unit == "" || Unit == undefined) {
        CmbUnit.focus();
        NullMsg("Unit");
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

