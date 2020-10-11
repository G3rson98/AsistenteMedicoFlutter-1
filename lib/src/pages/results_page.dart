import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatefulWidget {
  final List<Condition> listcondition;
  ResultPage({Key key, @required this.listcondition}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {  

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Confirmar diagnóstico',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: double.maxFinite,
              child: Column(
                children: <Widget>[
                  Text('Mi Diagnostico'),
                  Text(
                      new DateFormat.yMd().add_jm().format(new DateTime.now()),
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                      ),
                  SizedBox(
                    height: 40.0,
                  ),
                  _cardTipo1('Influenza', '98'),
                  SizedBox(
                    height: 40.0,
                  ),
                  _cardTipo1('Cancer de ano', '99'),
                  SizedBox(
                    height: 40.0,
                  ),
                  _cardTipo1('Influenza', '98'),
                  RaisedButton(
                    child: Text('hola jeje'),
                    onPressed: (){

                    },
                  )
                ],
              )),
        ));
  }

  Widget _cardTipo1(String enfermedad, String certeza) {
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
                  '% de certeza',
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
