///检查HBL是否可以录入


///obj 当前文本框对象this
///sys 当前系统类型OE
function CheckHBLNo(obj, sys, seed) {
    var value = obj.getValue();
    var hbl = sys.substring(0, 1) == "A" ? "HAWB" : "HBL";

    if (value == "" || value == null || value == undefined) {
        $("#" + obj.id).attr("validata", "true").removeClass("bottom_line");
        $("#div_bottom").html("<p class=\"success\">Status :The input value is valid  .</p>")
        return;
    }
    $.get("/common/uicontrols/SysCheckHBLNO.ashx", { value: value, sys: sys, seed: seed }, function(data) {

        ///data {-1为sys参数异常，0为没有，大于0已存在}
        if (data == "-1") {
            //alert("传入参数异常，请刷新页面后重新验证");
            obj.focus(true);
            $("#" + obj.id).attr("validata", "false").addClass("bottom_line");
            $("#div_bottom").html("<p class=\"error\">Status :Incoming parameters is unusual, please refresh the page and verify again .</p>")
        }
        else if (data == "0") {
            //alert("没有重复，可以通过！")
            $("#" + obj.id).attr("validata", "true").removeClass("bottom_line");
            $("#div_bottom").html("<p class=\"success\">Status :The input value is valid  .</p>")
        }
        else if (parseInt(data) > 0) {
            //alert("已经存在，请修改！")
            obj.focus(true);
            $("#" + obj.id).attr("validata", "false").addClass("bottom_line");
            $("#div_bottom").html("<p class=\"error\">Status :" + hbl + " already exists, please input again .</p>");
        }
    })
}