import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:asistentemedico/src/models/usuario_model.dart';

class UsuarioProvider {
  final String _url = 'https://lit-dawn-93061.herokuapp.com';

  static final UsuarioProvider _instancia = new UsuarioProvider._internal();

  UsuarioProvider._internal();

  SharedPreferences _prefs;

  //Constructor factory o normal
  factory UsuarioProvider() {
    return _instancia;
  }

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

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
      addStringToSF('genero', decodedData['usuario']['genero']);
      addIntToSF('edad', decodedData['edad']);
      addIntToSF('carpeta_raiz', decodedData['carpeta_raiz']);
      addAlergias('Alergias', ['gripe', 'alergia al polvo', 'migraña']);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      print(prefs.containsKey('usuario'));
      print(prefs.containsKey('edad'));
      return true;
    } else {
      print(false);
      return false;
    }
    // return true;
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

  addStringToSF(String clave, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(clave, valor);
  }

  addIntToSF(String clave, int valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(clave, valor);
  }

  get usuario {
    return _prefs.getString('usuario');
  }

  get correo {
    return _prefs.getString('correo');
  }

  get genero {
    return _prefs.getString('genero');
  }

  get id {
    return _prefs.getInt('id');
  }

  get edad {
    return _prefs.getInt('edad');
  }

  get carpetaRaiz {
    return _prefs.getInt('carpeta_raiz');
  }

  Future<bool> insertarUsuario(Usuario usuario) async {
    final url = '$_url/api/register';

    // print(usuario.toJson());

    if (usuario.correo != null &&
        usuario.nombreUsuario != null &&
        usuario.nombre != null &&
        usuario.apellidoMaterno != null &&
        usuario.apellidoPaterno != null &&
        usuario.password != null &&
        usuario.altura != null &&
        usuario.peso != null &&
        usuario.fechaNac != null &&
        usuario.celular != null) {
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: usuarioToJson(usuario));

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['exito'] == true) {
        print(true);
        return true;
      } else {
        print(false);
        return false;
      }
    } else {
      return false;
    }
  }

  addAlergias(String clave, List<String> valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(clave, valor);
  }
}
