/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

var FwGroupUser = new Object();
// 单头
FwGroupUser.Header = function(opts) {
    var tr = $("#" + opts.form);
    if (tr.attr("class") == "show") {
        tr.attr("class", "hide");
        $(opts.me).html("显示");
    } else {
        tr.attr("class", "show");
        $(opts.me).html("隐藏");
    }
    FwGroupUser.Checked(opts.CompanyID);
}
// 保存
FwGroupUser.Upade = function(opts) {
    Myplugin.Controller({ form: opts.form, url: "DataController.ashx?option=groupuser-update&companyid=" + opts.CompanyID + "&groupid=" + Myplugin.QueryString("groupid") }, function(data) {
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
FwGroupUser.Checked = function(CompanyID) {
    Myplugin.Controller({ form: "table-user", url: "DataController.ashx?Option=groupuser-checked&groupid=" + Myplugin.QueryString("groupid") + "&companyid=" + CompanyID }, function(data) {
        var json = $.parseJSON(data);
        $.each(json, function(i) {
            $("input[type=checkbox]").each(function(j) {
                if (this.value == json[i].ID) this.checked = true;
            });
        });
    });
}


$(document).ready(function() {
    FwGroupUser.Checked("CP001");
});
