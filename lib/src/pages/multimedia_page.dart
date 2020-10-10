import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class MultimediaPage extends StatefulWidget {
  MultimediaPage({Key key}) : super(key: key);

  @override
  _MultimediaPageState createState() => _MultimediaPageState();
}

class _MultimediaPageState extends State<MultimediaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multimedia', style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              crearCard(context),
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
}

Widget crearCard(BuildContext context){
  return Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget> [
                    GestureDetector(
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
                          children: <Widget> [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            ),
                            Icon(
                              Icons.folder, 
                              color: Color.fromRGBO(36, 247, 188, 1.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Text(
                              'Carpeta',
                              style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 65),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                children: <Widget> [
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    iconSize: 30,
                                    onPressed: () {print('Compartir');},
                                    color: Color.fromRGBO(36, 247, 188, 1.0),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    iconSize: 30,
                                    onPressed: () {print('Eliminar');},
                                    color: Color.fromRGBO(36, 247, 188, 1.0),
                                  ),
                                ],
                              ),
                              
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  ],
                ),
                
              );
}