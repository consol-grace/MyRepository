using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Text;
using System.IO;

/// <summary>
/// Summary description for ExecRequest
/// </summary>
public class ExecRequest
{
	public ExecRequest()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string call(Dictionary<string, string> data, string url)
    {
        try
        {
            string _postData = "", content = string.Empty;

            foreach (KeyValuePair<string, string> d in data)
            {
                _postData += d.Key + "=" + DES.Encrypt(d.Value) + "&";
            }
            _postData = _postData == "" ? _postData : _postData.Substring(0, _postData.Length - 1);
            byte[] postData = Encoding.UTF8.GetBytes(_postData);

            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
            Encoding myEncoding = Encoding.UTF8;
            request.Method = "POST";
            request.KeepAlive = false;
            request.AllowAutoRedirect = true;
            request.ContentType = "application/x-www-form-urlencoded";
            request.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR  3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)";
            request.ContentLength = postData.Length;

            System.IO.Stream outputStream = request.GetRequestStream();
            outputStream.Write(postData, 0, postData.Length);
            outputStream.Close();

            HttpWebResponse response = request.GetResponse() as HttpWebResponse;
            Stream stream = response.GetResponseStream();
            StreamReader sr = new StreamReader(stream);
            content = sr.ReadToEnd();
            sr.Close();
            sr.Dispose();

            return content;
        }
        catch (Exception exp)
        {
            return exp.Message;
        }

    }


    
}