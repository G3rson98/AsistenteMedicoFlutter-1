import 'dart:convert';
import 'package:asistentemedico/src/models/diagnosis_model.dart';
import 'package:http/http.dart' as http;

class DiagnosisProvider {

  final String _url = "https://lit-dawn-93061.herokuapp.com/api/diagnostico/create";

  Future<bool> createDiagnosis(DiagnosisModel diagnosisModel) async {    
    print("Davdi");
    print(diagnosisModel.toJson);
    print(diagnosisModelToJson(diagnosisModel));
    // final url       = '$_url/';
    final respuesta = await http.post(
      _url, 
      headers: {'Content-Type': 'application/json'},
      body:  json.encode({
        "nombre_enfermedad" : diagnosisModel.nombreEnfermedad,
        "probabilidad"      : diagnosisModel.probabilidad,
        "id_consulta"       : diagnosisModel.idConsulta,
        "usuario_id"        : diagnosisModel.usuarioId,
        "id_enfermedad"     : diagnosisModel.idEnfermedad
      })
    );   
    final encoded = json.encode(respuesta.body);
    final decodedData = json.decode(encoded);
    print(decodedData);
    return true;
  }

  Future<bool> updateDiagnosis(DiagnosisModel diagnosisModel) async {    
    final url       = 'https://lit-dawn-93061.herokuapp.com/api/diagnostico/edit';
    final respuesta = await http.put(
      url, 
      headers: {'Content-Type': 'application/json'},
      body:  json.encode({
        "diagnostico_id" : 1,
        "confirmacion"      : true
      })
    );   
    final encoded = json.encode(respuesta.body);
    final decodedData = json.decode(encoded);
    print(decodedData);
    return true;
  }
}