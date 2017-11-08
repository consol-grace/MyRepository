function LockCost(obj, seed, sys) {

    Ext.Msg.confirm('Information', 'Are you sure?', function(btn) {
        if (btn == 'yes') {
            obj.outerHTML = "<span class=\"span_trf\" onclick=\"LockCost(this,'" + seed + "','" + sys + "');\" >" + (obj.innerHTML == "Lock" ? "<font color='green'>Unlock</font>" : "Lock") + "</span>";
            $.get("/common/UIControls/gridHtml.ashx?type=lockcost&seed=" + seed + "&sys=" + sys, function(data) {

                //            if (data == "Y") {
                //                obj.outerHTML = "<span class=\"span_trf\" onclick=\"LockCost(this,'" + seed + "','" + sys + "');\" >" + (obj.innerHTML == "Lock" ? "<font color='green'>Unlock</font>" : "Lock") + "</span>";
                //            }
                //            else {
                //                alert("Error，Please check the data ！");
                //            }
            });
        }
    });
}


