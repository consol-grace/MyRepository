using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;

//———————————————————————
//Author        ：Michael Chien
//Create Date   ：2012-12-21
//Description   ：打印前配置虚拟打印机一般属性
//———————————————————————

/// <summary>
/// 打印前配置打印机一般属性
/// </summary>
public class PrintImgSetting
{
    public PrintImgSetting()
    {

    }


    private static PrintImgSetting _PIS = null;
    public static PrintImgSetting PIS
    {
        get { if (_PIS == null) { _PIS = new PrintImgSetting(); } return _PIS; }
    }


    private readonly static string filePath = @"C:\Program Files\zvprt50\zvprtcfg.exe";

    /// <summary>
    /// 设置打印机保存目录
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="folderPath">保存目录</param>
    public void SetFileFolder(string printName, string folderPath)
    {
        Process.Start(filePath, printName + " save.folder=" + folderPath);
    }


    /// <summary>
    /// 设置打印保存时的文件名
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="fileName">保存的文件名</param>
    public void SetFileName(string printName, string fileName)
    {
        Process.Start(filePath, printName + " save.basefilename=" + fileName);
    }


    /// <summary>
    /// 设置打印保存文件类型
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="format">文件类型 0为BMP ; 1为TIFF ; 2为GIF ; 3为PNG ; 4为PDF ; 5为JPEF ; 6为JPEF 2000</param>
    public void SetFileFormat(string printName, int format)
    {
        Process.Start(filePath, printName + " image.fileformat=" + format);
    }


    /// <summary>
    /// 设置文件打印像素
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="size">像素大小 eg. 100 , 200, 300 ,400 ,500 ,600,默认最好240</param>
    public void SetDpi(string printName, int size)
    {
        Process.Start(filePath, printName + " gpd.dpi=" + size);
    }

    /// <summary>
    /// 设置打印纸张类型
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="type">纸张类型 eg. A4 , Letter</param>
    public void SetPaperSize(string printName, string type)
    {
        Process.Start(filePath, printName + " gpd.papersize=" + type);
    }



    /// <summary>
    /// 设置文件写入方式，只有文件类型为PDF,TIFF 的时候才能设置（多页，连续，追加） 
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="format">写入方式 0为多页; 1为连续; 2为追加</param>
    public void SetCreateMode(string printName, int format)
    {
        Process.Start(filePath, printName + " image.pagetype=" + format);
    }


    /// <summary>
    /// 设置打印后是否旋转
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="enable">1为是 0 为否</param>
    public void SetisRotate(string printName, int enable)
    {
        Process.Start(filePath, printName + " rotate.enable=1");

    }

    /// <summary>
    /// 设置打印后旋转角度
    /// </summary>
    /// <param name="printName">打印机名称</param>
    /// <param name="angle">旋转的角度</param>
    public void SetRotateAngle(string printName, int angle)
    {
        Process.Start(filePath, printName + " rotate.angle=" + angle);
    }


    /// <summary>
    /// 匹配文件类型
    /// </summary>
    /// <param name="format"></param>
    /// <returns></returns>
    public string FileFormat(int format)
    {
        string str = "";
        switch (format)
        {
            case 0:
                str = "BMP";
                break;
            case 1:
                str = "TIF";
                break;
            case 2:
                str = "JPG";
                break;
            case 3:
                str = "PNG";
                break;
            case 4:
                str = "PDF";
                break;
            case 5:
                str = "GIF";
                break;
            case 6:
                str = "JPG";
                break;
            case 7:
                str = "PDF";
                break;
            default:
                str = "PDF";
                break;
        }
        return str;
    }

}
