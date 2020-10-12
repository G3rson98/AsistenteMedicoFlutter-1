import 'package:asistentemedico/src/pages/alergia_page.dart';
import 'package:flutter/material.dart';

class AlergiaSearch extends SearchDelegate{

  List<String> alergias = ['Alergia al polvo','Alergia al polen','Alergia a las aves','Alergia a los acaros'];

  List<String> misAlergias = [];

  
  List<Widget> createRadioListAnswer(){
    List<Widget> radioWidgets = [];
    for (var i = 0; (i < misAlergias.length) ; i++) {  
      
      radioWidgets.add(
        _cardTipo1(misAlergias[i], 'Usted tiene alergia')
      );
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
  //////////////////////////
  ///
  ///
  ///
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.check_box),
        onPressed: (){
          Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context)  =>  AlergiasPage(misAlergias: misAlergias,)
                      )
          );

          //MaterialPageRoute(builder: (context)  =>  AlergiasPage(misAlergias: ['alergia']))
          // print(misAlergias);
          // close(context, AlergiasPage(misAlergias: ['null']));
        }
      ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
          misAlergias= [];
          showResults(context);
        }
      ),      
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
        close(context, this.misAlergias);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Column(
        children: createRadioListAnswer(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     final listaSugerida =  (query.isEmpty)?
                            []
                          : alergias.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();
    
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text(listaSugerida[i]),
          onTap: (){
            query = '';
            this.misAlergias.add(listaSugerida[i]);
            showResults(context);
          },
        );
      },
    );
  }

}
