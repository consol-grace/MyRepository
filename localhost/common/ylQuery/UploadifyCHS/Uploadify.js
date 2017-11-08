/// <reference path="../jquery.ui.custom/js/jquery-1.4.1.js" />
/// <reference path="../ylQuery.js" />

$(document).ready(function() {

    // chkAll 全选
    $("#chkAll").click(function() {
        if (this.checked == true)
            $("input[name=chkUploadify]").each(function(i) { this.checked = true; });
        else
            $("input[name=chkUploadify]").each(function(i) { this.checked = false; });
    });
    // 单选为全部选中，则全选为选中，否则反之
    $("input[name=chkUploadify]").click(function() {
        var chkLength = 1, chkCount = 0;
        if (typeof (document.all("chkUploadify").length) != 'undefined') chkLength = document.all("chkUploadify").length;
        $("input[name=chkUploadify]").each(function(i) { if (this.checked == true) chkCount++; });
        if (chkLength == chkCount) document.getElementById("chkAll").checked = true; else document.getElementById("chkAll").checked = false;
    });

    // 删除选中
    $("#btnDelete").click(function() {
        var chkCount = 0;
        $("input[name=chkUploadify]").each(function(i) { if (this.checked == true) chkCount++; });

        if (chkCount == 0) {
            alert("请选择需要删除的文件！");
        }
        else {
            if (confirm("确定删除吗？")) {
                pVar = "&OrderID=" + $(this).attr("OrderID") + "&TableName=" + $(this).attr("TableName") + "&AuthorityID=" + $(this).attr("AuthorityID");
                ylQuery.Controller({ form: "form1", url: "Uploadify.aspx?option=delete-select" + pVar }, function(data) {
                    var json = $.parseJSON(data);
                    if (json[0].Option == "false") {
                        alert("删除失败！");
                    }
                    else {
                        $.each(json, function(i) {
                            $("#" + json[i].RemoveID).remove();
                        });
                    }
                });
            }
        }
    });
});

// 加密
function UrlEncode(encode) {
    return $.ajax({ type: "post", dataType:"html", async: false, url: "Uploadify.aspx?Option=UrlEncode", data: {Encode: encode} }).responseText;
}

// delete
function UploadifyDelete(opts) {
    if (confirm("确认删除吗？")) {
        var strParams = "&RemoveID=" + opts.RemoveID + "&RowID=" + opts.RowID + "&filename=" + opts.FileName;
        ylQuery.Controller({ form: opts.selector, url: "Uploadify.aspx?Option=delete" + strParams }, function(data) {
            var json = $.parseJSON(data);
            if (json[0].Option == "false")
                alert("资料保存失败!");
            else {
                alert("资料保存成功!");
                $("#" + opts.selector).remove();
            }
        });
    }
}
// Download
function UploadifyDownload(opts) {
    window.location = "Uploadify.aspx?Option=download&filename=" + opts.NewFile + "&OriginName=" + opts.OriginFile;
}
