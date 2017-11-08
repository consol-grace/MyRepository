<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Uploadify.aspx.cs" Inherits="Common_ylQuery_UploadifyCHS_Uploadify" EnableSessionState="False" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title></title>
        <%--<meta http-equiv="X-UA-Compatible" content="IE=7" />--%>
        <link href="../themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <link href="uploadify.css" rel="stylesheet" type="text/css" />
        <script src="../jquery.ui.custom/js/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="jquery.uploadify.js" type="text/javascript"></script>
        <script src="../ylQuery.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function() {
                $("#custom-queue").hide();
                $('#custom_file_upload').uploadify({
                    'uploader': 'uploadify.swf',
                    'script': "Uploadify.aspx?Option=FileUpload",
                    'cancelImg': 'cancel.png',
                    'folder': ylQuery.ContextPath + 'Uploadify;<%= this.OrderID %>;<%= this.TableName %>;<%= this.AuthorityID %>',
                    'multi': true,
                    'auto': true,
                    'fileExt': '*.jpg;*.gif;*.png;*.bmp', //'*.jpg;*.gif;*.png', 或 '*.*'
                    'fileDesc': 'Image Files (.JPG, .GIF, .PNG, .BMP)', // 'Image Files (.JPG, .GIF, .PNG)', 或 'All Files (*.*)'
                    'queueID': 'custom-queue',
                    'queueSizeLimit': 307200,   // 300K ( 307200 ), 1M ( 1048576 ), 50M ( 52428800 )
                    'simUploadLimit': 1,
                    'removeCompleted': false,
                    'onSelectOnce': function(event, data) {
                        $("#custom-queue").show();
                        $('#status-message').text(data.filesSelected + ' files have been added to the queue.');
                    },
                    'onAllComplete': function(event, data) {
                        $('#status-message').text(data.filesUploaded + ' files uploaded, ' + data.errors + ' errors.');
                        $("#custom-queue").hide();
                        window.location.reload();
                    }
                });
            });
        </script>
        <script src="Uploadify.js" type="text/javascript"></script>
    </head>
                
    <body>
        
            
            <div id="custom-demo" class="demo">                
                <div class="demo-box">
                    <div id="status-message" style="font-size:12px;"> 选择一些文件上传:</div>
                    <div id="custom-queue"></div>
                    <input id="custom_file_upload" type="file" name="Filedata" />
                    <input type="button" id="btnDelete" OrderID='<%= this.OrderID %>' TableName='<%= this.TableName %>' AuthorityID='<%= this.AuthorityID %>' style="margin:3px 0 0 0 \9;" />
                </div>                
            </div>
            
            <form id="form1" runat="server">
                <table class="TAB001" cellpadding="0" cellspacing="0" border="0" style="width:720px;">
                    <tr>
                        <th class="TAB003TH" style='white-space:nowrap;'>选择 <input type="checkbox" id="chkAll" name="chkAll" /></th>
                        <%--<th class="TAB003TH" style='white-space:nowrap;'>维护</th>--%>
                        <th class="TAB003TH" style='white-space:nowrap;'>序号</th>
                        <th class="TAB003TH" style='white-space:nowrap;'>原文件名</th>
                        <th class="TAB003TH" style='white-space:nowrap;'>新文件名</th>
                        <th class="TAB003TH" style='white-space:nowrap;'>文件大小</th>
                        <th class="TAB003TH" style='white-space:nowrap;'>上传人</th>
                        <th class="TAB003TH" style='white-space:nowrap;'>上传时间</th>
                    </tr>                
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr id='<%# Eval("RowID")%>'>
                                <td class="TAB001TD" style='white-space:nowrap;'>
                                    <input type="checkbox" name="chkUploadify" value='<%# Eval("RowID")%>;<%# UrlEncode(Eval("NewFile")) %>' />
                                    <input type="text" class="hide" id="OrderID" name="OrderID" value='<%# this.OrderID %>' />
                                    <input type="text" class="hide" id="TableName" name="TableName" value='<%# this.TableName %>' />
                                    <input type="text" class="hide" id="AuthorityID" name="AuthorityID" value='<%# this.AuthorityID %>' />
                                </td>
                                <%--<td class="TAB001TD" style='white-space:nowrap;'>
                                    <a href='javascript:void(0)' onclick='UploadifyDelete({selector:"form1_<%# Container.ItemIndex %>", RowID:"<%# Eval("RowID")%>", RemoveID:"<%# Eval("RowID")%>", FileName:"<%# UrlEncode(Eval("NewFile")) %>"})'>删除</a>
                                </td>--%>
                                <td class="TAB001TD"><%# Container.ItemIndex + 1 %></td>
                                <td class="TAB001TD" style='white-space:nowrap;'>
                                    <a href='javascript:void(0)' onclick='UploadifyDownload({NewFile:"<%# UrlEncode(Eval("NewFile")) %>",OriginFile:"<%# UrlEncode(Eval("OriginFile")) %>"})'><%# Eval("OriginFile")%></a>
                                </td>
                                <td class="TAB001TD" style='white-space:nowrap;'>&nbsp;<%# Eval("NewFile")%></td>
                                <td class="TAB001TD" style='white-space:nowrap;'>&nbsp;<%# Eval("FileSize")%></td>
                                <td class="TAB001TD" style='white-space:nowrap;'>&nbsp;<%# Eval("Creator")%></td>
                                <td class="TAB001TD" style='white-space:nowrap;'>&nbsp;<%# Eval("UploadDate")%></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </form>
        
    </body>
</html>
