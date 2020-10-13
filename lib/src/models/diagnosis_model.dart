// To parse this JSON data, do
//
//     final diagnosisModel = diagnosisModelFromJson(jsonString);

import 'dart:convert';

DiagnosisModel diagnosisModelFromJson(String str) => DiagnosisModel.fromJson(json.decode(str));

String diagnosisModelToJson(DiagnosisModel data) => json.encode(data.toJson());

class DiagnosisModel {
    DiagnosisModel({
        this.nombreEnfermedad,
        this.probabilidad,
        this.usuarioId,
        this.idEnfermedad,
        this.idConsulta,
    });

    String nombreEnfermedad;
    double probabilidad;
    String usuarioId;
    String idEnfermedad;
    String idConsulta;

    factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
        nombreEnfermedad: json["nombre_enfermedad"],
        probabilidad: json["probabilidad"].toDouble(),
        usuarioId: json["usuario_id"],
        idEnfermedad: json["id_enfermedad"],
        idConsulta: json["id_consulta"],
    );

    Map<String, dynamic> toJson() => {
        "nombre_enfermedad": nombreEnfermedad,
        "probabilidad": probabilidad,
        "usuario_id": usuarioId,
        "id_enfermedad": idEnfermedad,
        "id_consulta": idConsulta,
    };
}
