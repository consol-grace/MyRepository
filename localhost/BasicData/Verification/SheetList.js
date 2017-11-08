$(function() {

    List();

    $("#btnFilter").click(function() {
        List();
        $("#txtSheetNo").focus().select();
    })

    $("#txtSheetNo").focus();

    $("#txtSheetNo,#txtMBL").keypress(function() {
        if (event.keyCode == 13) {
            $("#div_tablist tr").remove();
            event.keyCode = 0;
            List();
        }
    })

    $("#div_tablist input").keypress(function() {
        alert(event.keyCode);
    })

})




function List() {
   
    
    var SheetNo = $.trim($("#txtSheetNo").val());
    var MBL = $.trim($("#txtMBL").val());
    var Status = $("#drpStatus").val();

    $("#btnPrint").attr("list", "sheetNo=" + SheetNo + "&mbl=" + MBL + "&status=" + Status).click(function() {
        var url = 'SheetReport.aspx?' + $(this).attr("list");
        window.open(url, 'new');
    });

    var str = "";

    $("#div_tablist tr").remove();
    $("#btnFilter").attr("disabled", "disabled");
    $("#txtSheetNo,#txtMBL").attr("disabled", "disabled");
    $("#div_content").addClass("opacity").html("Loading...").show();

    $.getJSON("/BasicData/Verification/SheetList.ashx?type=list&sheetNo=" + SheetNo + "&MBL=" + MBL + "&Status=" + Status, function(data) {

        $.each(data, function(i, n) {
            str += "<tr class=\"tr_item\">"
                + "<td  class='Date' >" + n.DepDate + "</td>"
                + "<td  class='Sheet'><input class='input_sheet' oncut=\"return false\"   onpaste=\"return false\" type='text' value='" + n.sheet + "' /></td>"
                + "<td  class='Lotno'><input class='input_Lotno' oncut=\"return false\"   onpaste=\"return false\"  type='text' value='" + n.lotNo + "' /></td>"
                + "<td  class='M'>" + n.M + "</td>"
                + "<td  class='M'>" + n.H + "</td>"
                + "<td  class='Received'>" + n.received + "</td>"
                + "<td  class='Date'>" + n.recDate + "</td>"
                + "<td  class='Pkg'>" + n.pkg + "</td>"
                + "<td  class='Broker'><input class='Broker' oncut=\"return false\"   onpaste=\"return false\"  type='text' value='" + n.broker + "' /></td>"
                + "<td  class='Broker'><input class='Broker' oncut=\"return false\"   onpaste=\"return false\"  type='text' value='" + n.shipper + "' /></td>"
                + "<td  class='Dest'>" + n.dest + "</td>"
                + "<td  class='User'><input class='User' oncut=\"return false\"   onpaste=\"return false\" type='text' value='" + n.user + "' /></td>"
                + "<td  class='Flight'><input class='Flight' oncut=\"return false\"   onpaste=\"return false\"  type='text' value='" + n.flight + "' /></td>"
                + "</tr>";
        })

        $("#div_content").hide();
        $("#div_tablist").append(str);  //
       
        $("#div_tablist").find("input").keydown(function() {
            event.returnValue = false;
        })

        if (str == "") {
            $("#div_content").html("No Data").show();
        }

        $("#btnFilter").removeAttr("disabled");
        $("#txtSheetNo,#txtMBL").removeAttr("disabled"); 
        $("#txtSheetNo").focus();
    })


}