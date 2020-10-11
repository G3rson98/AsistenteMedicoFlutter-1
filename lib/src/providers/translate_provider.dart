import 'dart:convert';
import 'package:asistentemedico/src/models/translate_model.dart';
import 'package:http/http.dart' as http;

class TranslateProvider {

  final String _url = "https://translation.googleapis.com/language/translate/v2";

  Future<TranslateModel> getTranslation(String text) async {    

    TranslateModel translateModel = new TranslateModel();
    
    final url       = '$_url';
    var uri = Uri.parse(url);
    uri = uri.replace(queryParameters: {
      "target"  : "es",
      "key"     : "AIzaSyAVHitzUIUOPPCfzlDeiLZHIcpNXMb1-VU",
      "q"       : text
    });

    var response = await http.get(uri);
    final decodedData = json.decode(response.body);
    translateModel = TranslateModel.fromJson(decodedData);
    return translateModel;
  }
}