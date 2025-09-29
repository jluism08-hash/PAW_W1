using System;

namespace PAW_W1.Models
{
    public class User
    {
        public int Id { get; set; }

        public string Nombre { get; set; }

        public string Correo { get; set; }

        public string Direccion { get; set; }

        public string Telefono { get; set; }

        public string UserName { get; set; }

        public string Contrasena { get; set; }

        public DateTime FechaNacimiento { get; set; }

        public User()
        {

        }

        public User(int id, string nombre, string correo, string direccion, string telefono, string userName, string contrasena, DateTime fechaNacimiento)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Correo = correo;
            this.Direccion = direccion;
            this.Telefono = telefono;
            this.UserName = userName;
            this.Contrasena = contrasena;
            this.FechaNacimiento = fechaNacimiento;
        }

        public override string ToString()
        {
            return Nombre;
        }
    }
}