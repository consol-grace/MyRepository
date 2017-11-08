using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

public partial class common_UIControls_UserComboBox : System.Web.UI.UserControl
{
    protected void Page_load(object sender, EventArgs e)
    {

        if (!X.IsAjaxRequest)
        {
            if (!IsPostBack)
            {
                InitControl();
            }
        }
    }


    /// <summary>
    /// ComboBoxID
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

    /// <summary>
    /// ComboBox  宽度
    /// </summary>
    private Unit _width = new Unit(85, UnitType.Pixel);
    public Unit Width
    {
        get { return _width; }
        set { _width = value; }
    }

    /// <summary>
    /// ComboBox 数据源
    /// </summary>
    public string StoreID
    { get; set; }

    /// <summary>
    /// ComboBox 描述信息
    /// </summary>
    public string LabText
    {
        get;
        set;
    }

    private bool _Disabled = false;
    public bool Disabled
    {
        get { return _Disabled; }
        set { _Disabled = value; }
    }


    /// <summary>
    /// ComboBox 描述信息宽度
    /// </summary>
    private int _labWidth = 50;
    public int LabWidth
    {
        get { return _labWidth; }
        set { _labWidth = value; }
    }

    /// <summary>
    /// ComboBox 是否显示描述信息
    /// </summary>
    private bool _hiddleLabText = true;
    public bool HiddleLabText
    {
        get { return _hiddleLabText; }
        set { _hiddleLabText = value; }
    }

    /// <summary>
    /// ComboBox TabIndex
    /// </summary>
    public short TabIndex
    { get; set; }

    /// <summary>
    /// ComboBox 下拉列表宽度
    /// </summary>
    private Unit _listWidth = new Unit(350, UnitType.Pixel);
    public Unit ListWidth
    {
        get { return _listWidth; }
        set { _listWidth = value; }
    }

    /// <summary>
    /// ComboBox自定义样式
    /// </summary>
    private string _style = "width:85px; height:14px";
    public string Style
    {
        get { return _style; }
        set { _style = value; }
    }

    /// <summary>
    /// ComboBox Trigger  dispaly or  hide
    /// </summary>
    private bool _hideTrigger = false;
    public bool HideTrigger
    {
        get { return _hideTrigger; }
        set { _hideTrigger = value; }
    }

    /// <summary>
    ///ComboBox 样式
    /// </summary>
    public string clsClass
    {
        get;
        set;
    }

    /// <summary>
    /// 获取或设置ComboBox的Text
    /// </summary>
    //private string _text;
    public string Text
    {
        get { return string.IsNullOrEmpty(Request[ID + "_Value"]) ? null : Request[ID + "_Value"].ToUpper(); }

        set
        {
            X.AddScript("$('#" + this.ID + "_Value').val(\"" + value + "\");");
        }
    }

    /// <summary>
    ///获取或设置ComboBox的Text     
    /// </summary>
    //private string _value;
    public string Value
    {
        get { return string.IsNullOrEmpty(Request[ID]) ? null : Request[ID].ToUpper(); }

        set
        {
            X.AddScript("$('#" + this.ID + "').val(\"" + value + "\");");
        }
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


    private string _winUrl = "#";
    /// <summary>
    /// 获取或设置弹出窗体的地址
    /// </summary>   
    public string winUrl
    {
        get { return _winUrl; }
        set { _winUrl = value; }
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
    /// 是否显示Text
    /// </summary>
    private bool _isText = false;
    public bool isText
    {
        get { return _isText; }
        set { _isText = value; }
    }



    /// <summary>
    /// Text 显示位置 默认为 横， 横 or  竖
    /// </summary>
    private bool _isAlign = true;
    public bool isAlign
    {
        get;
        set;
    }

    /// <summary>
    /// 查询参数
    /// </summary>
    public string Query
    {
        get;
        set;
    }


    private string _DisplayField = "value";
    public string DisplayField
    {
        get { return _DisplayField; }
        set { _DisplayField = value; }
    }

    private string _ValueField = "text";
    public string ValueField
    {
        get { return _ValueField; }
        set { _ValueField = value; }
    }

    public string Blur
    { get; set; }
    public string Change
    { get; set; }
    public string Handler
    { get; set; }

    /// <summary>
    /// 初始化控件
    /// </summary>
    public void InitControl()
    {
        //    HttpProxy proxy = new HttpProxy
        //    {
        //        Method = HttpMethod.GET,
        //        Url = "/common/UIControls/UserComboBox.ashx?" + Query
        //    };

        //    // Create Reader
        //    JsonReader reader = new JsonReader
        //    {
        //        Fields = {                 
        //            new RecordField("text"),
        //            new RecordField("value")                
        //        }
        //        ,
        //        IDProperty = "value",
        //        Root = "table",
        //        TotalProperty = "Total"
        //    };




        //Parameter list = new Ext.Net.ParameterCollection { };
        //Ext.Net.Parameter list = new Ext.Net.Parameter();//{new Ext.Net.Parameter { Name = "start", Value = "0" }, new Ext.Net.Parameter { Name = "limit", Value = "50" } };
        //list.Params.Add(new Ext.Net.Parameter("start", "0"));
        //list.Params.Add(new Ext.Net.Parameter("limit", "50"));
        //list.Params[0].Name = "start";
        //list.Params[0].Value = "0";
        //list.Params[1].Name = "limit";
        //list.Params[1].Value = "50";

        // Add Proxy and Reader to Store
        //Store store = new Store
        //{
        //    AutoLoadParams = { list },
        //    ID = this.StoreID,
        //    Proxy = { proxy },
        //    Reader = { reader },
        //    AutoLoad = false

        //};


        //Store = { store }
        ComboBox cb = new ComboBox();
        cb.ID = ID;
        if (!string.IsNullOrEmpty(StoreID))
            cb.StoreID = StoreID;
        if (winTitle == "Company")
            cb.PageSize = 500;
        cb.IDMode = IDMode.Client;
        cb.FieldLabel = LabText;
        cb.LabelWidth = _labWidth;
        //cb.StoreID = StoreID;
        cb.TriggerAction = TriggerAction.All;
        cb.Mode = DataLoadMode.Local;
        cb.HideTrigger = _hideTrigger;
        cb.Disabled = _Disabled;
        cb.QueryDelay = 1;
        cb.MinChars = 0;
        cb.DisplayField = _DisplayField;
        //cb.ValueField = winTitle == "Item" ? "text" : _DisplayField;
        cb.ValueField = _DisplayField;
        cb.Template.Html = "<tpl for=\".\">" +
                                                            "<tpl if=\"[xindex] == 1\">" +
                                                                "<table class=\"cbStates-list\">" +
                                                                    "<tr>" +
                                                                         "<th>Code</th>" +
                                                                         "<th>Name</th>" +
                                                                    "</tr>" +
                                                            "</tpl>" +
                                                                "<tr class=\"list-item\">" +
                                                                "<td style=\"padding:3px 0px; width:30%\">{" + _DisplayField + "}</td>" +
                                                                "<td style=\"padding:3px 0px; width:70%\">{" + _ValueField + "}</td>" +
                                                            "</tr>" +
                                                            "<tpl if=\"[xcount-xindex]==0\">" +
                                                                    "</table>" +
                                                            "</tpl></tpl>";
        cb.StyleSpec = _style;
        cb.Cls = clsClass;
        cb.Width = CheckDest() ? new Unit((_width.Value + 20), UnitType.Pixel) : _width;
        cb.ListWidth = _listWidth;
        cb.ItemSelector = "tr.list-item";
        cb.Text = Text;
        cb.Value = Value;
        cb.TabIndex = TabIndex;

        //cb.QueryParam = "query";
        //cb.ForceSelection = true;
        //cb.FireSelectOnLoad = true;
        //cb.SelectOnFocus = true;
        //cb.TypeAhead = true;
        //cb.TypeAheadDelay = 1;
        //cb.AllQuery = this.Text;
        //cb.Listeners.Select.Handler = "alert()";
        if (winTitle == "Item")
            if (string.IsNullOrEmpty(Handler))
                cb.Listeners.Select.Handler = this.ID + "_text.innerText=record.data.text==null?'':record.data.text;";
            else
                cb.Listeners.Select.Handler = this.ID + "_text.innerText=record.data.text==null?'':record.data.text;" + Handler;

        else
            cb.Listeners.Select.Handler = "" + Handler;

        cb.Listeners.Blur.Handler = Blur;
        cb.Listeners.Change.Handler = Change;
        //cb.Listeners.KeyUp.Handler = "alert(event.keyCode);";
        if (this.CheckDest())
            cb.Listeners.BeforeQuery.Handler = "function(e) { var com = e.combo; com.rowIndex = 0; com.selectedIndex = -1; if (e.forceAll) { com.store.clearFilter(); com.onLoad(); com.selectByValue(com.value); com.focus(); return false;} else { var value = e.query.toLowerCase(); var regExp = new RegExp('^'+value + '.*'); com.store.filterBy(function(record, id) { var text = record.get('text').toLowerCase(); var code = record.get('value').toLowerCase(); return (regExp.test(text) || regExp.test(code)); }); com.onLoad();if (value.length >1 ) { com.selectByValue(value.toUpperCase());} com.focus(); return false; } }";

        //if (this.CheckDest())
        //    cb.Listeners.BeforeQuery.Fn = "comBoxValueSelect";

        cb.Render(panel, RenderMode.RenderTo);
        cb.Dispose();
        cb.Destroy();

    }

    /// <summary>
    /// 设置ComboBox的Value
    /// </summary>
    /// <param name="text"></param>
    public void setValue(object text)
    {

        X.AddScript(this.ID + ".setValue(\"" + text + "\");");//+this.ID+".focus(true);"
        

    }

    /// <summary>
    /// 设置ComboBox的焦点
    /// </summary>
    public void Focus()
    {
        X.AddScript(this.ID + ".focus();");
    }

    /// <summary>
    /// 设置ComboBox的焦点
    /// </summary>
    public void Focus(bool b)
    {
        if (b)
            X.AddScript(this.ID + ".focus(true);");
        else
            X.AddScript(this.ID + ".focus();");
    }


    public void onBlur()
    {
        X.AddScript(this.ID + ".blur();");
    }

    protected void btnimg_AddNew(object sender, DirectEventArgs e)
    {
        var win = new Window
        {
            ID = "Window1",
            Title = winTitle,
            //Width = winTitle == "Company" ? Unit.Pixel(755) : Unit.Pixel(winWidth),
            //Height = winTitle == "Company" ? Unit.Pixel(658) : Unit.Pixel(winHeight),
            Width = sWidth(winTitle),// winTitle == "Company" ? Unit.Pixel(755) : Unit.Pixel(winWidth),
            Height = sHeight(winTitle),  //winTitle == "Company" ? Unit.Pixel(658) : Unit.Pixel(winHeight),
            CloseAction = CloseAction.Close,
            BodyStyle = "background-color:#fff;",
            Draggable = false,
            Resizable = false,
            Modal = true
        };
        win.On("close", new JFunction("window.parent.window.document.body.style.overflow ='auto';"));
        string query = winUrl.IndexOf("?") > 0 ? "&" : "?";
        string sys = string.IsNullOrEmpty(Request["sys"]) ? "" : "&sys=" + Request["sys"].ToString()[0].ToString();
        win.AutoLoad.Url = winUrl + query + "control=" + this.ID + "&code=" + this.Value + "&store=" + this.StoreID + sys;
        win.AutoLoad.Mode = LoadMode.IFrame;
        X.AddScript("window.parent.window.document.body.style.overflow ='hidden';");
        //win.ParentForm.Controls.Add(this);
        win.Render(this.Page);
        win.Dispose();
        //win.Destroy();
    }

    public Unit sWidth(string Title)
    {
        Unit unit = new Unit();
        switch (Title.ToUpper())
        {
            case "LOCATION":
                unit = Unit.Pixel(842);
                break;
            case "SALESMAN":
                unit = Unit.Pixel(675);
                break;
            case "UNIT":
                unit = Unit.Pixel(510);
                break;
            case "ITEM":
                unit = Unit.Pixel(968);
                break;
            case "CURRENCY":
                unit = Unit.Pixel(655);
                break;
            case "COUNTRY":
                unit = Unit.Pixel(437);
                break;
            case "COMPANY":
                unit = Unit.Pixel(755);
                break;
            case "DOMESTIC STATUS":
                unit = Unit.Pixel(480);
                break;
            case "SERVICE MODE":
                unit = Unit.Pixel(516);
                break;
            case "CONTAINER SIZE":
                unit = Unit.Pixel(443);
                break;
            case "SHIPKIND":
                unit = Unit.Pixel(495);
                break;
        }
        return unit;
    }

    public Unit sHeight(string Title)
    {
        Unit unit = new Unit();
        switch (Title.ToUpper())
        {
            case "LOCATION":
                unit = Unit.Pixel(512);
                break;
            case "SALESMAN":
                unit = Unit.Pixel(453);
                break;
            case "UNIT":
                unit = Unit.Pixel(482);
                break;
            case "ITEM":
                unit = Unit.Pixel(515);
                break;
            case "CURRENCY":
                unit = Unit.Pixel(482);
                break;
            case "COUNTRY":
                unit = Unit.Pixel(590);
                break;
            case "CUSTOMER":
                unit = Unit.Pixel(562);
                break;
            case "DOMESTIC STATUS":
                unit = Unit.Pixel(390);
                break;
            case "SERVICE MODE":
                unit = Unit.Pixel(482);
                break;
            case "CONTAINER SIZE":
                unit = Unit.Pixel(480);
                break;
            case "SHIPKIND":
                unit = Unit.Pixel(485);
                break;
        }
        return unit;
    }


    public bool CheckDest()
    {
        bool b = false;
        if (ID.ToUpper().Contains("FINAL") || ID.ToUpper().Contains("LOAD") || ID.ToUpper().Contains("PORT") || ID.ToUpper().Contains("RECEIPT") || ID.ToUpper().Contains("FROM") || ID.ToUpper().Contains("TO") || ID.ToUpper().Contains("RECEIVE") || ID.ToUpper().Contains("DEPARTURE") || ID.ToUpper().Contains("DEST") || ID.ToUpper().Contains("LOCATION") || ID.ToUpper().Contains("CMBISSUE") || ID.ToUpper().Contains("CMBPAYAT") || ID.ToUpper().Contains("POD") || ID.ToUpper().Contains("POL"))
            b = true;
        return b;
    }

}
