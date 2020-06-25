using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carInspections.WebPages
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (validateUser(txtUsername.Text,txtPassword.Text))
            {
                Response.Redirect("~/Inspections.aspx");
            }else
            {
                Response.Write("Invalid User");
            }
        }


        private bool validateUser(string username, string password)
        {
            bool validUser = false;
            
            if (username=="0" && password =="0")
            {
                string userId = "1";
                Session["userId"] = userId;
                validUser = true;
            }
                    
            return validUser;
        }

    }
}