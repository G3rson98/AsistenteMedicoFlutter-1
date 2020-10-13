import 'dart:convert';

import 'package:asistentemedico/src/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistorialPage extends StatefulWidget {
  HistorialPage({Key key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  String correo;
  String sexo;
  int id;
  SharedPreferences _prefs;

  UsuarioProvider usu = new UsuarioProvider();

  List<dynamic> enfermedades;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                usu.correo,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                usu.genero,
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
            children: <Widget>[
              armarHist(context),
            ],
          ),
          SizedBox(height: 30),
        ],
      )),
    );
  }

  // Future<Map<String,dynamic>> cargardatos() async {
  //   Map <String,dynamic> temp ;
  //   _prefs = await SharedPreferences.getInstance();
  //   temp['correo']= _prefs.getString('correo');
  //   temp['genero'] = _prefs.getString('genero');
  //   temp['id'] = _prefs.getInt('id');

  //   return temp;
  // }

  Widget armarHist(BuildContext context) {
    return FutureBuilder(
      future: usu.getHistorial(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>>snapshot) {
        if (snapshot.hasData) {
          var a = snapshot.data;
          final List<Widget> radioWidgets = [] ;
          a.forEach((element) {
            radioWidgets.add(_cardTipo1(element['nombre_enfermedad'], element['probabilidad'], element['fecha']));
            print(element);
          });
          return Container(
            child: Column(
              children: radioWidgets,
            ),
          );
        }else{
          return Center(
                    child: CircularProgressIndicator(),
                  );
        }
      },
    );
  }

  List<Widget> createRadioListAnswer() {
    List<Widget> radioWidgets = [];
    for (var i = 0; (i < this.enfermedades.length); i++) {
      radioWidgets.add(_cardTipo1('hhhh', '98', '2020-10-11'));
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
