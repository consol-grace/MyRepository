using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConvertFile
/// </summary>
public class ConvertFile
{
	public ConvertFile()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    /// <summary>  
    /// 将传进来的文件转换成字符串  
    /// </summary>  
    /// <param name="FilePath">待处理的文件路径(本地或服务器)</param>  
    /// <returns></returns>  
    public static string ToBinary(string FilePath)
    {
        FileStream fs = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
        //利用新传来的路径实例化一个FileStream对像  
        int fileLength = Convert.ToInt32(fs.Length);
        //得到对像大小  
        byte[] fileByteArray = new byte[fileLength];
        //声明一个byte数组  
        BinaryReader br = new BinaryReader(fs);
        //声明一个读取二进流的BinaryReader对像  
        for (int i = 0; i < fileLength; i++)
        {//循环数组  
            br.Read(fileByteArray, 0, fileLength);
            //将数据读取出来放在数组中  
        }

        string strData = Convert.ToBase64String(fileByteArray);
        //装数组转换为String字符串  
        return strData;
    }
}