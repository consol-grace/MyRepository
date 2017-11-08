$(function() {
    var sss = null;
    //    if (groupID == "G01") {
    if ($("#hidStat").val() == "Y") {
        $("#div_User").css({ "cursor": "pointer", "text-decoration": "underline" }).toggle(function() {
            Usclose();
            clearTimeout(sss);
            $("#div_c").animate({ top: "80px", left: "170px" }, 200).show();
            sss = setTimeout(CSclose, 5000);

        }, function() {
            Usclose();
            clearTimeout(sss);
            $("#div_c").animate({ top: "80px", left: "170px" }, 200).show();
            sss = setTimeout(CSclose, 5000);

        })

        $("#div_c").hover(function() {
            clearTimeout(sss);
        }, function() { })

    }


    $("#div_user_edit").toggle(function() {
        CSclose();
        clearTimeout(sss);
        $("#div_user").show().animate({ top: "80px" }, "fast");
        sss = setTimeout(Usclose, 5000);
    }, function() {
        CSclose();
        clearTimeout(sss);
        $("#div_user").show().animate({ top: "80px" }, "fast");
        sss = setTimeout(Usclose, 5000);
    })

    $("#div_user").hover(function() {
        clearTimeout(sss);
    }, function() { })

    $("#m_top,#td_Menu,#tdContent,#ifmContent").click(function() { CSclose(); Usclose(); })
    $("#ifmContent").contents().click(function() { CSclose(); Usclose(); })


})

function CSclose() {
    $("#div_c").animate({ top: "0px", left: "170px" }, 200).hide();
}

function Usclose() {
    $("#div_user").animate({ top: "0px" }, "fast").hide();
    CompanyX.selectUserInfo();
}
