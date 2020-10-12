import 'package:asistentemedico/src/search/alergia_delegate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlergiasPage extends StatefulWidget {
  List<String> misAlergias = [];
  AlergiasPage({Key key, @required this.misAlergias}) : super(key: key);

  @override
  _AlergiasPageState createState() => _AlergiasPageState();
}

class _AlergiasPageState extends State<AlergiasPage> {
  // Future<List<String>> cargarAlergias() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getStringList('Alergias');

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alergias'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: AlergiaSearch());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: createRadioListAnswer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createRadioListAnswer() {
    List<Widget> radioWidgets = [];
    print(widget.misAlergias);
    for (var i = 0; (i < widget.misAlergias.length); i++) {
      radioWidgets
          .add(_cardTipo1(widget.misAlergias[i], 'Usted tiene alergia'));
    }
    return radioWidgets;
  }

  Widget _cardTipo1(String alergia, String descripcion) {
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
            title: Text(alergia),
            subtitle: Text(descripcion),
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
