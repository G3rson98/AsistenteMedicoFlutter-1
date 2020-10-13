import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:ui';

import 'package:asistentemedico/src/models/carpeta_model.dart';
import 'package:asistentemedico/src/models/multimedia_model.dart';
import 'package:asistentemedico/src/services/multimedia_service.dart';

class MultimediaPage extends StatelessWidget {
  final int carpetaID;
  final multi = new MultimediaProvider();
  // final carpetas = List<CarpetaModel>();

  MultimediaPage(this.carpetaID, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multimedia',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              crearListaCard(context, carpetaID),
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
            onTap: () {
              _showDialog(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.insert_drive_file),
            label: "Agregar archivo",
            backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
            onTap: () {
              _cargarMultimedia(context);
            },
          ),
        ],
      ),
    );
  }

  Widget crearListaCard(BuildContext context, int carpetaId) {
    return FutureBuilder(
      future: multi.getCarpetas(carpetaId),
      builder:
          (BuildContext context, AsyncSnapshot<List<CarpetaModel>> snapshot) {
        if (snapshot.hasData) {
          List<CarpetaModel> carpetasModel = snapshot.data;
          final List<Widget> carpetas = [];
          carpetasModel.forEach((element) {
            carpetas.add(_crearCard(context, element));
          });

          return FutureBuilder(
              future: multi.getMultimedia(carpetaId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MultimediaModel> multimediasModel = snapshot.data;
                  multimediasModel.forEach((element) {
                    carpetas.add(_crearCardMultimedia(context, element));
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
              });
        } else {
          return Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
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
            builder: (context) => MultimediaPage(carpeta.id),
          ),
        );
      },
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.folder,
                color: Color.fromRGBO(36, 247, 188, 1.0),
              ),
              Text(
                carpeta.nombre,
                style: TextStyle(fontSize: 18),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 20,
                      onPressed: () async {
                        alertaEliminarCarpeta(context, carpeta);
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
      ),
    );
  }

  Widget _crearCardMultimedia(BuildContext context, MultimediaModel multi) {
    return GestureDetector(
      onTap: () async {
        print('Traer lo haya en el file');
        // this.multi.downloadFile(multi.ruta, multi.nombre); '/storage/emulated/0/Download'
      },
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.filter,
                color: Color.fromRGBO(36, 247, 188, 1.0),
              ),
              Text(
                multi.nombre,
                style: TextStyle(fontSize: 18),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.share),
                      iconSize: 20,
                      onPressed: () {
                        // print('Compartir');
                        _shareMultimedia(multi);
                      },
                      color: Color.fromRGBO(36, 247, 188, 1.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 20,
                      onPressed: () async {
                        await this.multi.eliminarMultimedia(multi.id);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MultimediaPage(this.carpetaID),
                          ),
                        );
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
      ),
    );
  }

  void _showDialog(BuildContext context) async {
    TextEditingController inputController = new TextEditingController();
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: inputController,
                decoration: new InputDecoration(
                    labelText: 'Nombre Carpeta', hintText: 'eg. Nuevo'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                print('Input: ' + inputController.text);
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('CREAR'),
              onPressed: () async {
                // usuario_id: 1, carpetaID, nombre
                CarpetaModel newCarpeta = new CarpetaModel();
                newCarpeta.fkCarpeta = this.carpetaID;
                newCarpeta.nombre = inputController.text;
                newCarpeta.fkUsuario = 1;
                bool bandera = await this.multi.crearCarpeta(newCarpeta);
                if (bandera) {
                  print('Input: ' + inputController.text);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultimediaPage(this.carpetaID),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  void _showDialogMultimedia(BuildContext context, MultimediaModel m) async {
    TextEditingController inputController = new TextEditingController();
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: inputController,
                decoration: new InputDecoration(
                    labelText: 'Nombre Archivo', hintText: 'eg. ' + m.nombre),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                print('Input: ' + inputController.text);
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('CREAR'),
              onPressed: () async {
                // usuario_id: 1, carpetaID, nombre
                m.nombre = inputController.text;
                final bandera = await multi.crearMultimedia(m);
                if (bandera) {
                  print('Input: ' + inputController.text);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultimediaPage(this.carpetaID),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  void _cargarMultimedia(BuildContext context) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      String ruta =
          'https://res.cloudinary.com/dxfnjrouy/image/upload/v1602424207/zynqwlrg8hry6pkjo8f4.jpg'; // await this.multi.subirMultimedia(file);

      MultimediaModel m = new MultimediaModel(
          nombre: "tomografia", ruta: ruta, fkCarpeta: this.carpetaID);

      _showDialogMultimedia(context, m);
      // if (bandera) {
      print('===============');
      print('File: ' + file.path);
      print('===============');
      // }
      _clearCachedFiles();
    }
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      print('result' + result.toString());
      SnackBar(
        backgroundColor: result ? Colors.green : Colors.red,
        content: Text((result
            ? 'Temporary files removed with success.'
            : 'Failed to clean temporary files')),
      );
    });
  }

  Future<void> _shareMultimedia(MultimediaModel model) async {
    await FlutterShare.share(
        title: 'Compartir Multimedia',
        text: model.nombre,
        linkUrl: model.ruta,
        chooserTitle: 'Seleccione un Medio');
  }

  void alertaEliminarCarpeta(BuildContext context, CarpetaModel carpeta) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Desea eliminar la carpeta?'),
            content: Text('se eliminara con todo su contenido.'),
            actions: <Widget>[
              FlatButton(
                child: Text('cancel'),
                onPressed: () {
                  print('cancelado');
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  bool bandera = await this
                      .multi
                      .eliminarCarpeta(this.carpetaID, carpeta.id);
                  if (bandera) {
                    print('eliminado');
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultimediaPage(this.carpetaID),
                      ),
                    );
                  }
                },
              )
            ],
          );
        });
  }
}
