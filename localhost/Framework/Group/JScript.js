/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

var FwGroup = new Object();

// Group Root 显示 或 隐藏
FwGroup.TreeRoot = function(groupid) {
    var tr = $("#Tr" + groupid);   

    if (tr.attr("class") == "hide") {
        tr.attr("class", "show")
        FwGroup.TreeList(groupid);
    }
    else {
        tr.attr("class", "hide");
        $("#TreeList-Tr" + groupid).empty();
    }
}
FwGroup.TreeList = function(groupid) {
    var tree = $("#TreeList-Tr" + groupid);
    Myplugin.Controller({ form: "TreeList-Tr" + groupid, url: "DataController.ashx?Option=list&groupid=" + groupid }, function(data) {
        tree.html(data);
        FwGroup.OverrideTreeList("TreeList-Tr" + groupid);
    });
}
FwGroup.TreeDetail = function(groupid) {
    Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=detail&groupid=" + groupid }, function(data) {
        var json = $.parseJSON(data);
        FwGroup.SetValue(json[0]);
    });
}
// 初始化资料   divTreeList 重写 获取明细资料
FwGroup.OverrideTreeList = function(TreeID) {
    $("#" + TreeID).find("span").each(function(i) {
        var me = $(this).css({ "cursor": "pointer" });
        me.click(function() {
            FwGroup.TreeDetail(this.id);
        });
    });

    FwGroup.Reset(1);
    $("#pMainOrSub").hide();
}


// 赋值
FwGroup.SetValue = function(opts) {
    if (opts) {
        for (var s in opts) {
            $("#" + s).val(eval("opts." + s));
        }
    }
}
// 清空 Textbox 控件值
FwGroup.Reset = function(id) {
    if (id == 1) {
        $("#RootID1").val("");
        $("#ParentID1").val("");
        $("#PNameCHS1").val("");
        $("#GroupID1").val("");
        $("#NameCHS1").val("");
        $("#Remark1").val("");
    }
    else {
        $("#RootID").val("G1");
        $("#ParentID").val("0");
        $("#PNameCHS").val("根");
        $("#GroupID").val("");
        $("#NameCHS").val("");
        $("#Remark").val("");
    }
}

$(document).ready(function() {
    $("#divTreeList").treeview();
    $("#pMainOrSub").hide();
    FwGroup.Reset(0);
    FwGroup.TreeRoot("G1");
    FwGroup.TreeDetail("G1");

    // 子级
    $("#btnSub").click(function() {
        $("#pMainOrSub").show();
        $("#pMainOrSub").find("caption").html("新增子级");

        $("#RootID1").val($("#RootID").val());
        $("#ParentID1").val($("#GroupID").val());
        $("#PNameCHS1").val($("#NameCHS").val());
    });

    // 同级
    $("#btnMain").click(function() {
        $("#pMainOrSub").show();
        $("#pMainOrSub").find("caption").html("新增同级");

        $("#RootID1").val($("#RootID").val());
        $("#ParentID1").val($("#ParentID").val());
        $("#PNameCHS1").val($("#PNameCHS").val());
    });

    // 删除
    $("#btnDelete").click(function() {
        if (!Myplugin.Data.Valid.Form($("#GroupID"), "请输入群组编号！", "null")) {
            $("#GroupID").focus();
            return false;
        }

        if (confirm("确认删除吗？")) {
            Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=delete&groupid=" + $("#GroupID").val() }, function(data) {
                var json = $.parseJSON(data);
                if (json[0].Option == "false") {
                    alert("删除失败！");
                }
                else {
                    var tree = $("#TreeList-Tr" + $("#RootID").val()).find("span[id=" + $("#GroupID").val() + "]").hide();
                    FwGroup.Reset(0);
                }
            });
            $("#pMainOrSub").hide();
        }
    });

    // 保存1
    $("#btnSave1").click(function() {
        if (!Myplugin.Data.Valid.Form($("#GroupID"), "请输入群组编号！", "null")) {
            $("#GroupID").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#NameCHS"), "请输入群组名称！", "null")) {
            $("#NameCHS").focus();
            return false;
        }

        Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=save-main" }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false") {
                alert("保存失败！");
            }
            else {
                FwGroup.TreeList($("#RootID").val());
            }
        });
    });

    // 取消
    $("#btnCancel").click(function() {
        $("#pMainOrSub").hide();
    });

    // 保存1
    $("#btnSave2").click(function() {
        if (!Myplugin.Data.Valid.Form($("#GroupID1"), "请输入群组编号！", "null")) {
            $("#GroupID1").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#NameCHS1"), "请输入群组名称！", "null")) {
            $("#NameCHS1").focus();
            return false;
        }

        Myplugin.Controller({ form: "table-menu-sub", url: "DataController.ashx?Option=save-sub" }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false") {
                alert("保存失败！");
            }
            else {
                FwGroup.TreeList($("#RootID").val());
            }
        });
    });

    // 管控用户
    $("#aGroupUser").click(function() {
        window.parent.FwDialog.Create({ width: 640, height: 480, caption: "管控用户", url: Myplugin.ContextPath + "Framework/Group/GUlist.aspx?groupid=" + $("#GroupID").val() });
        window.parent.FwDialog.Open();
    });
    // 管控菜单
    $("#aGroupMenu").click(function() {
        window.parent.FwDialog.Create({ width: 640, height: 480, caption: "管控菜单", url: Myplugin.ContextPath + "Framework/Group/GMlist.aspx?groupid=" + $("#GroupID").val() });
        window.parent.FwDialog.Open();
    });
    // 管控权限
    $("#aGroupPermission").click(function() {
        window.parent.FwDialog.Create({ width: 640, height: 480, caption: "管控权限", url: Myplugin.ContextPath + "Framework/Group/GPlist.aspx?groupid=" + $("#GroupID").val() });
        window.parent.FwDialog.Open();
    });

});
