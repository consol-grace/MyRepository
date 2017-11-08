/// <reference path="../../Common/myplugin/jquery-1.4.1.js" />
/// <reference path="../../Common/myplugin/jquery.ui.custom.js" />
/// <reference path="../../Common/myplugin/myplugin.core.js" />
/// <reference path="../../Common/myplugin/myplugin.ui.js" />

jQuery(document).ready(function() {
    Myplugin.Checkbox.ChoiceAll("chkAll", "chkItem");
    Myplugin.Checkbox.ChoicItem("chkAll", "chkItem");

    //
    $("#btnAddnew").click(function() {
        window.parent.FwDialog.Create({ caption: "新增公司", url: Myplugin.ContextPath + "Framework/Company/update.aspx?option=addnew" });
        window.parent.FwDialog.Open();
    });

    // 查询
    $("#btnSearch").click(function() {
    Myplugin.Controller({ form: "form1", url: "DataController.ashx?option=search" }, function(data) {
            var json = $.parseJSON(data);

            var row, dt = new Myplugin.DataTable();
            dt.Bind("table-company-list").Clear();
            $.each(json, function(i) {
                row = new dt.NewRow();
                row.Add('<input type="checkbox" name="chkItem" value=\'' + json[i].CompanyID + '\' />');
                row.Add('<a href="javascript:void(0)" rel=\'' + json[i].CompanyID + '\' name="btnModify">修改</a>');
                row.Add(json[i].CompanyID);
                row.Add(json[i].NameCHS);
                row.Add(json[i].NameENG);
                row.Add(json[i].District);
                dt.Rows.Add(row, "Tr_" + json[i].CompanyID);
            });
            dt.AcceptChanges();

            Myplugin.Checkbox.ChoiceAll("chkAll", "chkItem");
            Myplugin.Checkbox.ChoicItem("chkAll", "chkItem");

            Modify();
        });
    });

    // 删除
    $("#btnDelete").click(function() {
        if (confirm("确定删除吗？")) {
            Myplugin.Controller({ form: "table-company-list", url: "DataController.ashx?option=delete" }, function(data) {
                var json = $.parseJSON(data);
                $.each(json, function(i) {
                    if (json[i].Option == "true") {
                        $("#Tr_" + json[i].RemoveID).hide();
                    }
                    else {
                        alert("删除失败 或 请选择需要删除的选择项！");
                    }
                });
            });
        }
    });

    // 修改
    Modify();

    // 保存
    $("#btnSave").click(function() {
//        if (!Myplugin.Data.Valid.Form($("#CompanyID"), "请输入公司编号！", "null")) {
//            $("#CompanyID").focus();
//            return false;
//        }
        if (!Myplugin.Data.Valid.Form($("#NameCHS"), "请输入名称(简)！", "null")) {
            $("#NameCHS").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#NameENG"), "请输入名称(英)！", "null")) {
            $("#NameENG").focus();
            return false;
        }
        if (!Myplugin.Data.Valid.Form($("#District"), "请输入区域！", "null")) {
            $("#District").focus();
            return false;
        }

        Myplugin.Controller({ form: "table-company-update", url: "DataController.ashx?option=update" }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false")
                alert("资料保存失败！");
            else
                alert("资料保存成功！");
            window.parent.FwDialog.Close();
        });
    });
});

function Modify() {
    $("#table-company-list").find("a[name=btnModify]").each(function(i) {
        $(this).click(function() {
            window.parent.FwDialog.Create({ caption: "修改公司", url: Myplugin.ContextPath + "Framework/Company/update.aspx?option=modify&companyid=" + this.rel });
            window.parent.FwDialog.Open();
        });
    });
}
