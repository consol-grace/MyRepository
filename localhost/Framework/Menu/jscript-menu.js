/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

$(document).ready(function() {
    $("#divTreeList").treeview();
    $("#pMainOrSub").hide();
    ResetTextbox("M05", "0", "根", "", "", "#1");
    InitData();

    // 子级
    $("#btnSub").click(function() {
        $("#pMainOrSub").show();
        $("#pMainOrSub").find("caption").html("新增子级");

        $("#RootID1").val($("#RootID").val());
        $("#ParentID1").val($("#MenuID").val());
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
        if (!Myplugin.Data.Valid.Form($("#MenuID"), "请输入菜单编号！", "null")) {
            $("#MenuID").focus();
            return false;
        }

        if (confirm("确认删除吗？")) {
            Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=delete&menuid=" + $("#MenuID").val() }, function(data) {
                var json = $.parseJSON(data);
                if (json[0].Option == "false") {
                    alert("删除失败, 请确认是否被使用！");
                }
                else {
                    $("#divTreeList").find("span[id=" + $("#MenuID").val() + "]").hide();
                    ResetTextbox("", "", "", "", "", "", "#1");
                }
            });
            $("#pMainOrSub").hide();
        }
    });

    // 保存1
    $("#btnSave1").click(function() {
        if (!Myplugin.Data.Valid.Form($("#MenuID"), "请输入菜单编号！", "null")) {
            $("#MenuID").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#NameCHS"), "请输入菜单名称！", "null")) {
            $("#NameCHS").focus();
            return false;
        }

        Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=save-main" }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false") {
                alert("保存失败！");
            }
            else {
                GetTreeList();
            }
        });
    });

    // 取消
    $("#btnCancel").click(function() {
        $("#pMainOrSub").hide();
    });

    // 保存1
    $("#btnSave2").click(function() {
        if (!Myplugin.Data.Valid.Form($("#MenuID1"), "请输入菜单编号！", "null")) {
            $("#MenuID1").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#NameCHS1"), "请输入菜单名称！", "null")) {
            $("#NameCHS1").focus();
            return false;
        }

        Myplugin.Controller({ form: "table-menu-sub", url: "DataController.ashx?Option=save-sub" }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false") {
                alert("保存失败！");
            }
            else {
                GetTreeList();
            }
        });
    });

});
// 获取 Tree List
var GetTreeList = function() {
    Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=list" }, function(data) {
        $("#divTreeList").html(data);
        InitData();
        $("#pMainOrSub").hide();
        ResetTextbox1("", "", "", "", "", "");
    });

}
// 初始化资料   divTreeList 重写 获取明细资料
var InitData = function() {    
    $("#divTreeList").find("span").each(function(i) {
        var me = $(this).css({ "cursor": "pointer" });
        me.click(function() {
            Myplugin.Controller({ form: "table-menu-main", url: "DataController.ashx?Option=detail&menuid=" + this.id }, function(data) {
                var json = $.parseJSON(data);
                ResetTextbox(json[0].RootID, json[0].ParentID, json[0].PNameCHS, json[0].MenuID, json[0].NameCHS, json[0].Hyperlink);
            });
        });
    });
}


// 设置 && 清除 main
var ResetTextbox = function(RootID, ParentID, PNameCHS, MenuID, NameCHS, Hyperlink) {
    $("#RootID").val(RootID);
    $("#ParentID").val(ParentID);
    $("#PNameCHS").val(PNameCHS);
    $("#MenuID").val(MenuID);
    $("#NameCHS").val(NameCHS);
    $("#Hyperlink").val(Hyperlink);
}
// 设置 && 清除 sub
var ResetTextbox1 = function(RootID, ParentID, PNameCHS, MenuID, NameCHS, Hyperlink) {
    $("#RootID1").val(RootID);
    $("#ParentID1").val(ParentID);
    $("#PNameCHS1").val(PNameCHS);
    $("#MenuID1").val(MenuID);
    $("#NameCHS1").val(NameCHS);
    $("#Hyperlink1").val(Hyperlink);
}