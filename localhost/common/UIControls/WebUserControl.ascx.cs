using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

public partial class common_UIControls_WebUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_Click(object sender, EventArgs e)
    {

        var win = new Window
        {
            ID = "Window1",
            Title = "Add List",
            Width = Unit.Pixel(this.WinWidth),
            Height = Unit.Pixel(this.WinHeight),
            Modal = true,           

        };

        win.AutoLoad.Url = this.ShowUrl;
        win.AutoLoad.Mode = LoadMode.IFrame;
        win.Render(this.Page);
    }

  
    

    private string _ID = "ComboBox1"; 
    /// <summary>
    /// 
    /// </summary>
    public override string ID
    {
        set { this._ID = value; }
        get { return this._ID;  }
    }

    private string _Name = "";
    /// <summary>
    /// 
    /// </summary>
    public string Name
    {
        set { this._Name = value; }
        get { return this._Name; }
    }

    private string _Value ;
    /// <summary>
    /// 
    /// </summary>
    public string Value
    {
        set { this._Value = value; }
        get { return this._Value; }
    }


    public string _Text ="";
    public string Text
    {
        set { this._Text = value; }
        get { return this._Text; }
    }


    /// <summary>
    /// 数据源地址
    /// </summary>
    public string DataUrl
    {
        get;
        set;
    }

    /// <summary>
    /// 窗口地址
    /// </summary>
    public string ShowUrl
    {
        get;
        set;
    }

    /// <summary>
    /// 窗口宽度
    /// </summary>
    public int _Height = 500;
    public int WinHeight
    {
        set;
        get;
    }

    /// <summary>
    /// 窗口高度
    /// </summary>
    public int _Width = 300;
    public int WinWidth
    {
        get;
        set;
    }
}
