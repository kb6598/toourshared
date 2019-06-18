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
           TextBox1.Text =  Request.QueryString.Get("TextBox1");
            TextBox2.Text = Request.QueryString.Get("TextBox2");
            TextBox3.Text = Request.QueryString.Get("TextBox3");

            

            

            
        }
        
    }
}