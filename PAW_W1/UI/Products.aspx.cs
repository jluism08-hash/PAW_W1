using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using PAW_W1.BLL;
using PAW_W1.Models;

namespace PAW_W1.UI
{
    public partial class Products : Page
    {
        private static readonly ProductService _productService = new ProductService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!IsPostBack)
            {
                gvProducts.DataSource = _productService.Listar();
                gvProducts.DataBind();
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public static List<Product> ListarPorNombre(string nombre)
        {
            var lista = string.IsNullOrWhiteSpace(nombre) ? _productService.Listar() : _productService.ObtenerPorNombre(nombre);
            return lista.Select(p => new Product(p.Id, p.Nombre, p.Descripcion, p.Precio, p.Cantidad)).ToList();
        }
    }
}