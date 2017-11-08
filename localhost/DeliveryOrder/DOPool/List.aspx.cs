using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using DIYGENS.COM.BASECLASS;
using DIYGENS.COM.CommonLL;
using DIYGENS.COM.DBLL;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class DeliveryOrder_DOPool_List : System.Web.UI.Page
{
    DataFactory dal = new DataFactory();

    private int pageSize = 100;  //设置页面条数

    /// <summary>
    /// 当前页
    /// </summary>
    public int CurrentPageIndex
    {
        set
        {
            ViewState["CurrentPageIndex"] = value;
        }
        get
        {
            return Convert.ToInt32(ViewState["CurrentPageIndex"]);
        }
    }
    /// <summary>
    /// 查询条件
    /// </summary>
    public string KeyWord
    {
        set
        {
            ViewState["KeyWord"] = value;
        }
        get
        {
            return ViewState["KeyWord"].ToString();
        }
    }

    /// <summary>
    /// 总页数
    /// </summary>
    public int PageCount
    {
        set
        {
            ViewState["PageCount"] = value;
        }
        get
        {
            return Convert.ToInt32(ViewState["PageCount"]);
        }
    }

    public int startNum;
    public int endNum;
    public int totalNum;
    public int isOk;

    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                CurrentPageIndex = txtPageNum.Text.Trim() == "" ? 1 : Convert.ToInt32(txtPageNum.Text.Trim());
                isOk = string.IsNullOrEmpty(Request["isok"]) ? 0 : Convert.ToInt32(Request["isok"]);
                if (isOk == 0)
                {
                    btnOk.Visible = false;
                    btnNew.Visible = true;
                }
                else {
                    btnOk.Visible = true;
                    btnNew.Visible = false;
                }
                ControlBinder.DateFormat(txtDate);
                ControlBinder.DateFormat(txtTo);
                txtDate.Focus(true);
                txtDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd");
                txtDate.RawText = DateTime.Now.AddDays(-7).ToString("yyyy/MM/dd");
                DataBinder();
                SetButtonStatus();
            }
        }
    }

    void DataBinder()
    {

        try
        {

            DataSet dsDO = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields>() { dal.CreateIFields()
                 .Append("Option", "List")
                 .Append("do_OrderDate", ControlBinder.getDate(string.IsNullOrEmpty(txtDate.RawText.Trim()) ? "1900/01/01" : (object)txtDate.RawText.Trim()))
                 .Append("do_OrderTo", ControlBinder.getDate(string.IsNullOrEmpty(txtTo.RawText.Trim()) ? DateTime.MaxValue : (object)txtTo.RawText.Trim()))
                 .Append("do_Company",string.IsNullOrEmpty(ACCompany.Value) ? "": ACCompany.Value.Trim())
                 .Append("DO", txtDO.Text.Trim())
                 .Append("do_Stat",FSecurityHelper.CurrentUserDataGET()[12]) 
                 .Append("pageSize",pageSize) 
                 .Append("pageIndex",CurrentPageIndex) 
        }).GetList();

            
            PageCount = (Int32)dsDO.Tables[1].Rows[0]["pcount"];
            startNum = (CurrentPageIndex - 1) * pageSize + 1;
            totalNum = (Int32)dsDO.Tables[1].Rows[0]["tcount"];
            if (CurrentPageIndex > PageCount)
            {
                CurrentPageIndex = PageCount;
            }
            if (CurrentPageIndex == PageCount && totalNum % pageSize != 0)
            {
                endNum = (CurrentPageIndex - 1) * pageSize + totalNum % pageSize;
            }
            else
            {
                endNum = CurrentPageIndex * pageSize;
            }

            RepListDO.DataSource = dsDO.Tables[0];
            RepListDO.DataBind();
        }
        catch
        {

        }

    }

    protected void RepListDO_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rep = e.Item.FindControl("RepListDOD") as Repeater;
            DataRowView rowv = (DataRowView)e.Item.DataItem;
            //以下是读取Repeater1中绑定数据的字段，用于Repeater2的查询条件
            string Seed = rowv["Seed"].ToString();
            //以下是Repeater2的数据读取和绑定
            DataTable dt = dal.FactoryDAL(PageHelper.ConnectionStrings, "FW_DeliveryOrder_Pool_SP", new List<IFields>() { dal.CreateIFields()
                    .Append("Option", "List")
                    .Append("Seed",Seed)
                    }).GetTable();
            //调用数据操作类执行SQL语句
            rep.DataSource = dt;
            rep.DataBind();

        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        //hidDate.Text = txtDate.RawText.Trim();
        DataBinder();
        //Response.Redirect(Request.Url.ToString()); 
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //设置repeater的自定义高度,以及滚动条，Loading透明层的高度
        X.AddScript("var h = document.documentElement.clientHeight - 200;$(\"#uu\").height(h);$(\"#uu\").css(\"max-height\", Math.abs(h)); $(\"#divGray\").height($(\"#uu\").height() + 32); $(\"#divLoading\").css(\"top\",$(\"#uu\").height() / 2 + 85);document.getElementById(\"divLoading\").style.display = \"block\";document.getElementById(\"divGray\").style.display = \"block\";");
        txtPageNum.Text = "1";
        CurrentPageIndex = 1;
        DataBinder();
        SetButtonStatus();

        X.AddScript("setTimeout(\"document.getElementById(\'divLoading\').style.display = \'none\';document.getElementById(\'divGray\').style.display = \'none\';\",1000);");
    }

    protected void AE_Click(object sender, DirectEventArgs e)
    {
        if (hidDODRowID.Text == "")
        {
           X.AddScript("Ext.Msg.alert('Information', 'Please select a row')");
        }
        else
        {
            X.AddScript("window.open('/AirExport/AEShipAndColIn/list.aspx?DODRowID=" + hidDODRowID.Text + "&transfer=p&type=s','_blank');");
            //transfer用于save之后刷新父级窗体的参数
            //X.AddScript("window.showModalDialog('/AirExport/AEShipAndColIn/list.aspx?DODRowID=" + hidDODRowID.Text + "&transfer=p&type=s',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");
        }
    }

    protected void OE_Click(object sender, DirectEventArgs e)
    {
        if (hidDODRowID.Text == "")
        {
            X.AddScript("Ext.Msg.alert('Information', 'Please select a row')");
        }
        else
        {
            //X.Redirect("/OceanExport/OEShipment/list.aspx?rowID=" + hidDODRowID.Text);
           //X.AddScript("window.showModalDialog('/OceanExport/OEShipment/list.aspx?DODRowID=" + hidDODRowID.Text + "&JobType=p',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");
            X.AddScript("window.open('/OceanExport/OEShipment/list.aspx?DODRowID=" + hidDODRowID.Text + "&JobType=p','_blank');");
        }
    }

    protected void TK_Click(object sender, DirectEventArgs e)
    {
        if (hidDODRowID.Text == "")
        {
            X.AddScript("Ext.Msg.alert('Information', 'Please select a row')");
        }
        else
        {
            //X.Redirect("/OtherBusiness/Trucking/List.aspx?rowID=" + hidDODRowID.Text);
            //X.AddScript("window.showModalDialog('/OtherBusiness/Trucking/List.aspx?DODRowID=" + hidDODRowID.Text + "&type=p',window,'dialogWidth=980px,dialogHeight=750px,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,directories=no,resizable=no');");
            X.AddScript("window.open('/OtherBusiness/Trucking/List.aspx?DODRowID=" + hidDODRowID.Text + "&type=p','_blank');");
        }
    }

    protected void btnOk_Click(object sender, DirectEventArgs e)
    {
        if (hidDODRowID.Text == "")
        {
            X.AddScript("Ext.Msg.alert('Information', 'Please select a row')");
        }
        else
        {
            //X.Redirect("/OtherBusiness/Trucking/List.aspx?rowID=" + hidDODRowID.Text);
            //X.AddScript("dialogArguments.location.reload();window.close();");
            //X.AddScript("window.dialogArguments.refreshdata(\"" + hidDODRowID.Text + "\",\"" + str + "\");window.close();");
            //X.AddScript("window.dialogArguments.location.href='/AirExport/AEShipAndColIn/list.aspx?rowID=" + hidDODRowID.Text + "&seed=" + seed + "&type=s';window.close();");
            string id = string.IsNullOrEmpty(hidDODRowID.Text) ? "" : hidDODRowID.Text.Substring(0, hidDODRowID.Text.Length - 1);
            X.AddScript("window.dialogArguments.refreshdata(\"" + id + "\");window.close();");
        }
    }

    private void SetButtonStatus()
    {
        //如果当前页是最后一页
        if (CurrentPageIndex >= this.PageCount)
        {
            this.imgBtnNext.Enabled = false;
            this.imgBtnNext.ImageUrl = "/extjs/resources/images/default/grid/page-next-disabled-gif/ext.axd";
            this.imgBtnLast.Enabled = false;
            this.imgBtnLast.ImageUrl = "/extjs/resources/images/default/grid/page-last-disabled-gif/ext.axd";
        }
        else
        {
            this.imgBtnNext.Enabled = true;
            this.imgBtnNext.ImageUrl = "/extjs/resources/images/default/grid/page-next-gif/ext.axd";
            this.imgBtnLast.Enabled = true;
            this.imgBtnLast.ImageUrl = "/extjs/resources/images/default/grid/page-last-gif/ext.axd";
        }

        if (CurrentPageIndex <= 1)
        {
            this.imgBtnPrev.Enabled = false;
            this.imgBtnPrev.ImageUrl = "/extjs/resources/images/default/grid/page-prev-disabled-gif/ext.axd";
            this.imgBtnFirst.Enabled = false;
            this.imgBtnFirst.ImageUrl = "/extjs/resources/images/default/grid/page-first-disabled-gif/ext.axd";
        }
        else
        {
            this.imgBtnPrev.Enabled = true;
            this.imgBtnPrev.ImageUrl = "/extjs/resources/images/default/grid/page-prev-gif/ext.axd";
            this.imgBtnFirst.Enabled = true;
            this.imgBtnFirst.ImageUrl = "/extjs/resources/images/default/grid/page-first-gif/ext.axd";
        }

    }

    protected void imgBtnPrev_Click(object sender, EventArgs e)
    {
        X.AddScript("var h = document.documentElement.clientHeight - 200;$(\"#uu\").height(h);$(\"#uu\").css(\"max-height\", Math.abs(h)); $(\"#divGray\").height($(\"#uu\").height() + 32); $(\"#divLoading\").css(\"top\",$(\"#uu\").height() / 2 + 85);document.getElementById(\"divLoading\").style.display = \"block\";document.getElementById(\"divGray\").style.display = \"block\";");
        this.CurrentPageIndex--;
        this.txtPageNum.Text = CurrentPageIndex.ToString();
        DataBinder();
        this.SetButtonStatus();
        X.AddScript("setTimeout(\"document.getElementById(\'divLoading\').style.display = \'none\';document.getElementById(\'divGray\').style.display = \'none\';\",1000);");
    }

    protected void imgBtnNext_Click(object sender, EventArgs e)
    {
        X.AddScript("var h = document.documentElement.clientHeight - 200;$(\"#uu\").height(h);$(\"#uu\").css(\"max-height\", Math.abs(h)); $(\"#divGray\").height($(\"#uu\").height() + 32); $(\"#divLoading\").css(\"top\",$(\"#uu\").height() / 2 + 85);document.getElementById(\"divLoading\").style.display = \"block\";document.getElementById(\"divGray\").style.display = \"block\";");
        this.CurrentPageIndex++;
        this.txtPageNum.Text = CurrentPageIndex.ToString();
        DataBinder();
        this.SetButtonStatus();
        X.AddScript("setTimeout(\"document.getElementById(\'divLoading\').style.display = \'none\';document.getElementById(\'divGray\').style.display = \'none\';\",1000);");
    }

    protected void imgBtnFirst_Click(object sender, EventArgs e)
    {
        X.AddScript("var h = document.documentElement.clientHeight - 200;$(\"#uu\").height(h);$(\"#uu\").css(\"max-height\", Math.abs(h)); $(\"#divGray\").height($(\"#uu\").height() + 32); $(\"#divLoading\").css(\"top\",$(\"#uu\").height() / 2 + 85);document.getElementById(\"divLoading\").style.display = \"block\";document.getElementById(\"divGray\").style.display = \"block\";");
        this.CurrentPageIndex=1;
        this.txtPageNum.Text = "1";
        DataBinder();
        this.SetButtonStatus();
        X.AddScript("setTimeout(\"document.getElementById(\'divLoading\').style.display = \'none\';document.getElementById(\'divGray\').style.display = \'none\';\",1000);");
    }

    protected void imgBtnLast_Click(object sender, EventArgs e)
    {
        X.AddScript("var h = document.documentElement.clientHeight - 200;$(\"#uu\").height(h);$(\"#uu\").css(\"max-height\", Math.abs(h)); $(\"#divGray\").height($(\"#uu\").height() + 32); $(\"#divLoading\").css(\"top\",$(\"#uu\").height() / 2 + 85);document.getElementById(\"divLoading\").style.display = \"block\";document.getElementById(\"divGray\").style.display = \"block\";");
        this.CurrentPageIndex = PageCount;
        this.txtPageNum.Text = PageCount.ToString();
        DataBinder();
        this.SetButtonStatus();
        X.AddScript("setTimeout(\"document.getElementById(\'divLoading\').style.display = \'none\';document.getElementById(\'divGray\').style.display = \'none\';\",1000);");
    }

}