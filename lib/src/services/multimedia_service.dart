import 'dart:async';
import 'dart:convert';

import 'package:asistentemedico/src/models/carpeta_model.dart';
import 'package:http/http.dart' as http;

class MultimediaProvider {
  final _dataApi =
      "http://192.168.1.125:8080/asistenteMedico_backend/public/api";
  // List _populares = new List();
  // bool _cargando = false;

  final _populalesStreamController = StreamController<List>.broadcast();

  Function(List) get popularesSink => _populalesStreamController.sink.add;

  Stream<List> get popularesStream => _populalesStreamController.stream;

  void disposeStreams() {
    _populalesStreamController?.close();
  }

  // Future<List> _procesarRespuesta(Uri url) async {
  //   final resp = await http.get(url);
  //   final decodeData = json.decode(resp.body);

  //   final peliculas = new Peliculas.fromJsonList(decodeData['results']);
  //   // print(decodeData['results']);
  //   return peliculas.items;
  // }

  Future<List<CarpetaModel>> getCarpetas() async {
    // http://192.168.1.125:8088/api/carpeta/show?carpeta_id=1
    final resp = await http.get('$_dataApi/carpeta/show?carpeta_id=1');
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CarpetaModel> carpetas = new List();
    if (decodeData['data'] == null) return [];
    final carpeta = decodeData['data'];
    print(decodeData['data']);
    carpeta.forEach((value) {
      final c = CarpetaModel.fromJson(value);
      carpetas.add(c);
      print(' value: ' + value.toString());
    });

    return carpetas;
  }

  // Future<List> getPopulares() async{

  //   if(_cargando) return [];

  //   _cargando = true;
  //   _popularesPage++;

  //   final url = Uri.https(_url, '3/movie/popular',{
  //     'api_key' : _apiKey,
  //     'language': _language,
  //     'page' : _popularesPage.toString(),
  //   });
  //   // print(_popularesPage.toString());
  //   final resp = await _procesarRespuesta(url);

  //   _populares.addAll(resp);
  //   popularesSink( _populares );

  //   _cargando = false;
  //   return resp;
  // }

  // Future<List> getCast(String peliId) async{

  //   final url = Uri.https(_url, '3/movie/$peliId/credits',{
  //     'api_key' : _apiKey,
  //     'language' : _language
  //   });

  //   final resp = await http.get(url);
  //   final decodeData = json.decode(resp.body);

  //   final cast = new Cast.fromJsonList(decodeData['cast']);

  //   return cast.actores;

  // }

  // Future<List<Pelicula>> buscarPelcula(String pelicula) async{

  //   final url = Uri.https(_url, '3/search/movie',{
  //     'api_key' : _apiKey,
  //     'language': _language,
  //     'query' : pelicula
  //   });

  //   return await _procesarRespuesta(url);
  // }

}
