import 'dart:convert';

import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:asistentemedico/src/models/symptom_model.dart';
import 'package:http/http.dart' as http;
import 'package:asistentemedico/src/models/diagnosis_query_model.dart';

class InfermedicaDiagnosisProvider {
  
  DiagnosisResponse diagnosisResponse;
  List <SintomasModel> sintomas= new List();

  final String _urlSymptoms = "https://api.infermedica.com/v2/symptoms";
  final String _urlDiagnosis = "https://api.infermedica.com/v2/diagnosis";

  Future<List<dynamic>> getConditions() async {    
    List nombre = new List();

    final url       = '$_urlSymptoms/';
    final respuesta = await http.get(
      url, 
      headers: {
        'App-Id' : '81bf6841',
        'App-Key' : '406d28e6cbff93be6239580728e4bc38'
      },      
    );    
    List<dynamic> decodedData = json.decode(respuesta.body);
  
    decodedData.forEach((element) { // recorriendo lo que me devuelve el Json
        sintomas.add(new SintomasModel.fromJson(element)); // creando modelos del Json
        
    });  
    sintomas.forEach((element) { // recorriendo mi lista de Sintomas para obtener solo el nombre
      List temp = new List();
      temp.add(element.name);      
      temp.add(element.id);       // insertando los nombre en la lista
      
      nombre.add(temp);
    });
    //print(nombre);

    return nombre;
  }

  Future<DiagnosisResponse> sendCondition(DiagnosisQuery diagnosisQuery) async {
    final url       = '$_urlDiagnosis';
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