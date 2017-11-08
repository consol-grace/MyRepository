<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="BasicData_Country_list" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Country</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
       <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
        <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
        <link href="../../common/ylQuery/themes/ylQuery.css" rel="stylesheet" type="text/css" />
        <script src="../../common/ylQuery/ylQuery.js" type="text/javascript"></script>

	  <script type="text/javascript" src="Controller.js"></script>
</head>
<body>
    <form id="form1" runat="server">
   <ext:ResourceManager ID="ResourceManager1" runat="server">
   <CustomDirectEvents>
    <ext:DirectEvent Target="Save" OnEvent="Binding"/>
    <ext:DirectEvent Target="Next" OnEvent="Binding"/>
   </CustomDirectEvents>
   </ext:ResourceManager>

   <div id="location_div01">
    <div id="countryControl">
	<table  border="0" cellpadding="0" cellspacing="0"   class="table_25left">
	<tr>
<td> <table width="50" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="font_11bold">Code</td>
</tr>
</table></td>
<td width="62">
<%--<input name="Code" type="text" class="text_75px" id="Code" tabindex="1"/>--%>
<ext:TextField ID="Code" Name="Code" runat="server" Cls="text_70px" Width="81" TabIndex="1">
                                            </ext:TextField>
   <input name="hidRowID" type="hidden" class="text_70px" id="hidRowID"/>                           
</td>
<td width="15" style="padding-left:15px">&nbsp;</td>
<td width="12">&nbsp;</td>
<td width="12">&nbsp;</td>
<td  class="font_11bold" style="padding-left:10px">&nbsp;</td>
</tr>
<tr>
<td width="42"><table width="50" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="font_11bold">Name</td>
</tr>
</table></td>
<td colspan="5"><%--<input name="Name" type="text" class="text_160px" id="Name" tabindex="2"/>--%>
<ext:TextField ID="Name" runat="server" Cls="text_70px" Width="206" TabIndex="2">
                                            </ext:TextField></td>
</tr>
	</table>
	<table  border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
	<td colspan="4" align="right" height="10"></td>
	</tr>
	<tr>
	
<td align="right">
<table cellpadding="0" cellspacing="0" border="0"><tr>
<td align="right" style="padding-right:5px">
	<table width="50" border="0" cellpadding="0" cellspacing="0">
<tr>
<td ><input type="checkbox" name="chkActive" value="checkbox" id="chkActive" checked="checked"  tabindex="3"/></td>
<td class="font_11bold" style="padding-left:3px">Active</td>
</tr>
</table>
	</td>
<td>
<ext:Button runat="server" ID="Next" Cls="Submit_70px" Text="Next" Width="70px">
<Listeners>
<Click Fn="NextClick" />
</Listeners>
</ext:Button>
</td><td style="padding-left:2px">
<ext:Button runat="server" ID="Cancel" Cls="Submit_70px" Text="Cancel" Width="70px" >
<Listeners>
<Click Fn="CancelClick" />
</Listeners>
</ext:Button>
</td><td style="padding-left:2px">
<ext:Button runat="server" ID="Save" Cls="Submit_70px" Text="Save" Width="70px">
<Listeners>
<Click Fn="SaveClick" />
</Listeners>
</ext:Button>
</td></tr></table>
</td>	</tr>
	</table>
	</div>
	<table  border="0" cellspacing="0" cellpadding="0">
<tr>
<td height="10"></td>
</tr>
</table>

<table  border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td><table border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<%--<td id="GridView"></td>--%>
	<td >
        <ext:GridPanel
            ID="GridPanel1"
            runat="server" 
            StripeRows="true"
            Width="400" 
            Height="446"
            AutoExpandColumn="Code">
           <Store>
                <ext:Store runat="server" ID="ctl45">
                    <Reader>
                        <ext:JsonReader IDProperty="RowID">
                            <Fields>
                                <ext:RecordField Name="Code" />
                                <ext:RecordField Name="Name" />
                                <ext:RecordField Name="Active"/>
                            </Fields>
                        </ext:JsonReader>
                    </Reader>
                </ext:Store>
            </Store>  
             <Listeners>
            <rowclick Fn="rowclickFn" />
           </Listeners>
            <ColumnModel runat="server" ID="ctl46">
                <Columns>
                    <ext:RowNumbererColumn Width="30" Header="No."/>
                    <ext:Column DataIndex="Code" Header="Code" Width="100" />
                    <ext:Column DataIndex="Name" Header="Name" Width="200" />
                    <ext:CheckColumn DataIndex="Active" Header="Active" Width="50"/>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true"/>
            </SelectionModel>
            <LoadMask ShowMask="true" Msg="Loading..." AutoDataBind="true"/>
           
        </ext:GridPanel>
	</td>
	</tr>
	</table></td>
	</tr>
	</table>
	</div>
    </form>
</body>
</html>
