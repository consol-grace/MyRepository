function auto(obj, sys, cmdText) {

    $(obj).autocomplete("AjaxService/DropDownList.ashx?sys=" + sys + "&action=" + cmdText, {
        // max: 12, //列表里的条目数 
        minChars: 0, //自动完成激活之前填入的最小字符 
        //width:, //提示的宽度，溢出隐藏 
        scrollHeight: 300, //提示的高度，溢出显示滚动条 
        matchContains: false , //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
        autoFill: false , //自动填充
        scroll: "auto"
        //highlight: false   
               
    })
}

function drpList(obj, sys, cmdText) {

    var text = $(obj).val();

    $.getJSON("AjaxService/DropDownList.ashx?type=drplist&sys=" + sys + "&action=" + cmdText, function(data) {

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