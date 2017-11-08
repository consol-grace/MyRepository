<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        ////在应用程序启动时运行的代码
        System.Timers.Timer timer = new System.Timers.Timer(); // 定时器
        timer.Elapsed += new System.Timers.ElapsedEventHandler(timer_Elapsed);
        timer.Interval = 60000;
        timer.Enabled = true;
    }

    public static void timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
    {
        //System.Net.EDI.CallRequest request = new System.Net.EDI.CallRequest();
        //System.Collections.Generic.Dictionary<string, string>[] dir = new System.Collections.Generic.Dictionary<string, string>[1];
        //dir[0] = new System.Collections.Generic.Dictionary<string, string>();
        //dir[0].Add("action", "EXECSQL");
        //string msgstr = request.ExecRequest(dir, System.Net.EDI.EDIFile.EDICallBackURL );
    }

    void Application_End(object sender, EventArgs e)
    {
        //在应用程序关闭时运行的代码
    }

    void Application_Error(object sender, EventArgs e)
    {
        ////在出现未处理的错误时运行的代码
        //Exception exp = Server.GetLastError().GetBaseException();
        //string error = "异常页面：" + Request.Url.ToString() + "</br></br>";
        //error += "异常信息：" + exp.Message + "   ";
        //error += "<a target=\"_top\" href=\"/mframe/index.aspx#\">返回系统</a>";

        //Server.ClearError();
        //Response.Write(error);
    }

    void Session_Start(object sender, EventArgs e)
    {
        //在新会话启动时运行的代码    
    }

    void Session_End(object sender, EventArgs e)
    {
        //在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式 
        //设置为 StateServer 或 SQLServer，则不会引发该事件。
    }
       
</script>
