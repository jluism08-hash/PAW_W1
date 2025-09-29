using System;
using System.Web.Security;
using System.Web.UI;
using PAW_W1.BLL;

namespace PAW_W1.UI
{
    public partial class Login : Page
    {
        UserService _userService = new UserService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMsg.Text = Request.QueryString["msg"];
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var user = _userService.Autenticar(txtUser.Text, txtPass.Text);
            if (user == null)
            {
                lblMsg.Text = "Usuario o contraseña incorrectos.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            Session["Usuario"] = user;
            Response.Redirect(ResolveUrl("~/UI/Products.aspx"));
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}