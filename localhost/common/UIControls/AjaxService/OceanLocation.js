$(function() {


    BinderdrpList("#ddlShipper", "GetCompany");
    BinderdrpList("#ddlConsignee", "GetCompany");

    $("#POL,#POD,#FINAL,#Receipt,#Destination,#LocationID1,#LocationID2,#LocationID3,#LocationID4,#LocationID5,#LocationID6,#LocationID7,#LocationID8,#LocationID9,#DropDownList1,#DropDownList2,#DropDownList3").autocomplete("/Tracking/AjaxService/DropDownList.ashx?sys=A&action=get-location", {
        // max: 12, //列表里的条目数 
        minChars: 0, //自动完成激活之前填入的最小字符 
        width: 104, //提示的宽度，溢出隐藏 
        scrollHeight: 300, //提示的高度，溢出显示滚动条 
        matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
        autoFill: false, //自动填充 
        scroll: "auto"
    })
})

function auto(obj) {
    $(obj).autocomplete("/Tracking/AjaxService/DropDownList.ashx?sys=A&action=get-location", {
        // max: 12, //列表里的条目数 
        minChars: 0, //自动完成激活之前填入的最小字符 
        width: 104, //提示的宽度，溢出隐藏 
        scrollHeight: 300, //提示的高度，溢出显示滚动条 
        matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
        autoFill: false, //自动填充 
        scroll: "auto"
    })
}



function BinderdrpList(obj, cmd) {

    var text = $(obj).val();

    $.getJSON("/Tracking/AjaxService/DropDownList.ashx?sys=O&action=" + cmd, function(data) {

        if (data != null) {

            $(obj + " option").remove();
            var count;
            $.each(data.Table, function(index, json) {
                count = index;
                $(obj).append('<option value=' + json.value + '>' + json.value + '</option>')
            });
            $(obj).val(text);
        }
    })
}