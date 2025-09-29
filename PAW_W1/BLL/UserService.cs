using PAW_W1.DAL;
using PAW_W1.Models;

namespace PAW_W1.BLL
{
    public class UserService
    {
        private readonly UserRepository _userRepository = new UserRepository();
        
        public bool Registrar(User usuario, out string mensaje)
        {
            if (usuario == null)
            {
                mensaje = "Datos no válidos.";
                return false;
            }

            if (_userRepository.ObtenerPorUserName(usuario.UserName) != null)
            {
                mensaje = "Ya se encuentra una cuenta con ese nombre de usuario";
                return false;
            }

            if (_userRepository.ObtenerPorCorreo(usuario.Correo) != null)
            {
                mensaje = "Ya se encuentra una cuenta con ese correo electrónico";
                return false;
            }

            _userRepository.Agregar(usuario);
            mensaje = "Usuario registrado exitosamente.";
            return true;
        }

        public User Autenticar(string username, string password)
        {
            return _userRepository.ObtenerPorLogin(username, password);
        }

        public bool Actualizar(User usuario, out string mensaje)
        {
            var usuarioExistente = _userRepository.ObtenerPorId(usuario.Id);
            if (usuario == null)
            {
                mensaje = "Datos no válidos.";
                return false;
            }
            if (usuarioExistente == null)
            {
                mensaje = "Usuario no encontrado.";
                return false;
            }
            if (usuarioExistente.UserName != usuario.UserName && 
                _userRepository.ObtenerPorUserName(usuario.UserName) != null)
            {
                mensaje = "Ya se encuentra una cuenta con ese nombre de usuario";
                return false;
            }
            if (usuarioExistente.Correo != usuario.Correo && 
                _userRepository.ObtenerPorCorreo(usuario.Correo) != null)
            {
                mensaje = "Ya se encuentra una cuenta con ese correo electrónico";
                return false;
            }
            _userRepository.Actualizar(usuario);
            mensaje = "Usuario actualizado exitosamente.";
            return true;
        }
    }
}