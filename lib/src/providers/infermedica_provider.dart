import 'dart:convert';

import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:asistentemedico/src/models/diagnosis_query_model.dart';

class InfermedicaDiagnosisProvider {
  final String _url = "https://api.infermedica.com/v2/diagnosis";
  DiagnosisResponse diagnosisResponse;

  Future<DiagnosisResponse> sendCondition(DiagnosisQuery diagnosisQuery) async {
    final url       = '$_url';
    final respuesta = await http.post(
      url, 
      headers: {
        'App-Id'        : '81bf6841',
        'App-Key'       : '406d28e6cbff93be6239580728e4bc38',
        'Content-Type'  : 'application/json',
        'Model'         : 'infermedica-en'
      },
      body: diagnosisQueryToJson(diagnosisQuery)
    );
    
    final decodedData = json.decode(respuesta.body);
    diagnosisResponse = DiagnosisResponse.fromJson(decodedData);
    return diagnosisResponse;
  }

}