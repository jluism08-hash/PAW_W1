using System.Collections.Generic;
using System.Linq;
using PAW_W1.Models;

namespace PAW_W1.DAL
{
    public class UserRepository
    {
        private static List<User> users = new List<User>();

        private static int nextId = 3;

        public UserRepository()
        {
            if (users.Count == 0)
            {
                InicializarDatos();
            }
        }

        public List<User> Listar()
        {
            return users;
        }

        public User ObtenerPorId(int id)
        {
            // Linq con función lambda anónima
            return users.FirstOrDefault(usuario => usuario.Id == id);
        }

        public User ObtenerPorUserName(string username)
        {
            // Linq con función lambda anónima
            return users.FirstOrDefault(usuario => usuario.UserName == username);
        }

        public User ObtenerPorCorreo(string correo)
        {
            // Linq con función lambda anónima
            return users.FirstOrDefault(usuario => usuario.Correo == correo);
        }

        public User ObtenerPorLogin(string username, string password)
        {
            // Linq con función lambda anónima
            return users.FirstOrDefault(usuario => usuario.UserName == username && usuario.Contrasena == password);
        }

        public void Agregar(User user)
        {
            user.Id = nextId++;
            users.Add(user);
        }

        public void Actualizar(User user)
        {
            User usuario = ObtenerPorId(user.Id);
            if (usuario != null)
            {
                usuario.Nombre = user.Nombre;
                usuario.Correo = user.Correo;
                usuario.Direccion = user.Direccion;
                usuario.Telefono = user.Telefono;
                usuario.UserName = user.UserName;
                //usuario.Contrasena = user.Contrasena;
                usuario.FechaNacimiento = user.FechaNacimiento;
            }
        }

        public void Eliminar(int id)
        {
            User usuario = ObtenerPorId(id);
            if (usuario != null)
            {
                users.Remove(usuario);
            }
        }
        private void InicializarDatos()
        {
            users.Add(new User(1,
                                "Admin",
                                "admin@admin.com",
                                "Calle Falsa 123",
                                "555-1234",
                                "admin",
                                "admin",
                                new System.DateTime(1990, 1, 1)));
            users.Add(new User(2,
                                "User",
                                "use@use.com",
                                "Avenida Siempre Viva 742",
                                "555-5678",
                                "user",
                                "user",
                                new System.DateTime(1995, 5, 15)));
        }
    }
}