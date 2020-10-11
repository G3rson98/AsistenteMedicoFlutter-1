import 'package:asistentemedico/src/models/diagnosis_response_model.dart';
import 'package:flutter/material.dart';

class ConfirmIllnessWidget extends StatefulWidget {
  const ConfirmIllnessWidget({Key key, @required this.listCondition}) : super(key: key);
  final List<Condition> listCondition;

  @override
  _ConfirmIllnessWidgetState createState() => _ConfirmIllnessWidgetState();
}

class _ConfirmIllnessWidgetState extends State<ConfirmIllnessWidget> {
  String selectedRadioTile;

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
              _cardTipo1(),
              SizedBox(height: 30),
            ],
          )
        ),
    );
  }

  Widget _cardTipo1(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          ListTile(
            leading: Icon(Icons.account_box, color: Colors.blue, size: 80.0),
            title: Text('PREGUNTA: ', style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text('¿Usted está conforme con los resultados? Por favor, indique el diagnóstico correcto solo si antes lo ha verificado con un médico.'),
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
                  onPressed: (){},
                ),
                FlatButton(
                  child: Text('Confirmar'),
                  onPressed: (){
                    print("Confirma enfermedad " + selectedRadioTile);
                  },
                ),
                
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
    );
  }

  List<Widget> createRadioListAnswer(){
    List<Widget> radioWidgets = [];
    for (var condition in widget.listCondition) {
      radioWidgets.add(
        RadioListTile(
          value: condition.id, 
          groupValue: selectedRadioTile, 
          title: Text(condition.name),
          subtitle: Text(condition.commonName),
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