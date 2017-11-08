<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="AirImport_AIShipmentJobList_Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <style  media= "print" type="text/css"> 
        .Header   {   display: none;   }
   </style>   
</head>
<body>
    <form id="form1" runat="server">
     <OBJECT     id=WebBrowser     classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2     height=0     width=0   VIEWASTEXT> </OBJECT> 
    <div id="Header" style="width:545px" class="Header">
      <input onclick="document.all.WebBrowser.ExecWB(8,1)" type="button" value="設置"/>
      <input onclick="document.all.WebBrowser.ExecWB(7,1)" type="button" value="預覽"  />
      <input type="button" name="print" value="打印" onclick="document.all.WebBrowser.ExecWB(6,1)"/>
      <input type="button" name="print" value="直接打印" onclick="document.all.WebBrowser.ExecWB(6,6)"/>
      </div>
    <div id="content">
    <table style="width:756px; height:1086px;">
    <%--top and   content--%>
    <tr>
    <td style="text-align:center;vertical-align:top;width:100%;">
    <table style="width:100%;">
    <tr>
    <td style="text-align:center; vertical-align:top;">
    <table>
    <tr>
    <td style="font-size:21px;color:#000000;font-family:宋体;font-weight:bold; text-align:left; padding-left:100px;">
    CONSOLIDATOR INTERNATIONAL CO., LTD.
    </td>
    </tr>
     <tr>
    <td style="font-size:18px;color:#000000;font-family:宋体;font-weight:bold;text-align:left; padding-left:100px;">
    康 达 国 际 货 代 有 限 公 司 深 圳 分 公 司
    </td>
    </tr>
     <tr>
    <td style="font-size:13px;color:#000000;font-family:宋体;font-weight:bold;text-align:left; padding-left:100px;">
    Room 1306 13/F, Petrel Mansion,Jia Bin Road,Luo Hu District,ShenZhen,China
    </td>
    </tr>
     <tr>
    <td style="font-size:13px;color:#000000;font-family:宋体;font-weight:bold;text-align:left; padding-left:100px;">
    深 圳 市 罗 湖 区 嘉 宾 路 海 燕 大 厦 13 楼 1306 室   POST Code:51800
    </td>
    </tr>
     <tr>
    <td style="font-size:13px;color:#000000;font-family:宋体;font-weight:bold;text-align:left; padding-left:100px;">
    Tel:  (86)  0755-8238 8420     Fax:  (86)  0755-8238  8419
    </td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td style="text-align:center; vertical-align:top;">
    <table style="width:100%;">
    <tr>
    <td style="font-size:20px;color:#000000;font-family:Courier New;font-weight:bold;text-decoration:underline; text-align:center;">
    <%=ds.Tables[0].Rows[0]["rpt_Header"].ToString()%>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td style="text-align:left; vertical-align:top;">
    <table>
    <%  
        for(int i=0;i<ds.Tables[1].Rows.Count;i++)
        {
         %>
     <%if (ds.Tables[1].Rows[i]["RL_LINE"].ToString().Trim()!="") %>
     <% {%>
      <tr>
    <td style="font-size:13px;color:#000000;font-family:Courier New;font-weight:bold;">
     <%=ds.Tables[1].Rows[i]["RL_LINE"].ToString().TrimEnd().Replace(" ","&nbsp;")%>
     </td>
    </tr>
     <% }else
            {%>
           <tr>
    <td style="font-size:13px;color:#000000;font-family:Courier New;font-weight:bold;"></td></tr>  
            <%} %>
  
   <%
        } 
     %>
    </table>
    </td>
    </tr>
    <tr>
    <td style="text-align:left; vertical-align:top;">
    <table>
    <tr>
    <td style="font-size:12px;color:#000000;font-family:Courier New;font-weight:bold; width:98%;">
    <%=ds.Tables[0].Rows[0]["rpt_RptFooter"].ToString()%> 
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    <%--foot--%>
    <tr>
    <td style="text-align:left;vertical-align:bottom;width:100%; ">
    <table style="width:100%;">
    <tr>
    <td style="text-align:left; vertical-align:top;">
    <table style="width:98%;height:80px;">
    <tr><td style="font-size:16px;color:#000000;font-family:Courier New;font-weight:bold;width:60px; text-align:right; vertical-align:top;">Remarks</td>
    <td>
    <table><tr><td style=" border:solid 2px #000; height:80px;width:500px; vertical-align:top;font-size:12px;color:#000000;font-family:宋体;font-weight:normal;">
     <%=ds.Tables[0].Rows[0]["rpt_Footer"].ToString() %>
    </td></tr></table>
   
    </td>
    <td style="width:20%;">
    <table>
    <tr><td style="font-size:16px;color:#000000;font-family:Courier New;font-weight:bold;width:60px; text-align:center; vertical-align:top; height:20px; padding-left:10px;">SIGNATURE</td></tr>
    <tr><td style="height:60px;vertical-align:bottom; text-align:right; padding-left:15px;"><hr style="width:100px; border:solid 1px #000;"/></td></tr>
    </table>
    </td></tr>
    </table>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table> 
    </div>
    </form>
</body>
</html>
