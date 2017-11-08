using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class AllSystem_JobReference_JobReference : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtETDFrom.Focus();
            ControlBinder.DateFormat(txtETDFrom);
            ControlBinder.DateFormat(txtETDTo);
            if (FSecurityHelper.CurrentUserDataGET()[12].ToString().ToUpper() == "CON/HKG")
            {
                lblVerifyNo.Hidden = true;
                txtVerifyNo.Hidden = true;
            }
            string date = DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString().PadLeft(2, '0') + "/01";
            txtETDFrom.RawText = date;
            txtETDFrom.Text = date;
            if (Request["Sys"] != null)
            {
                hidsys.Text = Request["Sys"];
            }
            if (hidsys.Value.ToString().ToUpper().Contains("A"))
            {
                X.AddScript("LoadTd();");
            }
            ComboboxBinder();
            if (hidsys.Text.StartsWith("A"))
            {
                lblHBL.Text = "HAWB";
                lblMBL.Text = "MAWB";
                lblVessel.Visible = false;
                txtVessel.Hidden = true;
                lblVoyage.Visible = false;
                txtVoyage.Hidden = true;
                lblContainer.Visible = false;
                txtContainer.Hidden = true;
                gridReference.ColumnModel.Columns[2].Header = "MAWB";
                gridReference.ColumnModel.Columns[3].Header = "HAWB";
            }
            JobDataBinding();
        }
    }

    protected void ComboboxBinder()
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));

    }

    public void JobDataBinding()
    {
        //DataFactory dal = new DataFactory();
        //DataSet ds = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_AllSystem_Reference_SP", new List<IFields>() {
        //    dal.CreateIFields()
        //    .Append("Option", "DataBinder") 
        //    .Append("Stat",FSecurityHelper.CurrentUserDataGET()[12])
        //    .Append("SYS",hidsys.Text)
        //    .Append("Shipper",cmbShipperCode.Value)
        //    .Append("Consignee",cmbConsigneeCode.Value)
        //    .Append("DateFrom",ControlBinder.getDate(txtETDFrom.RawText.StartsWith("0001")?DBNull.Value:(object)txtETDFrom.RawText))
        //    .Append("DateTo",ControlBinder.getDate(txtETDTo.RawText.StartsWith("0001")?DBNull.Value:(object)txtETDTo.RawText))
        //    .Append("Dest",cmbDest.Value)
        //    .Append("Sales",cmbSalesman.Value)
        //    .Append("JobNo",txtJobNo.Text.Trim())
        //    .Append("Master",txtMBL.Text)
        //    .Append("House",txtHBL.Text)
        //    .Append("Vessel",txtVessel.Text.Trim())
        //    .Append("Voyage",txtVoyage.Text.Trim())
        //    .Append("Container",txtContainer.Text.Trim())
        //    .Append("Coloader",CmbColoader.Value)
        //}).GetList();

        string[] nums = new string[18] { "Option", "Stat", "SYS", "Shipper", "Consignee", "DateFrom", "DateTo", "Dest", "Sales", "JobNo", "Master", "House", "Vessel", "Voyage", "Container", "Coloader", "active", "VerifyNo" };
        object[] values = new object[18];
        values[0] = "GetJobData";  // DataBinder
        values[1]=FSecurityHelper.CurrentUserDataGET()[12];
        values[2]=hidsys.Text;
        values[3]=cmbShipperCode.Value;
        values[4]=cmbConsigneeCode.Value;
        values[5]=ControlBinder.getDate(txtETDFrom.RawText.StartsWith("0001")?DBNull.Value:(object)txtETDFrom.RawText);
        values[6]=ControlBinder.getDate(txtETDTo.RawText.StartsWith("0001")?DBNull.Value:(object)txtETDTo.RawText);
        values[7]=cmbDest.Value==null?"":cmbDest.Value;
        values[8]=cmbSalesman.Value==null?"":cmbSalesman.Value;
        values[9]=txtJobNo.Text.Trim();
        values[10]=txtMBL.Text.Trim();
        values[11]=txtHBL.Text.Trim();
        values[12]=txtVessel.Text.Trim();
        values[13]=txtVoyage.Text.Trim();
        values[14]=txtContainer.Text.Trim();
        values[15] = CmbColoader.Value;
        values[16] = chkVoid.Checked ? 0 : 1;
        values[17] = txtVerifyNo.Text.Trim();

        //txtMBL.Text = DateTime.Now.ToString("HH:mm:ss.fff");
        DataSet ds = PageHelper.GetDs("FW_AllSystem_Reference_SP", nums, values);
        //txtHBL.Text = DateTime.Now.ToString("HH:mm:ss.fff");
        gridReference.GetStore().DataSource = ds;
        gridReference.GetStore().DataBind();

       
    }

    public void StoreLocation_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreLocation, "LocationList", hidsys.Text.Substring(0, 1));
    }

    public void StoreSalesman_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        ControlBinder.CmbBinder(StoreSalesman, "SalesList", hidsys.Text.Substring(0, 1));
    }

    protected void StoreReference_OnRefreshData(object sender, StoreRefreshDataEventArgs e)
    {
        JobDataBinding();
    }

    public void btnSearch_Click(object sender, EventArgs e)
    {
        JobDataBinding();
    }

    //Session["showvoid"]
    [DirectMethod]
    public void SetID(string id)
    {
        Session["showvoid"] = id;
    }
}
