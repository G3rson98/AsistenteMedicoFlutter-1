import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _encabezado() {
    return PreferredSize(
        preferredSize: Size.fromHeight(135.0), // here the desired height
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: SafeArea(
              child: Text(
            "",
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind'),
          )),
        ));
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          //color: Color.fromRGBO(3, 67, 68, 1.0)
          color: Colors.white),
    );

    final cajaRosa = Transform.rotate(
      // Permite rotar un child indicando el angulo.
      angle: -pi / 5.0,
      child: Container(
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(36, 247, 188, 1.0),
              Color.fromRGBO(36, 196, 249, 1.0),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -90.0,
          right: 44.0,
          child: cajaRosa,
        ) //Permite ubicar un elemento con coordenadas especificas
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Text('ASISTENTE MÉDICO',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 30.0),
            //Text('Classify this transaction into a particular category', style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: <TableRow>[
        //Fila de una tabla
        TableRow(
          children: [
            _crearBotonRedondeado(
                Colors.blue, Icons.sentiment_very_dissatisfied, 'Diagnóstico'),
            _crearBotonRedondeado(
                Colors.red, Icons.calendar_today, 'Calendario'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(
                Colors.amber, Icons.insert_drive_file, 'Documentos'),
            _crearBotonRedondeado(
                Colors.green, Icons.local_hospital, 'Consultas'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(
                Colors.orange, Icons.insert_chart, 'Estadísticas'),
            _crearBotonRedondeado(
                Colors.purple, Icons.person_outline, 'Perfil'),
          ],
        ),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 160.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.10),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: IconButton(
                  icon: Icon(icono),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Text(texto,
                  style: TextStyle(
                    color: color,
                  )),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
