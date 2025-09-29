using System;

namespace PAW_W1.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public int Cantidad { get; set; }
        public Product()
        {
        }
        public Product(int id, string name, string description, decimal precio, int cantidad)
        {
            this.Id = id;
            this.Nombre = name;
            this.Descripcion = description;
            this.Precio = precio;
            this.Cantidad = cantidad;
        }
    }
}