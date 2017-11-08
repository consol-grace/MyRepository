using System;
using System.Collections.Generic;
using System.Linq;
using Ext.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class common_UIControls_Autocomplete : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    #region   // textbox 基本属性
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

    /// <summary>
    /// 是否显示 按钮
    /// </summary>
    private bool _isButton = true;
    public bool isButton
    {
        get { return _isButton; }
        set { _isButton = value; }
    }

    protected override HttpContext Context
    {
        get
        {
            return base.Context;
        }
    }

    public override void Dispose()
    {
        base.Dispose();
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
    /// 设置TextBox的Tab索引值
    /// </summary>
    public int TabIndex
    {
        get;
        set;
    }

    /// <summary>
    /// 获取TextBox的Text
    /// </summary>
    //private string _Text = string.Empty;
    public string Text
    {
        get { return Request[ID + "_text"] == null ? null : Request[ID + "_text"].ToString().ToUpper().Trim(); }
        set
        {
            X.AddScript("$('#" + this.ID + "_text').val(\"" + value.ToUpper().Trim() + "\");");
            X.AddScript("$('#" + this.ID + "_text1').val(\"" + value.ToUpper().Trim() + "\");");
        }
    }

    /// <summary>
    ///获取TextBox的value     
    /// </summary>
    public string Value
    {
        get { return Request[ID] == null ? null : Request[ID].ToString().ToUpper().Trim(); }
        set
        {
            X.AddScript("$('#" + this.ID + "').val(\"" + value.ToUpper().Trim() + "\");");
        }
    }


    private Unit _width = new Unit(65, UnitType.Pixel);
    public Unit Width
    {
        get { return _width; }
        set { _width = value; }
    }

    /// <summary>
    /// 获取或设置textbox的class
    /// </summary>
    public string clsClass
    {
        get;
        set;
    }

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
    /// 设置textbox的text值
    /// </summary>
    /// <param name="text"></param>
    public void setValue(object text)
    {
        X.AddScript("$('#" + this.ID + "').val(\"" + text.ToString().Trim() + "\");");
    }

    /// <summary>
    /// 设置textBox的value值
    /// </summary>
    /// <param name="text"></param>
    public void setText(object text)
    {
        X.AddScript("$('#" + this.ID + "_text').val(\"" + text.ToString().Trim() + "\");");//+this.ID+".focus(true);"
        X.AddScript("$('#" + this.ID + "_text1').val(\"" + text.ToString().Trim() + "\");");//+this.ID+".focus(true);"
    }
    #endregion

}
