<%@ Page Title="Perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" ClientIDMode="Static" CodeBehind="Perfil.aspx.cs" Inherits="PAW_W1.UI.Perfil" %>

<asp:Content ID="c1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h2 class="h4 mb-4 text-center">Mi Perfil</h2>

                    <asp:Label ID="lblMsg" runat="server" EnableViewState="false" CssClass="d-block mb-3"></asp:Label>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtNombre" CssClass="form-label">Nombre completo</asp:Label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Nombre completo" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtCorreo" CssClass="form-label">Correo electrónico</asp:Label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtTelefono" CssClass="form-label">Teléfono</asp:Label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Placeholder="Teléfono" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtUserName" CssClass="form-label">Usuario</asp:Label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" Placeholder="Usuario" ReadOnly="true"/>
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="txtFecha" CssClass="form-label">Fecha de nacimiento</asp:Label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true" />
                    </div>

                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                                CssClass="btn btn-primary w-100" />
                </div>
            </div>
        </div>
    </div>
</div>


  <script>
      $(function () {
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

          $("#btnGuardar").on("click", function (e) {
              e.preventDefault();
              let ok = true, msgs = [];    
              const user = {
                  Nombre: $("#txtNombre").val().trim(),
                  Correo: $("#txtCorreo").val().trim(),
                  Telefono: $("#txtTelefono").val().trim(),
                  UserName: $("#txtUserName").val().trim(),
                  Contrasena: $("#txtContrasena").val()
              };

              if (!user.Nombre) {
                  ok = false;
                  $("#txtNombre").addClass("is-invalid").focus();
                  msgs.push("El nombre es obligatorio.");
              }

              if (!user.Correo) {
                  ok = false;
                  $("#txtCorreo").addClass("is-invalid").focus();
                  msgs.push("El correo es obligatorio.");
              }

              const reMail = /^[^\s@]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
              if (user.Correo && !reMail.test(user.Correo)) {
                  $("#txtCorreo").addClass("is-invalid");
                  ok = false;
                  msgs.push("Correo inválido (usuario@dominio.ext).");
              }

              if (ok) {
                  $.ajax({
                      url: "Perfil.aspx/ActualizarPerfil",
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      data: JSON.stringify({
                          userJson: JSON.stringify(user),   // ← ahora va como string
                          fechaIso: $("#txtFecha").val()
                      }),
                      dataType: "json"
                  })
                      .done(res => {
                          const ok = res && res.d && res.d.ok;
                          const msg = res && res.d ? res.d.message : "Error al actualizar.";
                          $.notify("Actualización realizada con éxito", "success");
                      })
                      .fail(xhr => {
                          $.notify("HTTP " + xhr.status, "error");
                      });
              } else {
                  $.notify(msgs.join("\n"), "error");
              }

              
          });
      });

  </script>
</asp:Content>
