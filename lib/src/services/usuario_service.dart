
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:asistentemedico/src/models/usuario_model.dart';

class UsuarioProvider {
  final String _url = 'https://lit-dawn-93061.herokuapp.com';

  Future<bool> validarLogin( Usuario usuario ) async{
    
    final url = '$_url/api/login';

    final resp = await http.post(
      url,
      headers: {
        'Content-Type' : 'application/json'
      },
      body: usuarioToJson(usuario)
    );

    final decodedData = json.decode(resp.body);
    print(decodedData);

    if ( decodedData['login'] == true ){

      int id = decodedData['usuario']['id'];
      String nombreUsuario = decodedData['usuario']['nombre_usuario'];
      String correo = decodedData['usuario']['correo'];

      addIntToSF('id', id);
      addStringToSF('usuario', nombreUsuario);
      addStringToSF('correo', correo);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      print(prefs.containsKey('usuario'));
  
      return true;
    }else{
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
}