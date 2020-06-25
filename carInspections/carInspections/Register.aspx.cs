using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carInspections
{
    public partial class Register : System.Web.UI.Page
    {
        carFELib carFELib = new carFELib();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string hashPassword = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text);

            if ((carFELib.registerAccount(txtUsername.Text, hashPassword)) > 0)
            {
                errorMessage.Text = "Account Registered";
                Response.Redirect("~/SignIn.aspx");
            }
            else
            {
                errorMessage.Text = "Error in creating user account";
            }

        }
    }
}