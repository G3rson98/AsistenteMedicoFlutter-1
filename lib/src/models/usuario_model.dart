// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    this.nombreUsuario,
    this.correo,
    this.password,
    this.celular,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.genero,
    this.fechaNac,
    this.lugarNac,
    this.altura,
    this.peso,
  });

  int id;
  String nombreUsuario;
  String correo;
  String password;
  int celular;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String genero;
  String fechaNac;
  String lugarNac;
  double altura;
  double peso;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombreUsuario: json["nombre_usuario"],
        correo: json["correo"],
        password: json["password"],
        celular: json["celular"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        genero: json["genero"],
        fechaNac: json["fecha_nac"],
        lugarNac: json["lugar_nac"],
        altura: (json["altura"] == null)
            ? null
            : num.tryParse(json["altura"]).toDouble(),
        peso: (json["peso"] == null)
            ? null
            : num.tryParse(json["peso"]).toDouble(),
      );

  String toString() {
    return 'Usuario {' +
        // 'id: ' +
        // this.id.toString() +
        ' nombreUsuario: ' +
        nombreUsuario +
        ' correo: ' +
        this.correo +
        // 'celular: ' +
        // this.celular.toString() +
        ' nombre: ' +
        this.nombre +
        ' apellidoPaterno: ' +
        this.apellidoPaterno +
        ' apellidoMaterno: ' +
        this.apellidoMaterno +
        ' genero: ' +
        this.genero +
        ' }';
    // 'altura: ' +
    // this.altura.toString() +
    // 'peso: ' +
    // this.peso.toString() +
    // 'lugarNac: ' +
    // this.lugarNac;
  }

  Map<String, dynamic> toJson() => {
        "usuario_id": id,
        "nombre_usuario": nombreUsuario,
        "correo": correo,
        "password": password,
        "celular": celular,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "genero": genero,
        "fecha_nac": fechaNac,
        "lugar_nac": lugarNac,
        "altura": altura,
        "peso": peso,
      };
}
