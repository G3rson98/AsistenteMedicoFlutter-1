import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:asistentemedico/src/search/search_delegate.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                
        title: Text('Diagnostico'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
            ),          
        ],

      ),
      body: FloatingActionButton(onPressed: (){
      var infermedicaProvider = InfermedicaDiagnosisProvider().getConditions();
      }),
    );
  }
}