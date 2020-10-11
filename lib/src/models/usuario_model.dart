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
        lugarNac: json["lugar_nac"],
        altura: json["altura"].toDouble(),
        peso: json["peso"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_usuario": nombreUsuario,
        "correo": correo,
        "password": password,
        "celular": celular,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "genero": genero,
        "lugar_nac": lugarNac,
        "altura": altura,
        "peso": peso,
    };
}
