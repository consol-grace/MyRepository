/// <reference path="myplugin/jquery-1.4.1.js" />
/// <reference path="ylQuery.js" />

var dialog = ylQuery.Dialog;

$(document).ready(function() {

    $("#btnBrowserVersionView").click(function() {
        var browser = ylQuery.Browser();
        alert(browser.version);
    });

    $("#btnContextPathView").click(function() {
        alert(ylQuery.ContextPath);
    });

    $("#btnDialog").click(function() {
        ylQuery.Dialog.Open("http://mail.qq.com", { width: 800, height: 600, title: "QQ 邮箱" });
    });

    $("#btnUploadify").click(function() {
        ylQuery.Uploadify({ title: "上传文件", width: 800, height: 480, orderId: "TN1", tableName: "JMJOK_Products", authorityId: "12345678" });
    });
    $("#btnUploadifyENG").click(function() {
        ylQuery.Uploadify({ language: "ENG", title: "Upload files", width: 800, height: 480, orderId: "TN1", tableName: "JMJOK_Products", authorityId: "12345678" });
    });

    $("#btnAddNew_TableDome").click(function() {
        var row, dt = new ylQuery.DataTable("table-dome-list"); dt.Clear();

        row = new dt.NewRow();
        row.Add("值 011");
        row.Add("值 012");
        row.Add("值 013");
        dt.Rows.Add(row);

        row = new dt.NewRow();
        row.Add("值 021");
        row.Add("值 022");
        row.Add("值 023");
        dt.Rows.Add(row);

        row = new dt.NewRow();
        row.Add("值 031");
        row.Add("值 032");
        row.Add("值 033");
        dt.Rows.Add(row);

        dt.AcceptChanges();
    });
    $("#btnAddNew_TableData").click(function() {
        ylQuery.Controller({ form: "table-dome-data", url: "ylQueryExamples.aspx?Option=table-dome-list" }, function(data) {
            alert(data);
            return false;

            var json = $.parseJSON(data);
            var row, dt = new ylQuery.DataTable("table-dome-list"); dt.Clear();

            $.each(json, function(i) {
                row = new dt.NewRow();
                row.Add(json[i].NameCHS);
                row.Add(json[i].Email);
                row.Add(json[i].Tel);
                dt.Rows.Add(row);
            });
            dt.AcceptChanges();
        });
    });


    if (ylQuery.QueryString("id") != "") alert(ylQuery.QueryString("id"));
    $("#btnQueryString").click(function() {
        window.location = "ylQuery.Examples.html?id=M101";
    });

});
