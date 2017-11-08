function Transfer(obj, seedID, sys) {

        $.get("/AirExport/AEViewConsol/Transfer.ashx?type=transfer&seed=" + seedID + "&sys=" + sys, function(data) {

            if (data == "True") {
                alert(" Sent ! ");
                obj.outerHTML = "<span class=\"span_trf\" onclick=\"Transfer(this,'" + seedID + "','" + sys + "');\" >Resend</span>";
            }
            else {
                alert("Error，Please check the data ！");
            }
        })
}