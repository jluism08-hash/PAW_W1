<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PAW_W1.UI.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login</title>
    <script src="<%: ResolveUrl("~/Scripts/jquery-3.7.0.js") %>"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap.js") %>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.min.js"></script>
<link href="<%: ResolveUrl("~/Content/bootstrap.css") %>" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-sm-8 col-md-6 col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h1 class="h4 mb-4 text-center">Iniciar sesión</h1>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtUser" CssClass="form-label">Usuario</asp:Label>
                            <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtPass" CssClass="form-label">Contraseña</asp:Label>
                            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="form-control" />
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-primary w-100 mb-3" OnClick="btnLogin_Click" />

                        <!-- Mensaje de error/éxito -->
                        <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3"></asp:Label>

                        <div class="text-center">
                            <asp:HyperLink runat="server" NavigateUrl="~/UI/Register.aspx" CssClass="small">
                                ¿No tienes cuenta? Regístrate
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
    <script>
        $(function () {
            $("#form1").on("submit", function (e) {
                let ok = true;

                if ($("#txtUser").val().trim() === "") {
                    $("#txtUser").addClass("is-invalid");
                    ok = false;
                }

                if ($("#txtPass").val().trim() === "") {
                    $("#txtPass").addClass("is-invalid");
                    ok = false;
                }

                if (!ok) {
                    e.preventDefault(); 
                    $.notify("Se deben ingresar usuario y password", "error");
                }
            });
        });
    </script>
</body>
</html>
