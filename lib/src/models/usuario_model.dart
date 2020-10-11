import 'dart:convert';

import 'dart:ffi';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  int id;
  String nombreUsuario;
  String correo;
  int telefono;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String genero;
  String lugarNac;
  Float altura;
  Float peso;

  UsuarioModel(
      {this.id,
      this.nombreUsuario,
      this.correo,
      this.telefono,
      this.nombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.genero,
      this.lugarNac,
      this.altura,
      this.peso});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombreUsuario: json["nombreUsuario"],
        correo: json["correo"],
        telefono: json["telefono"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        genero: json["genero"],
        lugarNac: json["lugarNac"],
        altura: json["altura"],
        peso: json["peso"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "correo": correo,
        "telefono": telefono,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "genero": genero,
        "lugarNac": lugarNac,
        "altura": altura,
        "peso": peso,
      };
}
