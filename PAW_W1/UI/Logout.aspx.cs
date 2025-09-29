using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAW_W1.UI
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();              // elimina datos de sesión
            Session.Abandon();            // invalida la sesión
            Response.Redirect("Login.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}