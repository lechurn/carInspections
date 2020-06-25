﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace carInspections
{
    public partial class Inspections : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"].ToString() == null)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            else
            {
                hfUserId.Value = Session["userId"].ToString();
            }
        }
    }
}