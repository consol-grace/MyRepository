$(function() {

    var scrollTop = 0;
    $(window).scroll(function() {

        //scrollTop = document.documentElement.scrollTop;
    })

    var cntrNo = $("#txtCntrNo").val();
    var toMbl = $("#txtToMBL").val();

    list(toMbl, cntrNo);

    $(document).keydown(function(e) {
        var line = count + 1;
        if (e.keyCode == 45) {
            //if ($(".tr_line_" + line).length == 0) {
            CreateLine(line);
            //} else {
            //    $(".tr_line_" + line).find("input[type='text']").eq(1).focus();
            //}
        }
    })

    $("#btn_Insert").click(function() {
        var line = count + 1;
        if ($(".tr_line_" + line).length == 0) {
            CreateLine(line);
        }
        else {
            $(".tr_line_" + line).find("input[type='text']").eq(1).focus();
        }
    })


    //    $(".btn_CLP").click(function() {

    //        $("#div_offical").hide();  /////

    //        var cntrNo = $(this).attr("CntrNo");
    //        var toMbl = $(this).attr("ToMBL");

    //        $("#txtcntrNo").val(cntrNo);
    //        $("#txtToMBL").val(toMbl);
    //        $("#labCntrNo").text(cntrNo);

    //        list(toMbl, cntrNo);
    //        $("#div_CLP").show();
    //        
    //        var width = ($(window.document).width() - $("#div_sheet").width()) / 2;

    //        $("#win_show").height($(document).height()).fadeIn("fast").click(function() { SheetClose(); });
    //        $("#div_sheet").css({ left: width }).fadeIn("fast");
    //        $("#div_sheet").find("input").eq(0).focus();

    //        //        var date = new Date();
    //        //        var v = date.getFullYear() + "" + parseInt(date.getMonth() + 1) + "" + date.getDate() + "" + date.getHours() + "" + date.getMinutes() + "" + date.getSeconds();

    //        //var script = document.createElement("script");
    //        //script.setAttribute("type", "text/javascript");
    //        //script.setAttribute("src", "/common/UIControls/UserSheet.js?v=" + v);
    //        //window.parent.document.body.appendChild(script);

    //        //$(window.parent.div_parent_show).show();
    //        //$(window.parent.div_parent_content).html($("#div_CLP").html()).show();
    //    })


    $("#win_close_sheet").click(function() {
        SheetClose();
    })

})


var edit = 0;

function SheetClose() {
    $("#txtSheetNO").val("");
    $("#txtPKG").val("");
    $("#win_show").fadeOut("fast");
    $("#div_sheet").fadeOut("fast");
    if (edit == 1) {
        //        this.location.reload();
    }
}


var count = 0;
///绑定列表
function list(ToMBL, CntrNo) {
    $("#span_loading").html("请稍等，数据正在加载中...");
    $("#tab_Replist tr").remove();
    var str = "";
    $.getJSON("/common/UIControls/CLP.ashx?type=list&seed=" + ToMBL + "&CntrNo=" + CntrNo, function(data) {
        $.each(data, function(i, n) {
            str += "<tr  class=\"tr_line\">";
            str += "<td  style='display:none'><input type=\"text\" cls=\"txt_rowid_\"  class=\"txt_rowid_" + i.toString() + "\"  value=\"" + n.rowid + "\" /></td>";
            str += "<td  class='td_checkbox' width=\"30\"><input type='checkbox' cls=\"chk_ismain_\"   class=\"chk_ismain_" + i.toString() + "\"  " + (n.isMain == "Y" ? "checked='checked'" : "") + " ></td>";
            str += "<td  class='td_Sheet' width=\"90\"><input type=\"text\"  cls=\"txt_sheet_\"  class=\"txt_sheet_" + i.toString() + "\"  value=\"" + n.subMBL + "\" /></td>";
            str += "<td  class='td_hbl' width=\"90\">" + selectlist(n.hbl, i) + "</td>";
            str += "<td  class='td_goods' width=\"90\"><input type=\"text\"  cls=\"txt_goods_\" class=\"txt_goods_" + i.toString() + "\" value=\"" + n.factory + "\" /></td>";
            str += "<td  class='td_req' width=\"70\"><input type=\"text\"  cls=\"txt_req_\" class=\"txt_req_" + i.toString() + "\" value=\"" + n.req + "\" /></td>";
            str += "<td  class='td_pkg' width=\"50\"><input type=\"text\"  cls=\"txt_pkg_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_pkg_" + i.toString() + "\" value='" + n.pkg + "' /></td>";
            str += "<td  class='td_gwt' width=\"50\"><input type=\"text\"  cls=\"txt_gwt_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_gwt_" + i.toString() + "\" value='" + n.gwt + "' /></td>";
            str += "<td  class='td_cbm' width=\"50\"><input type=\"text\"  cls=\"txt_cbm_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_cbm_" + i.toString() + "\" value='" + n.cbm + "' /></td>";
            str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_DecNo_\" class=\"txt_DecNo_" + i.toString() + "\" value='" + n.DeclarationNo + "' /></td>";
            str += "<td  class='td_rec' width=\"80\">" + createCheck(n.received, n.rowid, i.toString()) + "</td>";
            str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_ExpressNo_\" class=\"txt_ExpressNo_" + i.toString() + "\" value='" + n.ExpressNo + "' /></td>";
            str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_Remark_\" class=\"txt_Remark_" + i.toString() + "\" value='" + n.Remark + "' /></td>";
            str += "<td  class='td_action' width=\"35\"><a style='display:none' href='javascript:void(0);' onclick=\"Save('" + n.rowid + "','" + i + "')\">保存</a> <a style='display:none'>|</a> <a href='javascript:void(0);' onclick='Delete(" + n.rowid + "," + i.toString() + ");'><img src='/images/clp_deletes.gif' title=''></a></td>"
            str += "</tr>";
            count = i;
        })
        $("#span_loading").html("");
        $("#tab_Replist").append(str).find("input").hover(function() {
            $(this).addClass("hover");
        }, function() {
            $(this).removeClass("hover");
        }).focus(function() {
            $(this).addClass("hover");
        }).blur(function() {
            $(this).removeClass("hover");
        });

        $("#tab_Replist").focus().find("input[type='checkbox']").click(function() {
            if ($(this).attr("checked")) {
                $("input[type='checkbox']").removeAttr("checked");
                $(this).attr("checked", "checked");
            }
        });

        $("#tab_Replist").find("select").change(function() {
            var shipper = $(this).val();
            var currindex = $(this).attr("rowid");
            $(".txt_goods_" + currindex).val(shipper);
        })

        $("#tab_Replist tr").each(function(index) {
            $(this).find("input,select,a").focus(function() {
                $("#txtComRemark").val($(".txt_Remark_" + index.toString()).val());
                $("#txtComRequest").val($(".txt_req_" + index.toString()).val());
            })
        })
        $("#tab_Replist tr").each(function(index) {
            $(this).find("input").keydown(function(e) {
                if (e.keyCode == 40) {
                    var classID = $(this).attr("cls") + (index + 1);
                    $("." + classID).focus();
                }
                else if (e.keyCode == 38) {
                    var classID = $(this).attr("cls") + (index - 1);
                    $("." + classID).focus();
                }
            })
        })
    })
}



/// input select
function selectlist(value, rowid) {

    var CntrNo = $("#txtCntrNo").val();
    var ToMBL = $("#txtToMBL").val();
    var strlist = "";
    $.ajaxSettings.async = false;
    $.getJSON("/common/uicontrols/CLP.ashx?type=hbllist&seed=" + ToMBL + "&CntrNo=" + CntrNo, function(data) {

        strlist += "<select rowid='" + rowid + "'  class=\"txt_hbl_" + rowid.toString() + "\"  onkeyup=\"this.blur();this.focus();\" ><option value=''></option>";
        if (data != null) {
            $.each(data, function(i, n) {
                if (value == n.hbl) { strlist += "<option value=\"" + n.shipper + "\" selected=\"selected\">" + n.hbl + "</option>"; }
                else { strlist += "<option value=\"" + n.shipper + "\">" + n.hbl + "</option>"; }
            })
        }

        strlist += "</select>";
    })
    return strlist;
}

///2已退回 1 退回  0寄出
function createCheck(value, rowid, i) {
    var strinput = "";
    var val = value.split(",");
    if (val[1] == "0" || val[1] == undefined || val[1] == null) {
        strinput = "<input type=\"text\" style=\"display:none;\"  dateType=\"1\" class=\"txt_received_" + i.toString() + "\"  /><input type=\"button\" class=\"btn_Rec\" style=\"margin-right:5px;\" onclick=\"CheckReceive(" + rowid + "," + i + "," + val[1] + ")\" value='寄出' />";
    }
    else if (val[1] == "1") {
    strinput = "<input type=\"text\"  style=\"text-align:left;width:33px;margin-right:3px;\" dateType=\"1\" class=\"txt_received_" + i.toString() + "\" value=\"" + val[0] + "\"  /><input class=\"btn_Rec\"  style=\"margin-right:5px;\" type=\"button\" onclick=\"CheckReceive(" + rowid + "," + i + "," + val[1] + ")\" value='退回' />";
    }
    else if (val[1] == "2") {
    strinput = "<input type=\"text\"  style=\"text-align:left;width:33px;margin-right:3px;\" dateType=\"2\" class=\"txt_received_" + i.toString() + "\" value=\"" + val[0] + "\"  /><span style=\"margin-right:5px;\">已退回</span>";
    }
    return strinput;
}


function CreateLine(i) {
    var str = "";
    str += "<tr  class=\"tr_line tr_line_" + i.toString() + "\">";
    str += "<td  style='display:none'><input type=\"text\" class=\"txt_rowid_" + i.toString() + "\"  value=\"-1\" /></td>";
    str += "<td  class='td_checkbox' width=\"30\"><input type='checkbox'  cls=\"chk_ismain_\" class=\"chk_ismain_" + i.toString() + "\"></td>"
    str += "<td  class='td_Sheet' width=\"90\"><input type=\"text\"  cls=\"txt_sheet_\" class=\"txt_sheet_" + i.toString() + "\"  value=\"\" /></td>";
    str += "<td  class='td_hbl' width=\"90\">" + selectlist('', i) + "</td>";
    str += "<td  class='td_goods' width=\"90\"><input type=\"text\"  cls=\"txt_goods_\"   class=\"txt_goods_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_req' width=\"70\"><input type=\"text\" cls=\"txt_req_\" class=\"txt_req_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_pkg' width=\"50\"><input type=\"text\"  cls=\"txt_pkg_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_pkg_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_gwt' width=\"50\"><input type=\"text\"  cls=\"txt_gwt_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_gwt_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_cbm' width=\"50\"><input type=\"text\"  cls=\"txt_cbm_\" style=\"text-align:right;padding-right:2px;\" class=\"txt_cbm_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_DecNo_\" class=\"txt_DecNo_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_rec' width=\"80\"><input type=\"text\" style=\"display:none;\"  dateType=\"0\" class=\"txt_received_" + i.toString() + "\"  /></td>";
    str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_ExpressNo_\" class=\"txt_ExpressNo_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_remark' width=\"80\"><input type='text'  cls=\"txt_Remark_\" class=\"txt_Remark_" + i.toString() + "\" value=\"\" /></td>";
    str += "<td  class='td_action' width=\"35\"><a style='display:none;' href='javascript:void(0);' onclick=\"Save('-1','" + i + "')\">保存</a> <a style='display:none'>|</a> <a href='javascript:void(0);' onclick='RemoveLine(this);'><img src='/images/clp_deletes.gif'></a></td>"
    str += "</tr>";
    $("#tab_Replist tr").last().after(str);
    ++count;
    $("#tab_Replist tr").last().find("input[type='text']").eq(1).focus();
    $("#tab_Replist tr").find("select.txt_hbl_" + i.toString()).change(function() {
        var shipper = $(this).val();
        $(".txt_goods_" + i.toString()).val(shipper);
    })
    $("#tab_Replist").find("input[type='checkbox']").click(function() {
        $("input[type='checkbox']").removeAttr("checked");
        $(this).attr("checked", "checked");
    })
    $("#tab_Replist tr").each(function(index) {
        $(this).find("input").keydown(function(e) {
            if (e.keyCode == 40) {
                var classID = $(this).attr("cls") + (index + 1);
                $("." + classID).focus();
            }
            else if (e.keyCode == 38) {
                var classID = $(this).attr("cls") + (index - 1);
                $("." + classID).focus();
            }
        })
    })
}

function RemoveLine(obj) {

    --count;
    $(obj).parent("td").parent("tr").remove();

}


///rowid ,  当前行号
function Save(rowid, currindex) {

    var ToMBL = $("#txtToMBL").val();
    var CntrNo = $("#txtCntrNo").val();

    var subMBL = $(".txt_sheet_" + currindex).val().toUpperCase();
    var pkg = $(".txt_pkg_" + currindex).val();
    var gwt = $(".txt_gwt_" + currindex).val();
    var cbm = $(".txt_cbm_" + currindex).val();
    var req = $(".txt_req_" + currindex).val();
    var goods = encodeURIComponent($(".txt_goods_" + currindex).val())
    var hbl = $(".txt_hbl_" + currindex).find("option:selected").text();
    if (hbl == "" || hbl == null || hbl == undefined || hbl == NaN) {
        Ext.Msg.alert("Status", "Error ,HBL can't empty. ", function() {
            $(".txt_hbl_" + currindex).focus();
        });
        return false;
    }
    var rec = $(".txt_received_" + currindex).val();
    if (rec == null || rec == undefined || rec == "" || rec == NaN)
    { rec = ""; }

    $.get("/common/uicontrols/CLP.ashx?type=update&rowid=" + rowid + "&tombl=" + ToMBL + "&CntrNo=" + CntrNo + "&subMBL=" + subMBL + "&pkg=" + pkg + "&gwt=" + gwt + "&cbm=" + cbm + "&req=" + req + "&goods=" + goods + "&hbl=" + hbl + "&rec=" + rec, function(data) {

        if (data == "Y") {
            if (rowid < 0)
                list(ToMBL, CntrNo);
            else {
                $(".txt_sheet_" + currindex).focus();
                $("#tab_Replist tr").eq(currindex).find("td.td_rec").html(createCheck(rec, rowid, currindex));
            }
        }
        else {
            Ext.Msg.alert("Status", "Error , Please checked the data .", function() {
                $(".txt_sheet" + currindex).focus();
            });
        }
    })

}

///save all
function SaveAll() {

    var json = "[";
    //var len = $("#tab_sheet tr").size();
    var len = $("#tab_Replist > tbody").children("tr").length;
    for (var currindex = 0; currindex < len; ++currindex) {
        var ToMBL = $("#txtToMBL").val();
        var CntrNo = $("#txtCntrNo").val();
        var ExpressNo = $(".txt_ExpressNo_" + currindex).val();
        var Remark = $(".txt_Remark_" + currindex).val();
        var DirationNo = $(".txt_DecNo_" + currindex).val();
        var rowid = $(".txt_rowid_" + currindex).val();
        var subMBL = $(".txt_sheet_" + currindex).val().toUpperCase();
        var pkg = $(".txt_pkg_" + currindex).val();
        var gwt = $(".txt_gwt_" + currindex).val();
        var cbm = $(".txt_cbm_" + currindex).val();
        var req = $(".txt_req_" + currindex).val();
        var goods = $(".txt_goods_" + currindex).val();
        var hbl = $(".txt_hbl_" + currindex).find("option:selected").text();
        if (hbl == "" || hbl == null || hbl == undefined || hbl == NaN) {
            Ext.Msg.alert("提示", "进仓编号不能为空！ ", function() {
                $(".txt_hbl_" + currindex).focus();
            });
            return false;
        }
        var rec = $(".txt_received_" + currindex).val();
        if (rec == null || rec == undefined || rec == "" || rec == NaN)
        { rec = ""; }
        var status = $(".txt_received_" + currindex).attr("dateType");
        var isMain = $(".chk_ismain_" + currindex).attr("checked") == "checked" || $(".chk_ismain_" + currindex).attr("checked").toString() == "true" ? "Y" : "N";
        
        if (currindex == 0)
            json += "{vv_ToMaster:\"" + ToMBL + "\",vv_CntrNo:\"" + CntrNo + "\",vv_rowid:\"" + rowid + "\",vv_VerifyNo:\"" + subMBL + "\",vv_Piece:\"" + pkg + "\",vv_gwt:\"" + gwt + "\",vv_cbm:\"" + cbm + "\",vv_require:\"" + req + "\",vv_factory:\"" + goods + "\",vv_hbl:\"" + hbl + "\",vv_ReceivedDate:\"" + rec + "\",vv_ExpressNo:\"" + ExpressNo + "\",vv_Remark:\"" + Remark + "\",vv_DirationNo:\"" + DirationNo + "\",vv_isMain:\"" + isMain + "\",status:\""+status+"\" }";
        else
            json += ",{vv_ToMaster:\"" + ToMBL + "\",vv_CntrNo:\"" + CntrNo + "\",vv_rowid:\"" + rowid + "\",vv_VerifyNo:\"" + subMBL + "\",vv_Piece:\"" + pkg + "\",vv_gwt:\"" + gwt + "\",vv_cbm:\"" + cbm + "\",vv_require:\"" + req + "\",vv_factory:\"" + goods + "\",vv_hbl:\"" + hbl + "\",vv_ReceivedDate:\"" + rec + "\",vv_ExpressNo:\"" + ExpressNo + "\",vv_Remark:\"" + Remark + "\",vv_DirationNo:\"" + DirationNo + "\",vv_isMain:\"" + isMain + "\",status:\"" + status + "\" }";

    }
    json += "]";

    $.post("/common/uicontrols/CLP.ashx", { type: "updatelist", content: json, async: true }, function(data) {
        if (data == "Y")
        { Ext.Msg.alert("提示", "数据保存成功！ "); list(ToMBL, CntrNo); }
        else { Ext.Msg.alert("提示", "数据保存失败，请检查数据！ "); }
    })
}


///删除
function Delete(rowid, currindex) {

    edit = 1;
    var ToMBL = $("#txtToMBL").val();
    var CntrNo = $("#txtCntrNo").val();

    Ext.Msg.confirm("Status", "Are you sure you want to delete ? ", function(btn) {
        if (btn == "yes") {
            $.get("/common/uicontrols/CLP.ashx?type=delete&rowid=" + rowid, function(data) {

                if (data == "Y") {
                    list(ToMBL, CntrNo);
                    //RemoveLine(currindex);
                }
                else
                    Ext.Msg.alert("Status", "Error , Please checked the data .");
            })
        }
    })
}


function CheckReceive(rowid, i, status) {

    var ToMBL = $("#txtToMBL").val();
    var CntrNo = $("#txtCntrNo").val();

    $.get("/common/uicontrols/CLP.ashx?type=CheckReceive&rowid=" + rowid + "&status=" + status, function(data) {

        if (data != "N") {
            //$("#tab_Replist tr").eq(i).find("td.td_rec").html(createCheck(data, rowid, i));
            list(ToMBL, CntrNo);
        }
        else
            Ext.Msg.alert("Status", "Error , Please checked the data .");
    })
}


///提示信息  显示内容 显示多少秒消失
function MsgTip(msg, time) {
    $("#txtMsg").text(msg);
    setTimeout(function hide() { $("#txtMsg").text(""); }, time);
}


function LoadWidth() {

    //    var width = $(".tab_sheet").width();
    //    var sheet = width - 210;
    //    $("td.td_Sheet").width(sheet);
}
