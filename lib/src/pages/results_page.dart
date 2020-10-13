import 'package:asistentemedico/src/models/diagnosis_model.dart';
import 'package:asistentemedico/src/providers/infermedica_provider.dart';
import 'package:asistentemedico/src/widget/confirm_illness_widget.dart';
import 'package:asistentemedico/src/widget/information_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatefulWidget {
  // final List<Condition> listcondition;
  final List<DiagnosisModel> listDiagnosisModel;
  ResultPage({Key key, @required this.listDiagnosisModel}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final infermedicaProvider = new InfermedicaDiagnosisProvider();
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
                  
                  Column(
                    children: createRadioListAnswer(),

                  ),
                  RaisedButton(
                    child: Text('Confirmar diagnóstico'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmIllnessWidget(
                                  listCondition: widget.listDiagnosisModel)));
                    },
                  )
                ],
              )),
        ));
  }


  List<Widget> createRadioListAnswer(){
    List<Widget> radioWidgets = [];
    for (var i = 0; (i < widget.listDiagnosisModel.length) ; i++) {  
      if(i==3){
        break;
      }        
      radioWidgets.add(
        _cardTipo1(widget.listDiagnosisModel[i].nombreEnfermedad, (widget.listDiagnosisModel[i].probabilidad*100).toString(), widget.listDiagnosisModel[i].idEnfermedad)
      );
    }
    return radioWidgets;
  }

  List<dynamic> armarLista() {
    print(widget.listDiagnosisModel.length);
    List<dynamic> list= new List();
    for (var i = 0; i < widget.listDiagnosisModel.length || i <= 3; i++) {
      list.add(widget.listDiagnosisModel[i]);
    }
    return list;
  }

  Widget _cardTipo1(String enfermedad, String certeza, String id) {
    return Card(
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
                onPressed: () {
                  print(id);
                  infermedicaProvider.getInformation(id).then((information) => {
                    print(information),
                    Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context)  =>  InformationWidget(informationModel: information)
                          )
                    )
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
