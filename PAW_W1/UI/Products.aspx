<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="PAW_W1.UI.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style>
    /* Solo presentación, no cambia lógica */
    .page-title { display:flex; align-items:center; justify-content:space-between; }
    /* Truncar Descripción (columna 3) sin romper tabla */
    #<%= gvProducts.ClientID %> td:nth-child(3){
      max-width:520px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
    }
    /* Estado “sin resultados” más legible */
    .empty-row { text-align:center; color:#6c757d; padding:1rem 0; }
  </style>

  <div class="container py-4">
    <div class="page-title mb-3">
      <h2 class="h4 m-0">Listado de productos</h2>
    </div>

    <!-- Buscador -->
    <div class="input-group mb-3">
      <span class="input-group-text">Buscar</span>
      <input id="txtBuscar" placeholder="Buscar productos..." class="form-control" autocomplete="off" />
    </div>

    <!-- Tabla en card -->
    <div class="card shadow-sm">
      <div class="card-body p-0">
        <div class="table-responsive">
          <asp:GridView ID="gvProducts" runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-striped table-hover align-middle mb-0"
            GridLines="None" ShowHeader="true">
            <Columns>
              <asp:BoundField DataField="Id" HeaderText="ID" />
              <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
              <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
              <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}" />
              <asp:BoundField DataField="Cantidad" HeaderText="Stock" />
            </Columns>
          </asp:GridView>
        </div>
      </div>
    </div>
  </div>

  <!-- jQuery (igual que tenías) -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <!-- Tu JS intacto; solo una clase para el “sin resultados” (presentación) -->
  <script type="text/javascript">
      function $tbl() { return $("#<%= gvProducts.ClientID %>"); }
      function clearDataRows() { $tbl().find("tr").filter(function () { return $(this).children("td").length > 0; }).remove(); }
      function appendAfterHeader(htmlRows) {
          const $t = $tbl(), $lastHeader = $t.find("tr:has(th)").last();
          if ($lastHeader.length) { $lastHeader.after(htmlRows); } else { $t.append(htmlRows); }
      }
      function renderRows(items) {
          clearDataRows();
          if (!items || !items.length) { appendAfterHeader('<tr><td class="empty-row" colspan="5">Sin resultados</td></tr>'); return; }
          let rows = "";
          for (const p of items) {
              rows += `<tr>
          <td>${p.Id}</td>
          <td>${p.Nombre ?? ""}</td>
          <td>${p.Descripcion ?? ""}</td>
          <td>${p.Precio}</td>
          <td>${p.Cantidad}</td>
        </tr>`;
          }
          appendAfterHeader(rows);
      }

      function cargarTodo() {
          $.ajax({
              type: "POST", url: "Products.aspx/ListarTodos",
              contentType: "application/json; charset=utf-8", dataType: "json",
              success: res => renderRows(res.d)
          });
      }
      function buscarNombre(q) {
          $.ajax({
              type: "POST",
              url: "Products.aspx/ListarPorNombre",
              contentType: "application/json; charset=utf-8",
              data: JSON.stringify({ nombre: q }),
              dataType: "json"
          })
          .done(res => renderRows(res.d))
          .fail(xhr => console.error("HTTP", xhr.status, xhr.responseText));
      }

      let debounceId = null;
      $(function () {
          cargarTodo();
          $("#txtBuscar").on("input", function () {
              const q = this.value.trim();
              if (debounceId) { clearTimeout(debounceId); debounceId = null; }
              if (q.length < 2) { cargarTodo(); return; }
              debounceId = setTimeout(() => buscarNombre(q), 200);
          });
      });
  </script>
</asp:Content>

