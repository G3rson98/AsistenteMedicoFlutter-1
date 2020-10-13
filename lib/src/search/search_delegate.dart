import 'package:asistentemedico/src/models/diagnosis_query_model.dart';
import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:asistentemedico/src/providers/translate_provider.dart';
import 'package:asistentemedico/src/widget/question_condition_widget.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  ////////////////////////////////////////////////////
  ///
  ///
  ///
  int number = 1;
  List preguntas ;
  List ids;
  List objSintomas;
  List<Evidence> evid=[];
  final infermedicaDiagnosisProvider = new InfermedicaDiagnosisProvider();
  List<dynamic> respuestas = [];

  final preguntasRecientes = [
    'Dolor de muela',
    'Dolor de estomago',
    'Dolor de cabeza'
  ];

  final translateProvider = new TranslateProvider();

  List<String> preguntasEs;
  //////////////////////////////////////////
  ///
  ///
  void getDatos() async{
    this.objSintomas = await InfermedicaDiagnosisProvider().getConditions();
    this.preguntas = new List();
    this.ids = new List();

    this.preguntasEs = new List();// lista en español

    objSintomas.forEach((element) {
      
      preguntas.add(element[0]);
      ids.add(element[1]);
    });

    traducir();
    // print(preguntas);
    // print(ids);    
  }

  void traducir() async{
      String a= '';
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
    // preguntas.forEach((element) {
    //   translateProvider.getTranslation(element).then((value) {
    //     this.preguntasEs.add(value);
    //   });
    // });
    
    final listaSugerida =  (query.isEmpty)?
                            preguntasRecientes
                          : preguntas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();
        // final listaSugerida =  (query.isEmpty)?
        //                     preguntasRecientes
        //                   : 
        //                   preguntasEs.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
        //                   ).toList();


    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text(listaSugerida[i]),
          onTap: (){
            int n =  preguntas.lastIndexOf(listaSugerida[i]);
            print(ids[n]);  
            Evidence evidence = new Evidence();
            evidence.id=ids[n];
            evidence.choiceId = "present";
            this.evid.add(evidence);

            DiagnosisQuery diagnosisQuery = new DiagnosisQuery();
            diagnosisQuery.age = 30;
            diagnosisQuery.sex = "male";
            diagnosisQuery.evidence = this.evid;

            infermedicaDiagnosisProvider.sendCondition(diagnosisQuery).then((responses) => {
              for (var item in responses.question.items) {
                    respuestas.add(item.toJson()),
              },
              translateProvider.getTranslation(responses.question.text).then((questionSpanish) => {
                      for (var i = 0; i < respuestas.length; i++) {
                        translateProvider.getTranslation(respuestas[i]["name"]).then((value) => {
                          respuestas[i]["name"] = value,
                          if ((i+1) == respuestas.length) {
                            Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context)  =>  QuestionWidget(listEvidence: this.evid, question: questionSpanish, posibleAnswers: respuestas, numberOfQuery: number)
                                )
                            ),
                          }
                        }),
                      },
                    })
            });
            
          },
        );
      },
    );
  }
}
