import 'package:asistentemedico/src/models/diagnosis_query_model.dart';
import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final List<Evidence> listEvidence;
  final String question;
  final List<dynamic> posibleAnswers;
  const QuestionWidget({Key key, @required this.listEvidence, @required this.question, @required this.posibleAnswers}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String selectedRadioTile;
  List<dynamic> respuestas = [];
  final infermedicaDiagnosisProvider = new InfermedicaDiagnosisProvider();

  setSelectedRadioTile(String valor){
    setState(() {
      selectedRadioTile = valor;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0), // here the desired height
          child: AppBar(
            backgroundColor: Color.fromRGBO(102, 255, 179, 1.0),
          )
        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(widget.question),
            Column(
              children: createRadioListAnswer(),
            ),
            RaisedButton(
              child: Text("Enviar"),
              onPressed: (){
                Evidence evidence = new Evidence();
                evidence.id = selectedRadioTile;
                evidence.choiceId = "present";
                widget.listEvidence.add(evidence);
                DiagnosisQuery diagnosisQuery = new DiagnosisQuery();
                diagnosisQuery.age = 30;
                diagnosisQuery.sex = "male";
                diagnosisQuery.evidence = widget.listEvidence;
                infermedicaDiagnosisProvider.sendCondition(diagnosisQuery).then((responses) => {
                  for (var item in responses.question.items) {
                    respuestas.add(item.toJson()),
                  },
                  print(respuestas),
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)  =>  QuestionWidget(listEvidence: widget.listEvidence, question: responses.question.text, posibleAnswers: respuestas)
                    )
                  )
                });
                // print(widget.userConditionsList);
              })
          ],
        ),
      ),
    );
  }

  List<Widget> createRadioListAnswer(){
    List<Widget> radioWidgets = [];
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
    return radioWidgets;
  }

}