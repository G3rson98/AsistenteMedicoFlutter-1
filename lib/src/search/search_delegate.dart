import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  ////////////////////////////////////////////////////
  ///
  ///
  List preguntas ;
  List ids;
  List objSintomas;

  final preguntasRecientes = [
    'Dolor de muela',
    'Dolor de estomago',
    'Dolor de cabeza'
  ];
  //////////////////////////////////////////
  ///
  ///
  void getDatos() async{
    this.objSintomas = await InfermedicaDiagnosisProvider().getConditions();
    this.preguntas = new List();
    this.ids = new List();
    objSintomas.forEach((element) {
      preguntas.add(element[0]);
      ids.add(element[1]);
    });
    print(preguntas);
    print(ids);    
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        }
      )

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:  AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ), 
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //son las sugerencias cuando la persona escribe
    getDatos();
    
    final listaSugerida =  (query.isEmpty)?
                            preguntasRecientes
                          : preguntas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();
    


    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text(listaSugerida[i]),
          onTap: (){
            int n =  preguntas.lastIndexOf(listaSugerida[i]);
            print(ids[n]);                        
          },
        );
      },
    );
  }
}
