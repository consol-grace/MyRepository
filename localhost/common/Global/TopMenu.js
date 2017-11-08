//$(function() {
//    $("#outer").hover(function() {
//        var offset = $(this).offset();
//        if ($("#div").css("display") == "none");
//        {
//            $("#div").slideDown(100);
//        }
//    }, function() {
//        $("#div").slideUp(100);
//    })
//})

$(function() {


    var left = 1024 - $("#div_content table").width() - 24 + $("#left_Menu").width();
    $("#div_content").css("left", left);

    var up = null;
    $("#img").css("cursor", "pointer").click(function() {

        if ($("#div").css("display") == "none");
        {
            $("#div").slideDown(100).hover(function() {
                clearTimeout(up);
            }, function() {
                slid();
            });
        }
        up = setTimeout(slid, 3000);

    })

})
function slid() {
    $("#div").slideUp(300);
}
