import 'dart:convert';

MultimediaModel multimediaModelFromJson(String str) =>
    MultimediaModel.fromJson(json.decode(str));

String multimediaModelToJson(MultimediaModel data) =>
    json.encode(data.toJson());

class MultimediaModel {
  int id;
  String nombre;
  String ruta;
  int fkCarpeta;

  MultimediaModel({this.id, this.nombre, this.ruta, this.fkCarpeta});

  factory MultimediaModel.fromJson(Map<String, dynamic> json) =>
      MultimediaModel(
          id: json["id"],
          nombre: json["nombre"],
          ruta: json["ruta"],
          fkCarpeta: json["fk_carpeta"]);

  Map<String, dynamic> toJson() =>
      {/*"id": id,*/ "nombre": nombre, "url": ruta, "carpeta_id": fkCarpeta};
}
