using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DIYGENS.COM.FRAMEWORK;

public partial class common_UIControls_UserSheet : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }



    public bool _disHeader = true;
    public bool disHeader
    {
        get { return _disHeader; }
        set { _disHeader = value; }
    }

    public string seed
    {
        get;
        set;
    }

    public bool _isload = false;
    public bool isLoad
    {
        get { return _isload && Convert.ToBoolean(DIYGENS.COM.FRAMEWORK.FSecurityHelper.CurrentUserDataGET()[25]) == true; }
        set { _isload = value; }
    }


    public Unit _height = new Unit(200, UnitType.Pixel);
    public Unit Height
    {
        get { return _height; }
        set { _height = value; }
    }

    public Unit _width = new Unit(301, UnitType.Pixel);
    public Unit Width
    {
        get { return _width; }
        set { _width = value; }
    }
}
