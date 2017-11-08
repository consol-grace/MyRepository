using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;

public class DES
{
    /// <summary>
    /// 加密算法
    /// </summary>
    /// <param name="pToEncrypt">要加密的字符串</param>
    /// <returns>返回已加密的数组</returns>
    public static string Encrypt(string pToEncrypt)
    {
        string result = "";
        string sKey = "12345678";
        try
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            byte[] inputByteArray = Encoding.Default.GetBytes(pToEncrypt);
            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();
            StringBuilder ret = new StringBuilder();
            foreach (byte b in ms.ToArray())
                ret.AppendFormat("{0:X2}", b);
            result = ret.ToString();
        }
        catch
        {
            result = "";
        }
        return result;
    }

    /// <summary>
    /// 解密方法
    /// </summary>
    /// <param name="pToDecrypt">解密的字符串或数组</param>
    /// <returns>返回解密的字符串</returns>
    public static string Decrypt(string pToDecrypt)
    {
        string result = "";
        string sKey = "12345678";
        try
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
            for (int x = 0; x < pToDecrypt.Length / 2; x++)
            {
                int i = (Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
                inputByteArray[x] = (byte)i;
            }
            des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);
            des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();
            StringBuilder ret = new StringBuilder();
            result = System.Text.Encoding.Default.GetString(ms.ToArray());
        }
        catch
        {
            result = "";
        }
        return result;
    }

}