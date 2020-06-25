﻿using System;
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
                Response.Write("Account Registered");
            }
            else
            {
                Response.Write("Error in creating user account");
            }

        }
    }
}