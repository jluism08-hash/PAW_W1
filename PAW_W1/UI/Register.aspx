<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PAW_W1.UI.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Registro</title>
        <script src="<%: ResolveUrl("~/Scripts/jquery-3.7.0.js") %>"></script>
<script src="<%: ResolveUrl("~/Scripts/bootstrap.js") %>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.min.js"></script>
<link href="<%: ResolveUrl("~/Content/bootstrap.css") %>" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h1 class="h4 mb-4 text-center">Registro de usuario</h1>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="form-label">Nombre completo</asp:Label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtCorreo" CssClass="form-label">Correo electrónico</asp:Label>
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtTelefono" CssClass="form-label">Teléfono</asp:Label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtFecNacimiento" CssClass="form-label">Fecha de nacimiento</asp:Label>
                            <asp:TextBox ID="txtFecNacimiento" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtUser" CssClass="form-label">Usuario</asp:Label>
                            <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="txtPass" CssClass="form-label">Contraseña</asp:Label>
                            <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>

                        <div class="mb-4">
                            <asp:Label runat="server" AssociatedControlID="txtConfirm" CssClass="form-label">Confirmar contraseña</asp:Label>
                            <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>

                        <div class="form-check mb-3">
                          <input id="chkTerminos" type="checkbox" class="form-check-input" />
                          <label for="chkTerminos" class="form-check-label">
                            Acepto los <a href="#" tabindex="-1">términos y condiciones</a>
                          </label>
                          <div id="errTerminos" class="text-danger small d-none">Debes aceptar los términos.</div>
                        </div>


                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar"
                                    CssClass="btn btn-success w-100" OnClick="btnRegistrar_Click" />

                        <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3"></asp:Label>

                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
    <script>
        $(function () {

            $("#form1 input").on("input change", function () {
                $(this).removeClass("is-invalid");
            });
            $("#form1").on("submit", function (e) {
                let ok = true, msgs = [];
                $("#form1 input").removeClass("is-invalid");
              
                function requerido(id, txt) {
                    const $x = $(id);
                    if ($x.val().trim() === "") {
                        $x.addClass("is-invalid");
                        ok = false;
                        msgs.push(txt);
                    }
                }

                requerido("#txtNombre", "El nombre es obligatorio.");
                requerido("#txtCorreo", "El correo es obligatorio.");
                requerido("#txtFecNacimiento", "La fecha de nacimiento es obligatoria.");
                requerido("#txtUser", "El usuario es obligatorio.");
                requerido("#txtPass", "La contraseña es obligatoria.");
                requerido("#txtConfirm", "Debe confirmar la contraseña.");

                // Correo válido
                const correo = $("#txtCorreo").val().trim();
                const reMail = /^[^\s@]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
                if (correo && !reMail.test(correo)) {
                    $("#txtCorreo").addClass("is-invalid");
                    ok = false;
                    msgs.push("Correo inválido (usuario@dominio.ext).");
                }

                // Confirmar contraseña
                const p1 = $("#txtPass").val(), p2 = $("#txtConfirm").val();
                if (p1 && p2 && p1 !== p2) {
                    $("#txtConfirm").addClass("is-invalid");
                    ok = false;
                    msgs.push("La confirmación de contraseña no coincide.");
                }

                // Mayor de edad
                const fv = $("#txtFecNacimiento").val();
                if (fv) {
                    const hoy = new Date(), min = new Date(hoy.getFullYear() - 18, hoy.getMonth(), hoy.getDate());
                    const dob = new Date(fv);
                    if (!(dob instanceof Date) || isNaN(dob) || dob > min) {
                        $("#txtFecNacimiento").addClass("is-invalid");
                        ok = false;
                        msgs.push("Debe ser mayor de 18 años.");
                    }
                }

                if (!$("#chkTerminos").is(":checked")) {
                    ok = false;
                    msgs.push("Debe aceptar los términos y condiciones.");
                    $("#errTerminos").removeClass("d-none");
                } else {
                    $("#errTerminos").addClass("d-none");
                }

                if (!ok) {
                    e.preventDefault();
                    $.notify(msgs.join("\n"), "error");
                }
            });

            // Nombre: solo letras y espacios
            $("#txtNombre").on("keyup blur", function () {
                const val = $(this).val().trim();
                const regex = /^[A-Za-zÁÉÍÓÚáéíóúÑñ ]{3,}$/;
                if (!regex.test(val)) {
                    $(this).addClass("is-invalid");
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                }
            });

            // Correo: debe tener @
            $("#txtCorreo").on("keyup blur", function () {
                const val = $(this).val().trim();
                const regex = /^[^\s@]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
                if (!regex.test(val)) {
                    $(this).addClass("is-invalid");
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                }
            });

            // Confirmar contraseña
            $("#txtConfirm").on("keyup blur", function () {
                const p1 = $("#txtPass").val(), p2 = $("#txtConfirm").val();
                if (p1 !== p2) {
                    $("#txtConfirm").addClass("is-invalid");
                } else {
                    $("#txtConfirm").removeClass("is-invalid").addClass("is-valid");
                }
            });

            // Fecha de nacimiento: obligatorio y mayor de 18 años
            $("#txtFecNacimiento").on("change blur", function () {
                const val = $(this).val();
                if (!val) {
                    $(this).addClass("is-invalid");
                    return;
                }

                const hoy = new Date();
                const min = new Date(hoy.getFullYear() - 18, hoy.getMonth(), hoy.getDate());
                const fecha = new Date(val);

                if (isNaN(fecha.getTime()) || fecha > min) {
                    $(this).addClass("is-invalid");
                } else {
                    $(this).removeClass("is-invalid").addClass("is-valid");
                }
            });
            $("#chkTerminos").on("change", function () {
                $("#errTerminos").toggleClass("d-none", $(this).is(":checked"));
            });
        });
    </script>
</body>
</html>
