<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="/App_Themes/LOGIN/mframe.css" rel="stylesheet" type="text/css" />
    <link href="/css/style.css" type="text/css" rel="stylesheet" />
    <title>CONSOLDATOR</title>

</head>
<body>
    <table border="0" cellspacing="0" cellpadding="0" align="left">
        <tr>
            <!-- left end-->
            <td id="tdContent" valign="top" class="text_bg" >
                <%--content start--%>
                <table  border="0" cellspacing="0" cellpadding="0" style="padding-top: 31px;
                    padding-left: 15px">
                    <tr>
                         <%
                             string MenuList = MenuHelper.GetMenu("MenuList");  
                             //if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[14].ToString().IndexOf("M05") >= 0)
                           if (MenuList.IndexOf("M05") >= 0)
                          {  %>
                        <td width="190">
                            <a href="../AirExport/AEViewConsol/List.aspx">Air Export</a>
                        </td>
                        <%} %>
                         <%   //if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[14].ToString().IndexOf("M02") >= 0)
                             if (MenuList.IndexOf("M02") >= 0)
                          { %>
                        <td width="190">
                            <a href="../AirImport/AIShipmentJobList/list.aspx">Air Import</a>
                        </td>
                         <%} %>
                         <% //if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[14].ToString().IndexOf("M06") >= 0)
                             if (MenuList.IndexOf("M06") >= 0)
                          { %>
                        <td width="190">
                            <a href="../OceanExport/OEJobList/List.aspx">Ocean Export</a>
                        </td>
                         <%} %>
                         <% //if (DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[14].ToString().IndexOf("M03") >= 0)
                             if (MenuList.IndexOf("M03") >= 0)
                          { %>
                        <td width="190">
                            <a href="../OceanImport/OceanShipmentJobList/OIJobList.aspx">Ocean Import</a>
                        </td>
                         <%} %>
                        
                    </tr>
                </table>
            
            </td>
        </tr>
    </table>
</body>
</html>
