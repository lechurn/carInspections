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
        carFELib carFELib = new carFELib();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            userValidateReponse userValidateResponse = carFELib.validateUser(txtUsername.Text, txtPassword.Text);

            if (userValidateResponse.isValidUser)
            {
                Session["userId"] = userValidateResponse.userId;
                Response.Redirect("~/Inspections.aspx");
            }
            else
            {
                errorMessage.Text = "Invalid User";
            }
        }
    }
}