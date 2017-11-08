using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using DIYGENS.COM.DBLL;
using System.IO;
using System.Collections;
using System.Net.EDI;
using System.Data.SqlClient;
using System.Threading;
using System.Net;

public partial class si : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //System.Net.EDI.EDIFile.Start();
        //string str = "consolidator international well channel trading limited";
        //string add = "conso lidator inter national well channel trading limited";
        //Response.Write(str.ToUpper() + "</br>");
        //ArrayList list = subSpace(str, add, companyLength);
        //foreach (string v in list)
        //    Response.Write(v.ToUpper() + "</br>");

        //3554595  3534894   3479815  3569334

        //int seed = 3551986;// 3556761; //3503296;  //3551986; //3541410; //3547522; //3550890;// 3528921;  //3547334; 3546445; 

        //Response.Write("Main thread: Start a second thread.<br>");
        string fileName = "SZXOE1703006_01_456.XML";
        string str = fileName.Substring(0, fileName.LastIndexOf("_"));

        //Response.Write(edi.CreateFile("2858974", "0", "CON/HKG", "OE", "admin", "T"));        
        //Response.Write(edi.CreateFile("3609240", "0", "CON/HKG", "OE", "admin", " "));        
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }

}

//public enum FreightType
//{
//    NonFreighted ="Non Freighted",
//    FreightCollect = "Freight Collect",
//    FreightPrepaid = "Freight Prepaid",
//    FreightedMixed = "Freighted Mixed"
//}
