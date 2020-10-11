import 'package:asistentemedico/src/models/diagnosis_query_model.dart';
import 'package:asistentemedico/src/pages/results_page.dart';
import 'package:asistentemedico/src/providers/infermedica_provider.dart';
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
  final infermedicaDiagnosisProvider = new InfermedicaDiagnosisProvider();
  int number;

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
            Padding(padding: EdgeInsets.all(20), child: _cardTipo1(widget.question)),
            SizedBox(height: 30),
            RaisedButton(
              color: Color.fromRGBO(145,220, 201, 1.0),
              child: Text("Listo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  number = widget.numberOfQuery + 1,
                  for (var item in responses.question.items) {
                    respuestas.add(item.toJson()),
                  },
                  if((number >= 20) || (responses.conditions[0].probability > 0.98)){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context)  =>  ResultPage(listcondition: responses.conditions)
                      )
                    ),
                  }else{
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context)  =>  QuestionWidget(listEvidence: widget.listEvidence, question: responses.question.text, posibleAnswers: respuestas, numberOfQuery: number)
                      )
                    ),
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
          Text(question, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
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