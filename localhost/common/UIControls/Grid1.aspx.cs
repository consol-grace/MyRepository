using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.FRAMEWORK;
using Ext.Net;
using System.IO;

public partial class common_UIControls_Grid1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtName.Value = "SABTOYHK02";
            txtName.Text="SABABA TOYS INC C/O WAH LUNG TOYS CO., LTD. ";

            txtPass.Value = "C/O";
            txtPass.Text = "C/O";
           
            
            //datafield1.Format = "dd/m/Y";
            //datafield1.AltFormats = "d/M/Y|d/M|d/M/y";

            //datafield1.Format = "m/dd/Y";
            //datafield1.AltFormats = "M/dd/Y|M/dd|M/dd/y";
        
            //datafield1.Format = "Y/m/dd";
            //datafield1.AltFormats = "Y/M/dd|M/dd|y/M/dd";

            ControlBinder.DateFormat(datafield1);
        }
    }

    

    protected void btn_Click(object sender, DirectEventArgs e)
    {
        string[] str = Request.Form.AllKeys;
        Autocomplete3.Value = txtName.Value;
        Autocomplete3.Text = txtName.Text;
        Autocomplete2.Text = txtPass.Text;
        Autocomplete2.Value = txtPass.Value;
        X.Msg.Alert("title", txtName.Value + " —— " + txtName.Text + "</BR>" + txtPass.Value + " —— " + txtPass.Text).Show();
   }   


   
}
