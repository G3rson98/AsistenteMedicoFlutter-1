import 'package:asistentemedico/src/models/diagnosis_model.dart';
import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:asistentemedico/src/providers/translate_provider.dart';
import 'package:flutter/material.dart';

class ConfirmIllnessWidget extends StatefulWidget {
  const ConfirmIllnessWidget({Key key, @required this.listCondition})
      : super(key: key);
  final List<DiagnosisModel> listCondition;

  @override
  _ConfirmIllnessWidgetState createState() => _ConfirmIllnessWidgetState();
}

class _ConfirmIllnessWidgetState extends State<ConfirmIllnessWidget> {
  String selectedRadioTile;
  final translateProvider = new TranslateProvider();

  setSelectedRadioTile(String valor) {
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
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 50.0,),
              new Text(
                'Confirmar diagnóstico',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 50.0),
              Align(
                alignment: Alignment.centerRight,
                  child: Container(
                      child: IconButton(
                          icon: Icon(Icons.home), onPressed: () {
                            Navigator.of(context).pushNamed('begin');
                          })))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          _cardTipo1(),
          SizedBox(height: 30),
        ],
      )),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          ListTile(
            leading: Icon(Icons.account_box, color: Colors.blue, size: 80.0),
            title: Text('PREGUNTA: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(
                '¿Usted está conforme con los resultados? Por favor, indique el diagnóstico correcto solo si antes lo ha verificado con un médico.'),
          ),
          SizedBox(height: 50),
          Column(
            children: createRadioListAnswer(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pushNamed('begin');
                },
              ),
              FlatButton(
                child: Text('Confirmar'),
                onPressed: () {
                  translateProvider.getTranslation("Hi my name is Daniel");
                  alertaSuccess(context);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  List<Widget> createRadioListAnswer() {
    List<Widget> radioWidgets = [];
    for (var condition in widget.listCondition) {
      radioWidgets.add(
        RadioListTile(
          value: condition.idEnfermedad,
          groupValue: selectedRadioTile,
          title: Text(condition.nombreEnfermedad),
          subtitle: Text(condition.probabilidad.toString()),
          onChanged: (valor) {
            print("Radio pressed: $valor");
            setSelectedRadioTile(valor);
          },
        ),
      );
    }
    return radioWidgets;
  }

  void alertaSuccess(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) { 
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
          title: Text('Alerta: '),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(
                  image: NetworkImage("https://www.pngkit.com/png/full/12-120360_check-mark-right-and-wrong-signs-png.png"),
                  height: 90,
                  width: 90,
                ),
                SizedBox(height: 5),
                Text("Se registró correctamente el diagnóstico. ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: (){
                Navigator.of(context).pushNamed('begin');
                
              },
            ),
          ],
        );
      }
    );
  }
}
