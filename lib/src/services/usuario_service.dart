import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:asistentemedico/src/models/usuario_model.dart';

class UsuarioProvider {
  final String _url = 'https://lit-dawn-93061.herokuapp.com';

  Future<bool> validarLogin(Usuario usuario) async {
    final url = '$_url/api/login';

    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: usuarioToJson(usuario));

    final decodedData = json.decode(resp.body);
    print(decodedData);

    if (decodedData['login'] == true) {
      int id = decodedData['usuario']['id'];
      String nombreUsuario = decodedData['usuario']['nombre_usuario'];
      String correo = decodedData['usuario']['correo'];
      //Traer en esta consulta el ID de la carpeta Raiz del usuario que se esta logueando
      addIntToSF('id', id);
      addStringToSF('usuario', nombreUsuario);
      addStringToSF('correo', correo);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      print(prefs.containsKey('usuario'));
      return true;
    } else {
      print(false);
      return false;
    }
    // return true;
  }

  addStringToSF(String clave, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(clave, valor);
  }

  addIntToSF(String clave, int valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(clave, valor);
  }

  Future<Usuario> getUsuario(int usuarioId) async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp =
        await http.get('$_url/api/register/show?usuario_id=$usuarioId');
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    print(decodeData['data']);
    final Usuario usuario = Usuario.fromJson(decodeData['data']);
    return usuario;
  }

  Future<bool> editarUsuario(Usuario usuario) async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp = await http.put('$_url/api/register/edit',
        headers: {'Content-Type': 'application/json'},
        body: usuarioToJson(usuario));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    print(decodeData['data']);
    // final Usuario usuario = Usuario.fromJson(decodeData['data']);
    return true;
  }
}
