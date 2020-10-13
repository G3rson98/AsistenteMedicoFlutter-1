import 'package:asistentemedico/src/models/estadistical_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:asistentemedico/src/models/carpeta_model.dart';
import 'package:asistentemedico/src/models/multimedia_model.dart';
import 'package:mime_type/mime_type.dart';

class MultimediaProvider {
  final _dataApi = "https://lit-dawn-93061.herokuapp.com/api";
  // "http://192.168.1.125:8080/asistenteMedico_backend/public/api";

  Future<List<CarpetaModel>> getCarpetas(int carpetaId) async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp = await http.get('$_dataApi/carpeta/show?carpeta_id=$carpetaId');
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CarpetaModel> carpetas = new List();
    if (decodeData['data'] == null) return [];
    final carpeta = decodeData['data'];
    // print(decodeData['data']);
    carpeta.forEach((value) {
      final c = CarpetaModel.fromJson(value);
      carpetas.add(c);
      // print(' value: ' + value.toString());
    });

    return carpetas;
  }

  Future<bool> eliminarCarpeta(int carpPadre, int carpHijo) async {
    //api/carpeta/delete?carpeta_padre_id=10&carpeta_id=54
    final url =
        '$_dataApi/carpeta/delete?carpeta_padre_id=$carpPadre&carpeta_id=$carpHijo';

    final resp = await http.delete(url);

    final decodedData = json.decode(
      resp.body,
    );

    print(decodedData["data"]);

    return true;
  }

  Future<bool> crearMultimedia(MultimediaModel multimedia) async {
    final url = '$_dataApi/multimedia/create';
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = multimediaModelToJson(multimedia);
    final encoding = Encoding.getByName('utf-8');

    final resp = await http.post(url,
        headers: headers, body: jsonBody, encoding: encoding);

    final decodedData = json.decode(
      resp.body,
    );

    print(decodedData["data"]);

    return true;
  }

  Future<bool> eliminarMultimedia(int multimedia_id) async {
    //http://192.168.1.125:8080/asistenteMedico_backend/public/api/multimedia/delete?multimedia_id=9
    final url = '$_dataApi/multimedia/delete?multimedia_id=$multimedia_id';
    //final headers = {'Content-Type': 'application/json'};
    // final encoding = Encoding.getByName('utf-8');

    final resp = await http.delete(url);

    final decodedData = json.decode(
      resp.body,
    );

    print(decodedData["data"]);

    return true;
  }

  Future<List<MultimediaModel>> getMultimedia(int carpetaId) async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp =
        await http.get('$_dataApi/multimedia/show?carpeta_id=$carpetaId');
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<MultimediaModel> multimedias = new List();
    if (decodeData['data'] == null) return [];
    final carpeta = decodeData['data'];
    //print(decodeData['data']);
    carpeta.forEach((value) {
      final c = MultimediaModel.fromJson(value);
      multimedias.add(c);
      print(' value: ' + value.toString());
    });

    return multimedias;
  }

  Future<List<EstadisticaModel>> getDatosEstadisticas(int carpetaId) async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp =
        await http.get('$_dataApi/multimedia/show?carpeta_id=$carpetaId');
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<EstadisticaModel> multimedias = new List();
    if (decodeData['data'] == null) return [];
    final carpeta = decodeData['data'];
    //print(decodeData['data']);
    carpeta.forEach((value) {
      final c = EstadisticaModel.fromJson(value);
      multimedias.add(c);
      print(' value: ' + value.toString());
    });

    return multimedias;
  }
  //EstadisticaModel

  Future<bool> crearCarpeta(CarpetaModel newCarpeta) async {
    final url = '$_dataApi/carpeta/create'; // ?auth=${_prefs.token}
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = carpetaModelToJson(newCarpeta);
    final encoding = Encoding.getByName('utf-8');

    final resp = await http.post(url,
        headers: headers, body: jsonBody, encoding: encoding);

    final decodedData = json.decode(
      resp.body,
    );

    print(decodedData["data"]);

    return true;
  }

  Future<String> subirMultimedia(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dxfnjrouy/image/upload?upload_preset=t9kmou7m');
    final mimeType = mime(imagen.path).split('/'); // img/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
