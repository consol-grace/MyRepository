/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

var FwGroupPermission = new Object();
// 保存
FwGroupPermission.Upade = function(opts) {
    Myplugin.Controller({ form: opts.form, url: "DataController.ashx?option=grouppermission-update&groupid=" + Myplugin.QueryString("groupid") }, function(data) {
        var json = $.parseJSON(data);
        if (json[0].Option == "false") {
            alert("保存失败！");
        }
        else {
            alert("保存成功！");
        }
    });
}
// 已勾选的打勾
FwGroupPermission.Checked = function() {
    Myplugin.Controller({ form: "table-user", url: "DataController.ashx?Option=grouppermission-checked&groupid=" + Myplugin.QueryString("groupid") }, function(data) {
        var json = $.parseJSON(data);
        $.each(json, function(i) {
            $("input[type=checkbox]").each(function(j) {
                if (this.value == json[i].ID) this.checked = true;
            });
        });
    });
}


$(document).ready(function() {
    FwGroupPermission.Checked();
});
