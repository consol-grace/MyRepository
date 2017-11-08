using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OceanExport_OEReportFile_ViewReport_Down : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pdfpath = Request["pdfpath"];
        if (string.IsNullOrEmpty(pdfpath))
        {
            Response.Write("<script>alert('数据读取异常，文件下载失败。')</script>");
            return;
        }
        string path = pdfpath.Substring(0, pdfpath.LastIndexOf("?"));
        string parm = pdfpath.Substring(pdfpath.LastIndexOf("=") + 1);
        if (Directory.Exists(Server.MapPath(parm)))
        {
           Directory.Delete(Server.MapPath(parm), true);
        }

        DownLoad(Server.MapPath(path));
    }

    public void DownLoad(string path)
    {
        System.IO.Stream iStream = null;
        byte[] buffer = new Byte[10000];
        int length;
        long dataToRead;
        string filename = path.Substring(path.LastIndexOf("\\") + 1);
        try
        {
            iStream = new System.IO.FileStream(path, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read);
            dataToRead = iStream.Length;
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.ContentType = "application/pdf"; //文件类型
            Response.AddHeader("Content-Length", dataToRead.ToString());//添加文件长度，进而显示进度
            Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8));
            while (dataToRead > 0)
            {
                if (Response.IsClientConnected)
                {
                    length = iStream.Read(buffer, 0, 10000);
                    Response.OutputStream.Write(buffer, 0, length);
                    Response.Flush();
                    buffer = new Byte[10000];
                    dataToRead = dataToRead - length;
                }
                else
                {
                    dataToRead = -1;
                }
            }

        }
        catch (Exception exp)
        {
            Response.Write("<script>alert('文件下载时出现错误,错误信息:" + exp.Message + "')</script>");
        }
        finally
        {
            if (iStream != null)
            {
                iStream.Close();
            }
            //结束响应，否则将导致网页内容被输出到文件，进而文件无法打开
            Response.End();
        }
    }
   
}