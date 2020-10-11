import 'dart:convert';

CarpetaModel carpetaModelFromJson(String str) =>
    CarpetaModel.fromJson(json.decode(str));

String carpetaModelToJson(CarpetaModel data) => json.encode(data.toJson());

class CarpetaModel {
  int id;
  String nombre;
  int fkCarpeta;

  CarpetaModel({this.id, this.nombre, this.fkCarpeta});

  factory CarpetaModel.fromJson(Map<String, dynamic> json) => CarpetaModel(
      id: json["id"], nombre: json["nombre"], fkCarpeta: json["fk_carpeta"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "nombre": nombre, "fk_carpeta": fkCarpeta};
}
