import 'dart:ui';

import 'package:asistentemedico/src/models/diagnosis_model.dart';
import 'package:asistentemedico/src/models/diagnosis_query_model.dart';
import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:asistentemedico/src/models/translate_model.dart';
import 'package:asistentemedico/src/pages/results_page.dart';
import 'package:asistentemedico/src/providers/diagnosis_provider.dart';
import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:asistentemedico/src/providers/translate_provider.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final List<Evidence> listEvidence;
  final String question;
  final List<dynamic> posibleAnswers;
  final int numberOfQuery;
  const QuestionWidget({Key key, @required this.listEvidence, @required this.question, @required this.posibleAnswers, @required this.numberOfQuery}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String selectedRadioTile;
  List<dynamic> respuestas = [];
  List<Condition> enfermedades = [];
  final infermedicaDiagnosisProvider = new InfermedicaDiagnosisProvider();
  int number;
  // TranslateModel translateModel;
  final translateProvider = new TranslateProvider();
  DiagnosisModel diagnosisModel = new DiagnosisModel();
  final diagnosisProvider = new DiagnosisProvider();

  /*--- */
  String newQuestion = "";

  setSelectedRadioTile(String valor){
    setState(() {
      selectedRadioTile = valor;
    });
  }

  // void translateQuestion(String question) async{
  //   this.translateModel = await translateProvider.getTranslation(question);
  //   this.newQuestion = translateModel.data.translations[0].translatedText;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // here the desired height
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromRGBO(36, 247, 188,1.0),
                Color.fromRGBO(36, 196, 249, 1.0),
              ]
            ),      
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Confirmar diagnóstico',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),      
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Padding(padding: EdgeInsets.all(20), child: _cardTipo1(newQuestion)),
            SizedBox(height: 30),
            RaisedButton(
              color: Color.fromRGBO(145,220, 201, 1.0),
              child: Text("Listo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: (){
                if (widget.posibleAnswers.length == 1) {
                  Evidence evidence = new Evidence();
                  evidence.id =widget.posibleAnswers[0]["id"];
                  print("illness" + evidence.id);
                  if (selectedRadioTile == '1' ) {
                    evidence.choiceId = "present";
                  }else if(selectedRadioTile == '2' ){
                    evidence.choiceId = "absent";
                  }else if(selectedRadioTile == '3' ){
                    evidence.choiceId = "unknown";
                  }else{
                    evidence.choiceId = "unknown";
                  }
                  widget.listEvidence.add(evidence);
                }else{
                  Evidence evidence = new Evidence();
                  evidence.id = selectedRadioTile;
                  evidence.choiceId = "present";
                  widget.listEvidence.add(evidence);
                }

                DiagnosisQuery diagnosisQuery = new DiagnosisQuery();
                diagnosisQuery.age = 30;
                diagnosisQuery.sex = "male";
                diagnosisQuery.evidence = widget.listEvidence;
                List<DiagnosisModel> listDiagnosisModel = [];

                infermedicaDiagnosisProvider.sendCondition(diagnosisQuery).then((responses) => {
                  number = widget.numberOfQuery + 1,
                  enfermedades = responses.conditions,

                  for (var item in responses.question.items) {
                    respuestas.add(item.toJson()),
                  },

                  if((number >= 2) || (responses.conditions[0].probability > 0.98)){

                    for (var i = 0; i < enfermedades.length; i++) {
                      translateProvider.getTranslation(enfermedades[i].name).then((enfermedadSpanish) => {

                        enfermedades[i].name = enfermedadSpanish,
                        diagnosisModel.nombreEnfermedad = enfermedadSpanish,
                        diagnosisModel.probabilidad = enfermedades[i].probability,
                        diagnosisModel.idConsulta = "ill1_"  + DateTime.now().millisecondsSinceEpoch.toString(),
                        diagnosisModel.usuarioId = '1',
                        diagnosisModel.idEnfermedad = enfermedades[i].id,
                        listDiagnosisModel.add(diagnosisModel),
                        diagnosisProvider.createDiagnosis(diagnosisModel),

                        if ((i+1) == enfermedades.length) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context)  =>  ResultPage(listDiagnosisModel: listDiagnosisModel)
                            )
                          ),
                        }
                        
                      })
                    },

                  }else{
                    translateProvider.getTranslation(responses.question.text).then((questionSpanish) => {
                      for (var i = 0; i < respuestas.length; i++) {
                        translateProvider.getTranslation(respuestas[i]["name"]).then((value) => {
                          respuestas[i]["name"] = value,
                          if ((i+1) == respuestas.length) {
                            Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context)  =>  QuestionWidget(listEvidence: widget.listEvidence, question: questionSpanish, posibleAnswers: respuestas, numberOfQuery: number)
                                )
                            ),
                          }
                        }),
                      },
                    })
                  }
                });
                // print(widget.userConditionsList);
              }),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  List<Widget> createRadioListAnswer(){
    List<Widget> radioWidgets = [];
    if (widget.posibleAnswers.length == 1) {
      Widget rb1 = RadioListTile(
                    value: "1", 
                    groupValue: selectedRadioTile, 
                    title: Text("Si"),
                    onChanged: (valor){
                      print("Radio pressed: $valor");
                      setSelectedRadioTile(valor);
                    },
                  );
      radioWidgets.add(rb1);
      Widget rb2 = RadioListTile(
                    value: "2", 
                    groupValue: selectedRadioTile, 
                    title: Text("No"),
                    onChanged: (valor){
                      print("Radio pressed: $valor");
                      setSelectedRadioTile(valor);
                    },
                  );
      radioWidgets.add(rb2);
      Widget rb3 = RadioListTile(
                    value: "3", 
                    groupValue: selectedRadioTile, 
                    title: Text("No sé"),
                    onChanged: (valor){
                      print("Radio pressed: $valor");
                      setSelectedRadioTile(valor);
                    },
                  );
      radioWidgets.add(rb3);
    }else{
      for (var answer in widget.posibleAnswers) {
        radioWidgets.add(
          RadioListTile(
            value: answer["id"], 
            groupValue: selectedRadioTile, 
            title: Text(answer["name"]),
            onChanged: (valor){
              print("Radio pressed: $valor");
              setSelectedRadioTile(valor);
            },
          ),
        );
      }
    }
    return radioWidgets;
  }
  
  Widget _cardTipo1(String question){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          ListTile(
            leading: Icon(Icons.ac_unit, color: Colors.blue, size: 80.0),
            title: Text('PREGUNTA: ', style: TextStyle(color: Colors.black,fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.question, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 50),
          Column(
            children: createRadioListAnswer(),
          ),
          SizedBox(height: 30),
          ],
        ),
    );
  }
}