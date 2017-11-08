/// <reference path="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../../common/ylQuery/ylQuery.js" />
/// <reference path="../../common/ylQuery/ext-3.2.0/adapter/ext/ext-base.js" />
/// <reference path="../../common/ylQuery/ext-3.2.0/ext-all.js" />
/// <reference path="../../common/Global/global.js" />


jQuery(document).ready(function() {
    ylQuery.Checkbox.ChoiceAll("chkAll", "chkItem");
    ylQuery.Checkbox.ChoicItem("chkAll", "chkItem");

    //
    $("#btnAddnew").click(function() {
        window.parent.FwDialog.Open(ylQuery.ContextPath + "Framework/User/update.aspx?option=addnew", { width: 600, height: 400, caption: "新增用户" });
    });

    // 查询
    $("#btnSearch").click(function() {
        var _url = ylQuery.ContextPath + "Framework/User/DataController.ashx?option=fw_user_search";
        ylQuery.Controller({ form: "table-company-search", url: _url }, function(data) {
        alert(data);
            return false;

            var json = typeof (data) == "object" ? data : $.parseJSON(data);
            $("#table-company-list tr:gt(0)").remove();

            $.each(json, function(i) {
                var rowItem = "";
                rowItem += '<tr id="Tr_' + json[i].UserName + '">';
                rowItem += '    <td>';
                rowItem += '        <input type="checkbox" name="chkItem" value="' + json[i].UserName + '" />';
                rowItem += '    </td>';
                rowItem += '    <td>';
                rowItem += '        <a href="javascript:void(0)" rel="' + json[i].UserName + '" name="aModifyPWD">密码</a> | ';
                rowItem += '        <a href="javascript:void(0)" rel="' + json[i].UserName + '" name="aModifyDATA">修改</a>';
                rowItem += '    </td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_01">&nbsp;' + json[i].CompanyNameCHS + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_02" title="Password: ' + json[i].UserPWD + '">&nbsp;' + json[i].UserName + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_03">&nbsp;' + json[i].NameCHS + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_04">&nbsp;' + json[i].NameENG + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_05">&nbsp;' + json[i].Email + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_06">&nbsp;' + json[i].Question + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_07">&nbsp;' + json[i].Answer + '</td>';
                rowItem += '    <td id="Td_' + json[i].UserName + '_08">&nbsp;' + json[i].Activation + '</td>';
                rowItem += '</tr>';
                $("#table-company-list").append(rowItem);
            });

            ylQuery.Checkbox.ChoiceAll("chkAll", "chkItem");
            ylQuery.Checkbox.ChoicItem("chkAll", "chkItem");

            Modify();
        });
    });

    // 删除
    $("#btnDelete").click(function() {
        if (confirm("确定删除吗？")) {
            ylQuery.Controller({ form: "table-company-list", url: "/DataController.ashx?option=fw_user_delete" }, function(data) {
                var json = typeof (data) == "object" ? data : $.parseJSON(data);
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
        if (!ylQuery.DataValid.Form($("#UserName"), "请输入用户帐号！", "null")) {
            $("#UserName").focus();
            return false;
        }
        if (!ylQuery.DataValid.Form($("#Email"), "请输入正确格式的邮箱！", "email")) {
            $("#Email").focus();
            return false;
        }
        if (!ylQuery.DataValid.Form($("#CompanyID"), "请输入公司！", "null")) {
            $("#CompanyID").focus();
            return false;
        }
        if (!ylQuery.DataValid.Form($("#NameCHS"), "请输入姓名！", "null")) {
            $("#NameCHS").focus();
            return false;
        }
        if (!ylQuery.DataValid.Form($("#Question"), "请输入问题！", "null")) {
            $("#Question").focus();
            return false;
        }
        if (!ylQuery.DataValid.Form($("#Answer"), "请输入答案！", "null")) {
            $("#Answer").focus();
            return false;
        }

        ylQuery.Controller({ form: "table-company-update", url: "/DataController.ashx?Option=fw_user_update" }, function(data) {
            var json = typeof (data) == "object" ? data : $.parseJSON(data);
            if (json[0].Option == "false")
                alert("资料保存失败！");
            else {
                alert("资料保存成功！");
                window.parent.FwDialog.Close();
            }
        });
    });

    // 修改密码
    $("#btnModifyPWD").click(function() {
        if (!ylQuery.Valid.Form($("#OUserPWD"), "请输入原密码！", "null")) {
            $("#OUserPWD").focus();
            return false;
        }
        if (!ylQuery.Valid.Form($("#UserPWD"), "请输入新密码！", "null")) {
            $("#UserPWD1").focus();
            return false;
        }
        if (!ylQuery.Valid.Form($("#RUserPWD"), "请输入确认密码！", "null")) {
            $("#RUserPWD").focus();
            return false;
        }
        if ($("#UserPWD").val() != $("#RUserPWD").val()) {
            alert("请确认新密码与确认密码是否一致！");
            $("#RUserPWD").focus();
            return false;
        }

        ylQuery.Controller({ form: "table-company-update", url: "DataController.ashx?option=modify-pwd&username=" + ylQuery.QueryString("username") }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "origin-error") {
                alert("请输入正确的原密码！");
            }
            else {
                if (json[0].Option == "false") {
                    alert("资料保存失败！");
                }
                else {
                    alert("资料保存成功！");
                    window.parent.FwDialog.Close();
                }
            }
        });
    });
});

function Modify() {
    $("#table-company-list").find("a[name=aModifyDATA]").each(function(i) {
        $(this).click(function() {
            window.parent.FwDialog.Open(ylQuery.ContextPath + "Framework/User/update.aspx?option=modify&username=" + this.rel, { width: 600, height: 400, caption: "修改用户" });
        });
    });

    $("#table-company-list").find("a[name=aModifyPWD]").each(function(i) {
        $(this).click(function() {
        //window.parent.FwDialog.Open(ylQuery.ContextPath + "Framework/User/pwupdate.aspx?username=" + this.rel, { width: 350, height: 200, caption: "修改密码" });
        ylQuery.Dialog.Open("pwupdate.aspx?username=" + this.rel, { Caption: "修改密码", width: "400", height: "250" });
        });
    });
}
