using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using PAW_W1.BLL;
using PAW_W1.Models;

namespace PAW_W1.UI
{
    public partial class Perfil : Page
    {
        private static readonly UserService _userService = new UserService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                var usuario = (User)Session["Usuario"];
                txtNombre.Text = usuario.Nombre;
                txtCorreo.Text = usuario.Correo;
                txtTelefono.Text = usuario.Telefono;
                txtUserName.Text = usuario.UserName;
                txtFecha.Text = usuario.FechaNacimiento.ToString("yyyy-MM-dd");
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object ActualizarPerfil(string userJson, string fechaIso)
        {
            try
            {
                var ctx = System.Web.HttpContext.Current;
                var actual = ctx.Session["Usuario"] as User;
                if (actual == null) return new { ok = false, message = "No autenticado." };

                var js = new JavaScriptSerializer();
                var u = js.Deserialize<User>(userJson) ?? new User();

                actual.Nombre = (u.Nombre ?? "").Trim();
                actual.Correo = (u.Correo ?? "").Trim();
                actual.Direccion = "";
                actual.Telefono = (u.Telefono ?? "").Trim();
                actual.UserName = (u.UserName ?? "").Trim();
                if (!string.IsNullOrWhiteSpace(fechaIso) && DateTime.TryParse(fechaIso, out var f))
                    actual.FechaNacimiento = f;

                string mensaje;
                var ok = _userService.Actualizar(actual, out mensaje);
                if (ok) 
                    ctx.Session["Usuario"] = actual;

                return new { ok, message = mensaje };
            }
            catch (Exception ex)
            {
                return new { ok = false, message = "Error interno: " + ex.Message };
            }
        }
    }
}