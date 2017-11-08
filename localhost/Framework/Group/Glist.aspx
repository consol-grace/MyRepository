<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Glist.aspx.cs" Inherits="Framework_Group_Glist" Theme="FORM" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <link href="../../Common/myplugin/myplugin.css" rel="stylesheet" type="text/css" />
        <script src="../../Common/myplugin/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/jquery.ui.custom.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.core.js" type="text/javascript"></script>
        <script src="../../Common/myplugin/myplugin.ui.js" type="text/javascript"></script>
        <script src="JScript.js" type="text/javascript"></script>
    </head>
    <body>
        <form id="form1" runat="server">
        
            <div class="clear">
                <div class="float-left splitor-right">
                    <div class="mypanel">
                        <table id="table1" cellpadding="0" cellspacing="0" border="0" style="width:300px">
                            <% 
                                for (int i = 0; dt != null && i < dt.Rows.Count; i++)
                                { 
                            %>
                            <tr>
                                <th class="left cursor" onclick='FwGroup.TreeRoot("<%= dt.Rows[i]["GroupID"] %>")'>&nbsp;<%= dt.Rows[i]["NameCHS"] %></th>
                            </tr>
                            <tr id='Tr<%= dt.Rows[i]["GroupID"] %>' class="hide">
                                <td>
                                    <div id="TreeList-Tr<%= dt.Rows[i]["GroupID"] %>"></div>
                                </td>
                            </tr>
                            <% 
                                }        
                            %>                            
                        </table>
                    </div>
                    
                </div>
                <div class="float-left pDiv">
                    <div class="mypanel">
                        <table id="table-menu-main" cellpadding="0" cellspacing="0" border="0" style="width:600px">
                            <tr>
                                <th>上级编号</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="ParentID" name="ParentID" value="0" />
                                    <input type="hidden" id="RootID" name="RootID" />
                                </td>
                                <th>上级名称</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="PNameCHS" name="PNameCHS" value="根" />
                                </td>
                            </tr>
                            <tr>
                                <th>群组编号</th>
                                <td>
                                    <input type="text" id="GroupID" name="GroupID" value="G1" />
                                </td>
                                <th>群组名称</th>
                                <td>
                                    <input type="text" id="NameCHS" name="NameCHS" value="系统管理员" />
                                </td>
                            </tr>
                            <tr>
                                <th>备注</th>
                                <td colspan="3">
                                    <input type="text" id="Remark" name="Remark" style="width:98%" value="#1" />
                                </td>
                            </tr>
                            <tr>
                                <th>管控</th>
                                <td colspan="3">
                                    <a href='javascript:void(0)' id="aGroupUser" name="aGroupUser">管控用户</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href='javascript:void(0)' id="aGroupMenu" name="aGroupMenu">管控菜单</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href='javascript:void(0)' id="aGroupPermission" name="aGroupPermission">管控权限</a>
                                </td>
                            </tr>
                        </table>                     
                        <div class="pDivSplitor">
                            <button type="button" id="btnSub">子级</button><button type="button" id="btnMain">同级</button><button type="button" id="btnDelete">删除</button><button type="button" id="btnSave1">保存</button>
                        </div>
                    </div>    
                    
                    
                    
                    <div id="pMainOrSub" class="mypanel">
                        <table id="table-menu-sub" cellpadding="0" cellspacing="0" border="0" style="width:600px">
                            <caption>新增同级</caption>
                            <tr>
                                <th>上级编号</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="ParentID1" name="ParentID1" />
                                    <input type="hidden" id="RootID1" name="RootID1" />
                                </td>
                                <th>上级名称</th>
                                <td>
                                    <input type="text" class="readonly" readonly="readonly" id="PNameCHS1" name="PNameCHS1" />
                                </td>
                            </tr>
                            <tr>
                                <th>群组编号</th>
                                <td>
                                    <input type="text" id="GroupID1" name="GroupID1" />
                                </td>
                                <th>群组名称</th>
                                <td>
                                    <input type="text" id="NameCHS1" name="NameCHS1" />
                                </td>
                            </tr>
                            <tr>
                                <th>备注</th>
                                <td colspan="3">
                                    <input type="text" id="Remark1" name="Remark1" style="width:98%" />
                                </td>
                            </tr>
                        </table>
                        <div class="pDivSplitor">
                            <button type="button" id="btnCancel">取消</button><button type="button" id="btnSave2">保存</button>
                        </div>
                    </div>                
                </div>             
                
            </div>
        
        </form>
    </body>
</html>
