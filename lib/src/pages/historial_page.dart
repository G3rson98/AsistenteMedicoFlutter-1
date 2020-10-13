import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistorialPage extends StatefulWidget {
  HistorialPage({Key key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  String nombre;
  String correo;
  String sexo;
  SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    cargardatos();
    getHistorial();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // here the desired height
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromRGBO(36, 247, 188, 1.0),
                  Color.fromRGBO(36, 196, 249, 1.0),
                ]),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    'Historial de consultas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          child: IconButton(
                              icon: Icon(Icons.home),
                              onPressed: () {
                                Navigator.of(context).pushNamed('begin');
                              })))
                ],
              ),
              Text(
                'Joaquin@gmail.com',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Masculino',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Column(
            children: createRadioListAnswer(),
          ),
          SizedBox(height: 30),
        ],
      )),
    );
  }

  Future<void> cargardatos() async {
    _prefs = await SharedPreferences.getInstance();
    this.correo= _prefs.getString('correo');
    this.sexo = _prefs.getString('genero');
  }

  Future<void> getHistorial() async {
    final idUsuario=_prefs.getString('id');
    final url ='https://lit-dawn-93061.herokuapp.com/api/diagnostico/show?usuario_id=$idUsuario';
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json'});

    final decodedData = json.decode(resp.body);
    print(decodedData);
  }

  List<Widget> createRadioListAnswer() {
    List<Widget> radioWidgets = [];
    for (var i = 0; (i < 3); i++) {
      radioWidgets.add(_cardTipo1('sore throath', '98', '2020-10-11'));
    }
    return radioWidgets;
  }

  Widget _cardTipo1(String enfermedad, String certeza, String fecha) {
    return Card(
      //elevation: Sirve para poner sombra a un card, de acuerdo al nivel de elevacion.
      //shape: sirve para poner el card de diferentes formas: circulares, punteaguados, etc.
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.check,
              color: Colors.blue,
              size: 35.0,
            ),
            title: Text(enfermedad),
            subtitle: Text(
              'Usted ha sido diagnosticado con ' +
                  enfermedad +
                  ' con un ' +
                  certeza +
                  '% de certeza' +
                  ' en fecha ' +
                  fecha,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Informacion'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
