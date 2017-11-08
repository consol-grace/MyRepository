

$(function() {

    //设置当前激活项
    //$(".grid_content_div tr:first td:first").css("background-color", "#EDEDED").attr("Active", "true");

    $("#UserGridPanel1 input:text").focus(function() {

        $(this).select();

        //获取正在编辑的项
        $("#UserGridPanel1 td").css("background-color", "#fff").attr("Active", "false");
        $(this).parent().parent().children("td:first").css("background-color", "#EDEDED").attr("Active", "true");

        //获取正在编辑的项数
        var value = 0;
        value = $(this).parent().parent().children("td:first").text() - 1;
        // alert(value);


        //绑定事件 
        $("#CompanyCode" + value).bind("blur", function() {

            var oldValue = $(this).val();
            $("#CompanyCode" + value).removeClass("border_bottom");

            if (oldValue == '' || oldValue == undefined)
                return;
            //处理事件
            $.getJSON("AjaxService/dataHandler.ashx?type=company&sys=&action=CompanyList&key=" + $("#CompanyCode" + value).val(), function(data) {

                if (data[0] != undefined) {
                    $("#CompanyName" + value).val(data[0].text)//.select()//.focus();
                }
                else {
                    $("#CompanyCode" + value).val("").addClass("border_bottom");
                    $("#CompanyName" + value).val("");
                }
            })
        })


        //绑定事件
        $("#CompanyName" + value).bind("blur", function() {

            var oldValue = $(this).val();
            $("#CompanyName" + value).removeClass("border_bottom");

            if (oldValue == '' || oldValue == undefined)
                return;
            //处理事件
            $.getJSON("AjaxService/dataHandler.ashx?type=company&sys=&action=CompanyListByName&key=" + $("#CompanyName" + value).val(), function(data) {

                if (data[0] != undefined) {
                    $("#CompanyCode" + value).val(data[0].text)//.select()//.focus();
                }
                else {
                    $("#CompanyName" + value).val("").addClass("border_bottom");
                    $("#CompanyCode" + value).val("");
                }
            })
        })

        //绑定事件 
        $("#Item" + value).bind("blur", function() {

            var oldValue = $(this).val();
            $("#Item" + value).removeClass("border_bottom");

            if (oldValue == '' || oldValue == undefined)
                return;
            //处理事件
            $.getJSON("AjaxService/dataHandler.ashx?type=item&sys=A&action=ItemBinding&key=" + $("#Item" + value).val(), function(data) {

                if (data[0] != undefined) {
                    $("#Description" + value).val(data[0].text)//.select()//.focus();
                }
                else {
                    $("#Item" + value).val("").addClass("border_bottom");
                    $("#Description" + value).val("");
                }
            })
        })


        //绑定事件
        $("#CalcKind" + value).bind("blur", function() {

            var oldValue = $(this).val();
            $("#CalcKind" + value).removeClass("border_bottom");

            if (oldValue == '' || oldValue == undefined)
                return;
            //处理事件
            $.getJSON("AjaxService/dataHandler.ashx?type=item&sys=A&action=QtyKindBinding&key=" + $("#CalcKind" + value).val(), function(data) {

                if (data[0] != undefined) {
                    $("#Qty" + value).val("1200.000")//.select()//.focus();
                    $("#Unit" + value).val("CNT")//.select()//.focus();
                }
                else {
                    $("#CalcKind" + value).val("").addClass("border_bottom");
                    $("#Qty" + value).val("");
                    $("#Unit" + value).val("");
                }
            })
        })


        //绑定事件
        $("#Currency" + value).bind("blur", function() {

            var oldValue = $(this).val();
            $("#Currency" + value).removeClass("border_bottom");

            if (oldValue == '' || oldValue == undefined)
                return;
            //处理事件
            $.getJSON("AjaxService/dataHandler.ashx?type=item&sys=A&action=CurrencysList&key=" + $("#Currency" + value).val(), function(data) {

                if (data[0] != undefined) {
                    $("#EX" + value).val(data[0].text)//.select()//.focus();
                }
                else {
                    $("#Currency" + value).val("").addClass("border_bottom");
                    $("#EX" + value).val("");
                }
            })
        })


        $("#Rate" + value).bind("blur", function() {

            //alert($(this).val());
            if ($(this).val() != "") {
                $("#Amount" + value).val("");
                var qty = $("#Qty" + value).val() == "" ? 0 : $("#Qty" + value).val();
                $("#Total" + value).val(Number(qty) * Number($(this).val()));
            }
        })

        $("#Amount" + value).bind("blur", function() {
            //alert($(this).val());
            if ($(this).val() != "") {
                $("#Rate" + value).val("");
                $("#Total" + value).val($(this).val());
            }
        })

    })

    $("#a_Delete").click(function() {
        var index = -1;
        $(".grid_content tr").each(function(i) {
            if ($(this).children("td").eq(0).attr("active") == "true") {
                index = i;
            }
        })
        if (index != -1) {
            $(".grid_content tr").eq(index).find("input").val("");
            $(".grid_content tr").eq(index).find("input").val("");
            $(".grid_content tr").eq(index).children("td").eq(2).find("input").focus();
        }
        else
            alert("Please select the row ? ");

    })

    $("#a_DeleteAll").click(function() {

        $(".grid_content tr").find("input").val("");
        $(".grid_content tr").find("input").val("");
        $(".grid_content_div tr:first td").eq(2).find("input").focus();
        $(".grid_content_div tr:first td:first").css("background-color", "#EDEDED").attr("Active", "true");

    })
})