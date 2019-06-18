using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace toourshared
{
    public partial class Write_get : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Request.QueryString.Get("TextBox1");
            Request.QueryString.Get("TextBox2");
            Request.QueryString.Get("TextBox3");
        }
    }
}