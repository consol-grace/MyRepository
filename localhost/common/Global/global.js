/// <reference path="../ylQuery/jQuery/js/jquery-1.4.1.js" />
/// <reference path="../ylQuery/jQuery/js/jquery.ui.custom.js" />
/// <reference path="../ylQuery/ylQuery.js" />
/// <reference path="../ylQuery/ext-3.2.0/adapter/ext/ext-base.js" />
/// <reference path="../ylQuery/ext-3.2.0/ext-all.js" />

var USGROUP = { ContextPath: ylQuery.ContextPath };

USGROUP.Url = { LoginSuccess: USGROUP.ContextPath + "mframe/index.aspx"
    , LoginFail: USGROUP.ContextPath + "login.aspx"
    , DataController: USGROUP.ContextPath + "DataController.ashx"
}
