using System.Collections.Generic;
using System.Linq;
using PAW_W1.Models;

namespace PAW_W1.DAL
{
    public class ProductRepository
    {
        private static List<Product> products = new List<Product>();

        private static int nextId = 16;

        public ProductRepository()
        {
            InicializarDatos();
        }

        public List<Product> Listar()
        {
            return products;
        }

        public Product ObtenerPorId(int id)
        {
            // Linq con función lambda anónima
            return products.FirstOrDefault(producto => producto.Id == id);
        }

        public List<Product> ObtenerPorNombre(string nombre)
        {
            // Búsqueda que simula un LIKE en SQL (case-insensitive)
            return products
                .Where(producto => producto.Nombre != null && producto.Nombre.ToLower().Contains(nombre.ToLower()))
                .ToList();
        }

        public void Agregar(Product producto)
        {
            producto.Id = nextId++;
            products.Add(producto);
        }

        public void Actualizar(Product product)
        {
            Product producto = ObtenerPorId(product.Id);
            if (producto != null)
            {
                producto.Nombre = product.Nombre;
                producto.Descripcion = product.Descripcion;
                producto.Precio = product.Precio;
                producto.Cantidad = product.Cantidad;
            }
        }

        public void Eliminar(int id)
        {
            Product producto = ObtenerPorId(id);
            if (producto != null)
            {
                products.Remove(producto);
            }
        }

        public void InicializarDatos()
        {
            if (products.Count == 0)
            {
                products.Add(new Product { Id = 1, Nombre = "Laptop", Descripcion = "Laptop de alta gama", Precio = 1500, Cantidad = 10 });
                products.Add(new Product { Id = 2, Nombre = "Smartphone", Descripcion = "Smartphone con buena cámara", Precio = 800, Cantidad = 25 });
                products.Add(new Product { Id = 3, Nombre = "Tablet", Descripcion = "Tablet para entretenimiento", Precio = 300, Cantidad = 15 });
                products.Add(new Product { Id = 4, Nombre = "Monitor", Descripcion = "Monitor 4K", Precio = 400, Cantidad = 8 });
                products.Add(new Product { Id = 5, Nombre = "Teclado", Descripcion = "Teclado mecánico", Precio = 100, Cantidad = 30 });
                products.Add(new Product { Id = 6, Nombre = "Ratón", Descripcion = "Ratón inalámbrico", Precio = 50, Cantidad = 20 });
                products.Add(new Product { Id = 7, Nombre = "Auriculares", Descripcion = "Auriculares con cancelación de ruido", Precio = 200, Cantidad = 12 } );
                products.Add(new Product { Id = 8, Nombre = "Impresora", Descripcion = "Impresora láser", Precio = 250, Cantidad = 5 });
                products.Add(new Product { Id = 9, Nombre = "Cámara", Descripcion = "Cámara digital", Precio = 600, Cantidad = 7 });    
                products.Add(new Product { Id = 10, Nombre = "Disco Duro", Descripcion = "Disco duro externo 1TB", Precio = 120, Cantidad = 18 });
                products.Add(new Product { Id = 11, Nombre = "Router", Descripcion = "Router WiFi 6", Precio = 180, Cantidad = 14 });
                products.Add(new Product { Id = 12, Nombre = "Proyector", Descripcion = "Proyector HD", Precio = 350, Cantidad = 6 });
                products.Add(new Product { Id = 13, Nombre = "Smartwatch", Descripcion = "Smartwatch con GPS", Precio = 220, Cantidad = 22 });
                products.Add(new Product { Id = 14, Nombre = "Altavoces", Descripcion = "Altavoces Bluetooth", Precio = 90, Cantidad = 16 });
                products.Add(new Product { Id = 15, Nombre = "Memoria USB", Descripcion = "Memoria USB 64GB", Precio = 25, Cantidad = 40 } );

            }
        }
    }
}