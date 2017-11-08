using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class common_UIControls_UserGridPanel : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    CreateGrid();
           
    }

    /// <summary>
    /// 控件ID，必须项
    /// </summary>
    public override string ID { get; set; }


    /// <summary>
    /// 系统模块区分 "O" or "A"
    /// </summary>
    public string sys { get; set; }

    /// <summary>
    /// 隐藏列
    /// </summary>
    public string[] HideField { get; set; }


    /// <summary>
    /// Grid是否禁用
    /// </summary>
    public bool Disenable
    {

        set
        {
            Ext.Net.X.AddScript("alert()");
        }
    }

    /// <summary>
    /// Grid样式表
    /// </summary>
    public string Cls { get; set; }

    /// <summary>
    /// 列宽，必须项
    /// </summary>
    public string[] CWidth { get; set; }

    /// <summary>
    /// 列是否要只读  （默认都为可编辑）
    /// </summary>
    public string[] Readonly { get; set; }

    /// <summary>
    /// 列是否不接收Tab健 （默认为都接收）
    /// </summary>
    public string[] Tabstop { get; set; }

    /// <summary>
    /// 标题 （默认为空）
    /// </summary>
    public string Title { get; set; }

    /// <summary>
    /// 绑定抬头，必须项
    /// </summary>
    public string[] Caption { get; set; }

    /// <summary>
    /// 绑定字段，必须项
    /// </summary>
    public string[] FieldName{get;set; }

    /// <summary>
    /// 字段类型，必须项
    /// </summary>
    public string[] DataType { get; set; }


    /// <summary>
    /// 要绑定的数据 ，必须项
    /// </summary>
    public DataTable dt { get; set; }


    /// <summary>
    /// 创建Grid
    /// </summary>
    /// <param name="dt"></param>
    public string  CreateGrid()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table id=\"" + ID + "\" class=\"" + Cls + "\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
        if (!string.IsNullOrEmpty(Title))
            sb.Append("<thead>\r\n<tr  class=\"grid_title\">\r\n<th style=\"width:100%\"><span class=\"grid_title_span\">" + Title + "</span><span><a id=\"a_Delete\" href=\"javascript:void(0);\">Delete</a></span><span><a id=\"a_DeleteAll\" href=\"javascript:void(0);\">Del All</a></span></th></tr></thead>\r\n");
        sb.Append("<tbody><tr class=\"grid_caption\"><td style=\"margin:0;padding:0\">\r\n<table cellpadding=\"0\" cellspacing=\"1\">\r\n<tr>\r\n");
        sb.Append("<th  style=\"width:25px\">No.</th>\r\n");
        for (int i = 0; i < Caption.Length; ++i)
        {
            if (!HideField.Contains(Caption[i].ToString()))
                sb.Append("<th style=\"width:" + CWidth[i] + "\">" + Caption[i].ToString() + "</th>\r\n");
            else
                sb.Append("<th style=\"display:none;width:" + CWidth[i] + "\">" + Caption[i].ToString() + "</th>\r\n");
        }
        sb.Append("<th style=\"width:16px;padding:0px;margin:0px;\"></th></tr></table></td></tr></tbody>\r\n<tbody><tr><td style=\"padding:0px;margin:0px\"><div class=\"grid_content_div\" style=\"\"><table class=\"grid_content\" cellpadding=\"0\" cellspacing=\"1\"><tbody>");

        if (dt != null && dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; ++i)
            {
                sb.Append("\r\n<tr>\r\n<td style=\"width:25px; text-align:center\">" + (i + 1) + "</td>\r\n");
                for (int j = 0; j < FieldName.Length; ++j)
                {
                    if (HideField.Contains(Caption[j].ToString()))
                    {
                        sb.Append("<td  style=\"display:none; width:" + CWidth[j] + "\">" + CreateInput(DataType[j], dt.Rows[i][FieldName[j].ToString()].ToString(), CWidth[j], FieldName[j], i) + "</td>\r\n");
                    }
                    else
                    {
                        if (j == FieldName.Length)
                            sb.Append("<td>" + CreateInput(DataType[j], dt.Rows[i][FieldName[j].ToString()].ToString(), CWidth[j], FieldName[j], i) + "</td>\r\n");
                        else
                            sb.Append("<td  style=\"width:" + CWidth[j] + "\">" + CreateInput(DataType[j], dt.Rows[i][FieldName[j].ToString()].ToString(), CWidth[j], FieldName[j], i) + "</td>\r\n");
                    }
                }
                sb.Append("</tr>");
            }
        }
        for (int i = dt.Rows.Count; i < 30; ++i)
        {
            sb.Append("<tr>\r\n<td style=\"width:25px; text-align:center\">" + (i + 1) + "</td>\r\n");
            for (int j = 0; j < FieldName.Length; ++j)
            {
                if (!HideField.Contains(Caption[j].ToString()))
                {
                    if (j == FieldName.Length)
                        sb.Append("<td>" + CreateInput(DataType[j], dt.Rows[i][FieldName[j].ToString()].ToString(), CWidth[j], FieldName[j], i) + "</td>\r\n");
                    else
                        sb.Append("<td  style=\"width:" + CWidth[j] + "\">" + CreateInput(DataType[j], "", CWidth[j], FieldName[j], i) + "</td>\r\n");
                }
                else
                {
                    sb.Append("<td  style=\"display:none;width:" + CWidth[j] + "\">" + CreateInput(DataType[j], "", CWidth[j], FieldName[j], i) + "</td>\r\n");
                }
            }
            sb.Append("</tr>");
        }
        sb.Append("</tbody></table></div></td></tr></tbody></table>");
        return sb.ToString();
    }



    /// <summary>
    /// 获取GRID的JSON数据
    /// </summary>
    public string getJSON
    {
        get
        {
            string str = "[";
            for (int i = 0; i < 30; ++i)
            {
                str += "{";
                for (int j = 0; j < FieldName.Length; ++j)
                {
                    str += "\"" + FieldName[j] + "\":\"" + HttpContext.Current.Request.Form[this.ID + "_" +FieldName[j].ToString() +"_"+ i] + "\",";
                }
                str = str.Substring(0, str.Length - 1);
                str += "},";
            } str = str.Substring(0, str.Length - 1);

            str += "]";
            return str;
        }
    }



    /// <summary>
    /// 创建控件列
    /// </summary>
    /// <param name="type">控件类型</param>
    /// <param name="value">值</param>
    /// <param name="width">宽度</param>
    /// <param name="name">名称</param>
    /// <param name="i">行数</param>
    /// <returns>string</returns>
    private string CreateInput(string type, string value, string width, string name, int i)
    {
        string str = string.Empty;
        switch (type)
        {
            case "string":
                str = "<input type=\"text\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID +"_"+name +"_"+i + "\"  id=\"" + name + i + "\"/>";
                break;
            case "label":
                str = "<input type=\"text\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"   ContentEditable=\"false\"  />";
                break;
            case "location":
                str = "<input type=\"text\"  onfocus=\"auto(this,'" + sys + "','LocationList');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;
            case "company":
                 str = "<input type=\"text\"  onfocus=\"auto(this,'','CompanyList');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                
                //str=" <uc1:UserComboBox runat=\"server\" ID=\"CmbCarrierCode\" clsClass=\"select_160px\" StoreID=\"StoreCmb3\" Width=\"90\"  winTitle=\"Company\"  winUrl=\"/BasicData/Customer/detail.aspx\" winWidth=\"800\" winHeight=\"800\"  Query=\"option=CompanyList\" />";
                break;
            case "comName":
                str = "<input type=\"text\"  onfocus=\"auto(this,'','CompanyListByName');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;
            case "item":
                str = "<input type=\"text\"  onfocus=\"auto(this,'" + sys + "','ItemBinding');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;
            case "unit":
                str = "<input type=\"text\"  onfocus=\"auto(this,'" + sys + "','UnitBinding');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;    
            case "currency":
                str = "<input type=\"text\"  onfocus=\"auto(this,'" + sys + "','CurrencysList');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;
            case "calckind":
                str = "<input type=\"text\"  onfocus=\"auto(this,'" + sys + "','QtyKindBinding');\"  value=\"" + value + "\" style=\"width:" + width + "\" name=\"" + this.ID + "_" + name + "_" + i + "\"  id=\"" + name + i + "\"/>";
                break;
               
        }
        return str;
    }
}
