/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

var FwGroupMenu = new Object();

FwGroupMenu.Header = function(opts) {
    var tr = $("#" + opts.form);
    if (tr.attr("class") == "show") {
        tr.attr("class", "hide");
        $(opts.me).html("显示");
    } else {
        tr.attr("class", "show");
        $(opts.me).html("隐藏");
    }
    FwGroupMenu.Checked();
}
// 保存
FwGroupMenu.Upade = function(opts) {
    var Option = "groupmenu-delete";
    if (opts.form.checked) Option = "groupmenu-update";
    Myplugin.Controller({ form: opts.form.parentNode.parentNode, url: "DataController.ashx?option=" + Option + "&groupid=" + Myplugin.QueryString("groupid") + "&menuid=" + opts.form.value }, function(data) {
        var json = $.parseJSON(data);
        if (json[0].Option == "false") {
            alert("保存失败！");
        }
        else {
            //alert("保存成功！");
        }
    });
}
// 已勾选的打勾
FwGroupMenu.Checked = function() {
    Myplugin.Controller({ form: "table-user", url: "DataController.ashx?Option=groupmenu-checked&groupid=" + Myplugin.QueryString("groupid") }, function(data) {
        var json = $.parseJSON(data);
        $.each(json, function(i) {
            $("input[type=checkbox]").each(function(j) {
                if (this.value == json[i].ID) this.checked = true;
            });
        });
    });
}


$(document).ready(function() {
    FwGroupMenu.Checked();
});
