import 'package:asistentemedico/src/models/carpeta_model.dart';
import 'package:asistentemedico/src/services/multimedia_service.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MultimediaPage extends StatelessWidget {
  MultimediaPage({Key key, List<CarpetaModel> list}) : super(key: key);

  MultimediaProvider multimediaProvider = new MultimediaProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multimedia',
            style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              crearListaCard(context, this.multimediaProvider),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.folder),
            label: "Agregar carpeta",
            backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
            onTap: () => print('Carpeta Creada'),
          ),
          SpeedDialChild(
            child: Icon(Icons.insert_drive_file),
            label: "Agregar archivo",
            backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
            onTap: () => print('Archivo Creado'),
          ),
        ],
      ),
    );
  }

  Widget crearListaCard(BuildContext context, MultimediaProvider multi) {
    return FutureBuilder(
      future: multi.getCarpetas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CarpetaModel>> snapshot) {
        if (snapshot.hasData) {
          final List<Widget> carpetas = [];
          snapshot.data.forEach((element) {
            carpetas.add(_crearCard(context, element));
          });
          return Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: carpetas,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearCard(BuildContext context, CarpetaModel carpeta) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultimediaPage(),
          ),
        );
      },
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.folder,
              color: Color.fromRGBO(36, 247, 188, 1.0),
            ),
            Text(
              carpeta.nombre,
              style: TextStyle(fontSize: 20),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 30,
                    onPressed: () {
                      print('Compartir');
                    },
                    color: Color.fromRGBO(36, 247, 188, 1.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    onPressed: () async {
                      //List<CarpetaModel> list = await multi.getCarpetas();
                      print('Eliminar');
                    },
                    color: Color.fromRGBO(36, 247, 188, 1.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
