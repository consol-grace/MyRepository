<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Description.aspx.cs" Inherits="AirExport_AEHAWB_Description" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Description for Manifest</title>
    <style type="text/css">
        *{ margin:0px; padding:0px; border:0px}
        
        #txtDescription
        {
            height: 174px;
            width: 400px;
            text-transform:uppercase;
            border:inset 1px #99BBE8
        }
    </style>
    <script type="text/javascript">
        function getText() {
            return document.getElementById("txtDescription").value.toUpperCase();
        }

        function setText() {

            var text = this.parent.txtDescriptionhide.getValue();
            var obj = document.getElementById("txtDescription");
            obj.value = text;
        }
    </script>
</head>
<body onload="setText();">
    <form id="form1" runat="server">
    <div>
         <textarea id="txtDescription"  rows="10" name="txtDescription" cols="5"></textarea> 
    </div>
    </form>
</body>
</html>
