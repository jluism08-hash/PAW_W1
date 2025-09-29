using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PAW_W1.BLL;
using PAW_W1.Models;

namespace PAW_W1.UI
{
    public partial class Register : System.Web.UI.Page
    {
        private static readonly UserService _userService = new UserService();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string mensaje = string.Empty;
                User user = new User();
                user.Nombre = txtNombre.Text;
                user.Correo = txtCorreo.Text;
                user.Contrasena = txtPass.Text;
                user.FechaNacimiento = Convert.ToDateTime(txtFecNacimiento.Text);
                user.UserName = txtUser.Text;
                //user.Direccion = txtDireccion.Text;

                var result = _userService.Registrar(user, out mensaje);

                if (result)
                {
                    Response.Redirect("Login.aspx?msg=" + mensaje);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}