import 'dart:convert';

EstadisticaModel estadisticaModelFromJson(String str) =>
    EstadisticaModel.fromJson(json.decode(str));

String estadisticaModelToJson(EstadisticaModel data) =>
    json.encode(data.toJson());

class EstadisticaModel {
  int id;
  String nombreEnfermedad;
  double probabilidad;

  EstadisticaModel({this.id, this.nombreEnfermedad, this.probabilidad});

  factory EstadisticaModel.fromJson(Map<String, dynamic> json) =>
      EstadisticaModel(
          id: json["id"],
          nombreEnfermedad: json["nombre_enfermedad"],
          probabilidad: json["probabilidad"]);

  Map<String, dynamic> toJson() => {
        // "id": id,
        "id": id,
        "nombre_enfermedad": nombreEnfermedad,
        "probabilidad": probabilidad
      };
}
