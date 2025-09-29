using System.Collections.Generic;
using PAW_W1.DAL;
using PAW_W1.Models;

namespace PAW_W1.BLL
{
    public class ProductService
    {
        private readonly ProductRepository _productRepository = new ProductRepository();

        public List<Product> Listar()
        {
            return _productRepository.Listar();
        }

        public List<Product> ObtenerPorNombre(string nombre)
        {
            return _productRepository.ObtenerPorNombre(nombre);
        }

        public Product ObtenerPorId(int id)
        {
            return _productRepository.ObtenerPorId(id);
        }
    }
}