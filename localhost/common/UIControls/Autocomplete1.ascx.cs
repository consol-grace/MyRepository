using System;
using System.Collections.Generic;
using System.Linq;
using Ext.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.DBLL;
using System.Data.SqlClient;

public partial class common_UIControls_Autocomplete1 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                InitControl();

            }
        }
    }



    #region   /// Combobox  基本属性
    /// <summary>
    /// 控件ID
    /// </summary>
    public override string ID
    {
        get
        {
            return base.ID;
        }
        set
        {
            base.ID = value;
        }
    }

    public override Page Page
    {
        get
        {
            return base.Page;
        }
        set
        {
            base.Page = value;
        }
    }


    /// <summary>
    /// 是否显示 按钮
    /// </summary>
    private bool _isButton = true;
    public bool isButton
    {
        get { return _isButton; }
        set { _isButton = value; }
    }



    /// <summary>
    /// 设置TextBox的Tab索引值
    /// </summary>
    public short TabIndex
    {
        get;
        set;
    }


    private bool _hideTrigger = true;
    public bool HideTrigger
    {
        get { return _hideTrigger; }
        set { _hideTrigger = value; }
    }

    private bool _disabled = false;
    public bool Disabled
    {
        get { return _disabled; }
        set { _disabled = value; }
    }

    public string StoreID
    { get; set; }

    /// <summary>
    /// 获取TextBox的Text
    /// </summary>
    //private string _Text = string.Empty;
    public string Text
    {
        get { return Request[ID + "_text"]; }
        set
        {
            X.AddScript("$('#" + this.ID + "_text').val(\"" + value + "\");");
            X.AddScript("$('#" + this.ID + "_text1').val(\"" + value + "\");");
        }
    }

    /// <summary>
    ///获取TextBox的value     
    /// </summary>
    public string Value
    {
        get { return Request[ID]; }
        set
        {
            // X.AddScript("$('#" + this.ID + "').val(\"" + value + "\");");
            X.AddScript("Ext.getCmp(\"" + this.ID + "\").setValue(\"" + value + "\");");

        }
    }


    private Unit _width = new Unit(120, UnitType.Pixel);
    public Unit Width
    {
        get { return _width; }
        set { _width = value; }
    }


    private Unit _height = new Unit(18, UnitType.Pixel);
    public Unit Height
    {
        get { return _height; }
        set { _height = value; }
    }


    private Unit _listWidth = new Unit(350, UnitType.Pixel);
    public Unit ListWidth
    {
        get { return _listWidth; }
        set { _listWidth = value; }
    }



    /// <summary>
    /// 获取或设置textbox的class
    /// </summary>
    public string clsClass { get; set; }

    public string StyleSpec { get; set; }

    /// <summary>
    /// 是否显示textbox的text值
    /// </summary>
    protected bool _isDiplay = true;
    public bool isDiplay
    {
        get { return _isDiplay; }
        set { _isDiplay = value; }
    }

    /// <summary>
    /// 横向or 竖向显示 text 值
    /// </summary>
    protected bool _isAlign = true;
    public bool isAlign
    {
        get { return _isAlign; }
        set { _isAlign = value; }
    }


    /// <summary>
    /// 获取或设置弹出窗体的Title
    /// </summary>
    public string winTitle
    {
        get;
        set;
    }

    /// <summary>
    /// 获取或设置弹出窗体的宽度
    /// </summary>
    public int winWidth
    {
        get;
        set;
    }

    /// <summary>
    /// 获取或设置弹出窗体的高度
    /// </summary>
    public int winHeight
    { get; set; }


    private string _winUrl = "/basicdata/customer/detail.aspx";
    /// <summary>
    /// 获取或设置弹出窗体的地址
    /// </summary>   
    public string winUrl
    {
        get { return _winUrl; }
        set { _winUrl = value; }
    }


    /// <summary>
    /// 设置textbox的text值
    /// </summary>
    /// <param name="text"></param>
    public void setValue(object text)
    {
        //X.AddScript("$('#" + this.ID + "').val(\"" + text + "\");");
        X.AddScript("Ext.getCmp(\"" + this.ID + "\").setValue(\"" + text + "\");");
    }

    /// <summary>
    /// 设置textBox的value值
    /// </summary>
    /// <param name="text"></param>
    public void setText(object text)
    {
        X.AddScript("$('#" + this.ID + "_text').val(\"" + text + "\");");//+this.ID+".focus(true);"
        X.AddScript("$('#" + this.ID + "_text1').val(\"" + text + "\");");//+this.ID+".focus(true);"
    }
    #endregion


    #region /// Combobox JS事件接口
    public string OnFocus { get; set; }
    public string OnBlur { get; set; }
    public string OnSelect { get; set; }
    public string OnChange { get; set; }
    public string OnKeyUp { get; set; }
    public string OnKeyDown { get; set; }
    public string OnClick { get; set; }
    #endregion


    #region /// Combobox Template Html
    public string templateHtml()
    {
        return " <tpl for=\".\">" +
                                                             "<tpl if=\"[xindex] == 1\">" +
                                                                 "<table class=\"cbStates-list\">" +
                                                                     "<tr>" +
                                                                          "<th>Code</th>" +
                                                                          "<th>Name</th>" +
                                                                     "</tr>" +
                                                             "</tpl>" +
                                                              "<tr class=\"list-item\">" +
                                                                 "<td style=\"padding:3px 0px; width:30%\">{value}</td>" +
                                                                 "<td style=\"padding:3px 0px; width:70%\">{text}</td>" +
                                                             "</tr>" +
                                                             "<tpl if=\"[xcount-xindex]==0\">" +
                                                                     "</table>" +
                                                             "</tpl></tpl>";

    }
    #endregion


    public void InitStore()
    {

        //if (Page.FindControl("storeDIV") == null)
        //{

        //    Store storeCompany = new Store
        //    {
        //        ID = "storeCompany",
        //        AutoLoad = true,
        //        IDMode = IDMode.Inherit,
        //        Reader = { new JsonReader { Fields = { new RecordField("value"), new RecordField("text") } } },
        //        AutoLoadParams = { new Ext.Net.Parameter { Name = "start", Value = "0", Mode = ParameterMode.Raw }, new Ext.Net.Parameter { Name = "limit", Value = "300", Mode = ParameterMode.Raw } }
        //    };
        //    storeCompany.RefreshData += new Store.AjaxRefreshDataEventHandler(storeCompany_RefreshData);

        //    storeCompany.DataSource = GetCompanyData();
        //    storeCompany.DataBind();

        //    storeCompany.Render(storeDIV);
        //}


    }



    #region ///初始化 Combobox
    /// <summary>
    /// 初始化控件
    /// </summary>
    public void InitControl()
    {
        //Store storeCompany = new Store
        //   {
        //       ID = "storeCompany",
        //       AutoLoad = true,
        //       IDMode = IDMode.Inherit,
        //       Reader = { new JsonReader { Fields = { new RecordField("value"), new RecordField("text") } } },
        //       AutoLoadParams = { new Ext.Net.Parameter { Name = "start", Value = "0", Mode = ParameterMode.Raw }, new Ext.Net.Parameter { Name = "limit", Value = "300", Mode = ParameterMode.Raw } }
        //   };
        //storeCompany.RefreshData += new Store.AjaxRefreshDataEventHandler(storeCompany_RefreshData);

        //storeCompany.DataSource = GetCompanyData();
        //storeCompany.DataBind();

        ComboBox cb = new ComboBox();
        cb.ID = ID;
        cb.StoreID = string.IsNullOrEmpty(StoreID) ? "storeCompany" : StoreID;
        //cb.StoreID = "storeCompany";
        //cb.Store.Add(storeCompany);
        cb.IDMode = IDMode.Client;
        //cb.PageSize = 300;
        cb.TriggerAction = TriggerAction.Query;
        cb.Mode = DataLoadMode.Local;
        cb.HideTrigger = _hideTrigger;
        cb.Disabled = _disabled;
        cb.QueryDelay = 1;
        cb.MinChars = 0;
        cb.DisplayField = "value";
        //cb.ValueField = winTitle == "Item" ? "text" : _DisplayField;
        cb.ValueField = "value";
        cb.Template.Html = templateHtml();
        cb.StyleSpec = "font-size: 10px; ime-mode: disabled;height:14px;" + StyleSpec;
        cb.Cls = clsClass;
        cb.Width = new Unit((_width.Value + 5), UnitType.Pixel);
        cb.Height = _height;
        cb.ListWidth = _listWidth;
        cb.ItemSelector = "tr.list-item";
        cb.Text = Text;
        cb.Value = Value;
        cb.TabIndex = TabIndex;

        //cb.QueryParam = "query";
        cb.ForceSelection = true;
        cb.FireSelectOnLoad = true;
        //cb.SelectOnFocus = true;
        //cb.TypeAhead = true;
        //cb.TypeAheadDelay = 1;
        //cb.AllQuery = this.Text;
        //cb.Listeners.Select.Handler = "alert()";



        cb.Listeners.Select.Handler = "$(\"#" + this.ID + "_text,#" + this.ID + "_text1\").val(record.data.text==null?'':record.data.text);Vlidata('" + this.ID + "');" + OnSelect;
        cb.Listeners.Blur.Handler = OnBlur;
        cb.Listeners.Change.Handler = OnChange;
        cb.Listeners.KeyUp.Handler = "AutoComboBox('" + this.ID + "',event,'" + this.winTitle + "','" + this.winUrl + "','" + this.winWidth + "','" + this.winHeight + "');" + OnKeyUp;
        cb.Listeners.KeyDown.Handler = OnKeyDown;
        cb.Listeners.Focus.Handler = OnFocus;
        cb.Listeners.BeforeQuery.Fn = "ComboboxSearch";

        cb.Render(panel, RenderMode.RenderTo);
        cb.Dispose();
        cb.Destroy();
    }

    #endregion


    public DataTable GetCompanyData()
    {
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(PageHelper.ConnectionStrings);
        SqlCommand cmd = new SqlCommand("select co_Code value, co_name text from cs_company where co_companyKind='base'", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        return dt;
    }
}