using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using DIYGENS.COM.FRAMEWORK;
using DIYGENS.COM.FileLL;
using DIYGENS.COM.DBLL;
using DIYGENS.COM.CommonLL;

public partial class Common_ylQuery_UploadifyENG_Uploadify : DIYGENS.COM.BASECLASS.PageBase
{
    protected string OrderID, TableName, AuthorityID;

    protected override void Page_Load(object sender, EventArgs e)
    {
        this.Option = Request.QueryString["Option"];

        if (this.Option == "init-data") InitData();
        if (this.Option == "FileUpload") FileUpload();
        this.DataController();

        if (this.Option == "UrlEncode")
        {
            this.ReturnValue = this.UrlEncode(Request.Form["Encode"]);
            Response.Write(this.ReturnValue);
            Response.End();
        }
    }

    #region InitData()   初始化资料   作者: Richard ( 2011-07-01 )
    /// <summary>
    /// 初始化资料
    /// </summary>
    protected void InitData()
    {
        OrderID = Request.QueryString["OrderID"];
        TableName = Request.QueryString["TableName"];
        AuthorityID = Request.QueryString["AuthorityID"];

        DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, ConfigHelper.GetAppSettings("SELECT"), new List<IFields>() { this.CreateIFields()
            .Append("OrderID", Request.QueryString["OrderID"])
            .Append("TableName", Request.QueryString["TableName"]) 
        }).GetTable();

        this.Repeater1.DataSource = dt;
        this.Repeater1.DataBind();
    }
    #endregion

    #region UrlEncode   QueryString传值方式加密   作者: Richard ( 2011-07-01 )
    /// <summary>
    /// QueryString传值方式加密
    /// </summary>
    /// <param name="encrypt"></param>
    /// <returns></returns>
    protected string UrlEncode(object encrypt)
    {
        return new Securitylib("20080526").Encrypt(encrypt);
    }
    #endregion

    #region UrlDecode   QueryString传值方式解密   作者: Richard ( 2011-07-01 )
    /// <summary>
    /// QueryString传值方式解密
    /// </summary>
    /// <param name="decrype"></param>
    /// <returns></returns>
    private string UrlDecode(object decrype)
    {
        return new Securitylib("20080526").Decrypt(decrype);
    }
    #endregion


    #region FileUpload()   上传文件   作者: Richard ( 2011-07-01 )
    /// <summary>
    /// 上传文件
    /// </summary>
    private void FileUpload()
    {
        try
        {
            object UploadUser = "Guest", UploadAuthority = DBNull.Value;
            try
            {
                UploadUser = FSecurityHelper.CurrentUserDataGET()[0];
                UploadAuthority = FSecurityHelper.CurrentUserDataGET()[1];
            }
            catch { UploadUser = "Guest"; }
            string Folder = Request["folder"].Split(';')[0];
            string strUploadPath = this.Context.Server.MapPath(Folder) + string.Format(@"\{0}\", UploadUser);
            if (Directory.Exists(strUploadPath) == false) Directory.CreateDirectory(strUploadPath);
            string OriginName = string.Empty, NewName = string.Empty;


            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile postedFile = Request.Files[i];
                //string fileName = strUploadPath + Path.GetFileName(postedFile.FileName);
                NewName = Filelib.Instance.GetNewName("DG-", postedFile.FileName);
                string fileName = strUploadPath + NewName;
                postedFile.SaveAs(fileName);
                Response.Write(fileName);

                // 保存资料到资料库
                NewName = UploadUser + @"\" + NewName;
                OriginName = Path.GetFileName(postedFile.FileName);

                object objFileSize = null;
                double iFileSize = postedFile.ContentLength;
                if (iFileSize > 1048576) objFileSize = String.Format("{0:#.##}", (iFileSize / 1048576)) + " M";
                if (iFileSize < 1048576 && iFileSize > 1024) objFileSize = String.Format("{0:#.##}", (iFileSize / 1024)) + " K";
                if (iFileSize < 1024) objFileSize = iFileSize + " B";

                bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, ConfigHelper.GetAppSettings("INSERT"), new List<IFields>() { CreateIFields().Append("OrderID", Request["folder"].Split(';')[1])
                        .Append("TableName", Request["folder"].Split(';')[2])
                        .Append("UserName", UploadUser)
                        .Append("AuthorityID", Request["folder"].Split(';')[3])
                        .Append("OriginFile", OriginName)
                        .Append("NewFile", NewName)
                        .Append("FileSize", objFileSize)
                        .Append("UploadDate", string.Format("{0:yyyy-MM-dd HH:mm:ss}", DateTime.Now))
                        .Append("Remarks", DBNull.Value)
                        .Append("Creator", UploadUser)
                    }).Update();
            }
        }
        catch (Exception ex)
        {
            Filelib.CreateLogExplorer("ylQuery.Uploadify.FileUpload.Exception", ex.Message);
        }
    }
    #endregion

    #region DataController   资料管理   作者: Richard ( 2011-07-01 )
    /// <summary>
    /// 资料管理
    /// </summary>
    private void DataController()
    {
        #region 下载文件   this.Option == "download"
        if (this.Option == "download")
        {
            string OriginName = UrlDecode(Request["OriginName"]);
            string filename = UrlDecode(Request["filename"]);
            filename = Urllib.RealPath + "Uploadify\\" + filename;
            Filelib.Instance.FileDownload(filename, OriginName);
        }
        #endregion

        #region 删除单个   this.Option == "delete"
        if (this.Option == "delete")
        {
            string RowID = Request.QueryString["RowID"];
            string RemoveID = Request.QueryString["RemoveID"];
            string TableName = Request.Form["TableName"];
            string OrderID = Request.Form["OrderID"];
            bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, ConfigHelper.GetAppSettings("DELETE_SINGLE"), new List<IFields>() { this.CreateIFields().Append("RowID", RowID).Append("TableName", TableName).Append("OrderID", OrderID) }).Update();
            if (!bFlag)
                this.ReturnValue = this.Message.Replace("{Option}", "false").Replace("{RemoveID}", RemoveID);
            else
            {
                this.ReturnValue = this.Message.Replace("{Option}", "true").Replace("{RemoveID}", RemoveID);
                string filename = Urllib.RealPath + "Uploadify\\" + UrlDecode(Request["filename"]);
                Filelib.Instance.DeleteFile(filename);
            }
            Response.Write(this.ReturnValue);
            Response.End();
        }
        #endregion

        #region 删除批量   this.Option == "delete-select"
        if (this.Option == "delete-select")
        {
            this.Message = "{\"Option\":\"{Option}\",\"RemoveID\":\"{RemoveID}\"}";

            string RowIDAndFilename = Request.Form["chkUploadify"];
            string RowIDs = string.Empty, Filename = string.Empty;
            string TableName = Request.QueryString["TableName"];
            string OrderID = Request.QueryString["OrderID"];
            if (RowIDAndFilename.IndexOf(",") == -1)
            {
                RowIDs = RowIDAndFilename.Split(';')[0];
                Filename = RowIDAndFilename.Split(';')[1];
            }
            else
            {
                string[] list = RowIDAndFilename.Split(',');
                for (int i = 0; i < list.Length; i++)
                {
                    RowIDs += "," + list[i].Split(';')[0];
                    Filename += "," + list[i].Split(';')[1];
                }
            }
            RowIDs = RowIDs.IndexOf(",") != -1 ? RowIDs.Substring(1, RowIDs.Length - 1) : RowIDs;
            Filename = Filename.IndexOf(",") != -1 ? Filename.Substring(1, Filename.Length - 1) : Filename;

            bool bFlag = this.FactoryDAL(PageHelper.ConnectionStrings, ConfigHelper.GetAppSettings("DELETE_BATCH"), new List<IFields>() { this.CreateIFields().Append("IDlist", RowIDs).Append("OrderID", OrderID).Append("TableName", TableName) }).Update();
            if (bFlag)
            {
                string fileName = string.Empty;
                if (RowIDs.IndexOf(",") == -1)
                {
                    this.ReturnValue = this.Message.Replace("{Option}", "true").Replace("{RemoveID}", RowIDs);
                    fileName = Urllib.RealPath + "Uploadify\\" + UrlDecode(Filename);
                    Filelib.Instance.DeleteFile(fileName);
                }
                else
                {
                    this.ReturnValue = string.Empty;
                    string[] list = RowIDs.Split(',');
                    for (int i = 0; i < list.Length; i++)
                    {
                        this.ReturnValue += "," + this.Message.Replace("{Option}", "true").Replace("{RemoveID}", list[i]);

                        fileName = Urllib.RealPath + "Uploadify\\" + UrlDecode(Filename.Split(',')[i]);
                        Filelib.Instance.DeleteFile(fileName);
                    }
                    this.ReturnValue = "[" + this.ReturnValue.Substring(1, this.ReturnValue.Length - 1) + "]";
                }
            }
            else
            {
                this.ReturnValue = this.Message.Replace("{Option}", "false").Replace("{RemoveID}", "");
                this.ReturnValue = "[" + this.ReturnValue + "]";
            }
            Response.Write(this.ReturnValue);
            Response.End();
        }
        #endregion

        #region 获取资料   this.Option == "list"
        if (this.Option == "list")
        {
            string OrderID = Request["OrderID"], TableName = Request["TableName"];
            DataTable dt = this.FactoryDAL(PageHelper.ConnectionStrings, ConfigHelper.GetAppSettings("SELECT"), new List<IFields>() { CreateIFields().Append("OrderID", OrderID).Append("TableName", TableName) }).GetTable();

            this.ReturnValue = this.ToJSON(dt);
            Response.Write(this.ReturnValue);
        }
        #endregion
    }
    #endregion
}
