using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using DIYGENS.COM.FRAMEWORK;

/// <summary>
///TextHelper 的摘要说明
/// </summary>
public class TextHelper
{
    public TextHelper()
    {
        //TODO: 在此处添加构造函数逻辑
        //
    }


    /// <summary>
    /// 获取文本框前缀 当前站+sys
    /// </summary>
    /// <param name="sys">当前系统</param>
    /// <returns></returns>
    public string getPre(string sys)
    {
        string pre = FSecurityHelper.CurrentUserDataGET()[12].Substring(4, 3) + sys;
        return pre;
    }

    /// <summary>
    /// 后台设置焦点在文本框内容的最后（使用该方法时一定要先在文本框里绑定AutoFocus="true"）
    /// </summary>
    /// <param name="textId">文本框ID</param>
    public void SetFocusAtLast(string textId)
    {
        X.AddScript("var t=$('#" + textId + "').val();$('#" + textId + "').val('').focus().val(t);");
    }
}