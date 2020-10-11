import 'dart:convert';

CarpetaModel carpetaModelFromJson(String str) =>
    CarpetaModel.fromJson(json.decode(str));

String carpetaModelToJson(CarpetaModel data) => json.encode(data.toJson());

class CarpetaModel {
  int id;
  String nombre;
  int fkCarpeta;
  int fkUsuario;

  CarpetaModel({this.id, this.nombre, this.fkCarpeta, this.fkUsuario});

  factory CarpetaModel.fromJson(Map<String, dynamic> json) => CarpetaModel(
      id: json["id"],
      nombre: json["nombre"],
      fkCarpeta: json["fk_carpeta"],
      fkUsuario: json["fk_usuario"]);

  Map<String, dynamic> toJson() => {
        // "id": id,
        "nombre": nombre,
        "carpeta_id": fkCarpeta,
        "usuario_id": fkUsuario
      };
}
