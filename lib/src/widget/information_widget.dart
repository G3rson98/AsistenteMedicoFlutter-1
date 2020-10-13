import 'package:asistentemedico/src/models/information_model.dart';
import 'package:flutter/material.dart';

class InformationWidget extends StatefulWidget {
  final InformationModel informationModel;
  InformationWidget({Key key, @required this.informationModel}) : super(key: key);

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white70,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _cuerpo(),
            ),

          )
        ],
      ),
    );
    
      
  }

  Widget _cuerpo(){
    return Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        Text("Datos de la enfermedad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: FadeInImage(
              placeholder: NetworkImage("https://cdn.pixabay.com/photo/2017/10/08/19/55/cruz-2831364_960_720.png"), 
              image: NetworkImage("https://cdn.pixabay.com/photo/2017/10/08/19/55/cruz-2831364_960_720.png")),
            maxRadius: 70.0,
            minRadius: 30.0,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputId(),
        ),
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputName(),
        ),
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputSex(),
        ),
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputPrevalesencia(),
        ),
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputSevero(),
        ),
        Divider(height: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _crearInputConsejo(),
        ),
        RaisedButton(
          child: Text("Atrás"),
          color: Color.fromRGBO(36, 196, 249, 1.0),
          onPressed: (){
            Navigator.pop(context);
          }
        )
      ],
    );
  }

  Widget _crearInputId() {
    TextEditingController _contrato = new TextEditingController(text: widget.informationModel.id);
    return TextField(
      controller: _contrato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Identificador de enfermedad',
        labelText: 'Identificador de enfermedad',
        helperText: 'Identificador de enfermedad',
        suffixIcon: Icon(Icons.insert_drive_file), //Icono que va dentro de un input 
        icon: Icon(Icons.insert_drive_file),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }

  Widget _crearInputName() {
    TextEditingController _nombre = new TextEditingController(text:widget.informationModel.name);
    return TextField(
      controller: _nombre,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Nombre',
        labelText: 'Nombre',
        helperText: 'Nombre',
        suffixIcon: Icon(Icons.person), //Icono que va dentro de un input 
        icon: Icon(Icons.person),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }

  Widget _crearInputSex() {
    TextEditingController _ci = new TextEditingController(text: widget.informationModel.sexFilter);
    return TextField(
      controller: _ci,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Sexo',
        labelText: 'Sexo',
        helperText: 'Filtro por sexo',
        suffixIcon: Icon(Icons.info), //Icono que va dentro de un input 
        icon: Icon(Icons.info),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }

  Widget _crearInputPrevalesencia() {
    TextEditingController _contrato = new TextEditingController(text: widget.informationModel.prevalence);
    return TextField(
      controller: _contrato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Prevalesencia',
        labelText: 'Prevalesencia',
        helperText: 'Prevalesencia',
        suffixIcon: Icon(Icons.insert_drive_file), //Icono que va dentro de un input 
        icon: Icon(Icons.insert_drive_file),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }

    Widget _crearInputSevero() {
    TextEditingController _contrato = new TextEditingController(text: widget.informationModel.severity);
    return TextField(
      controller: _contrato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Severo',
        labelText: 'Severo',
        helperText: 'Severo',
        suffixIcon: Icon(Icons.insert_drive_file), //Icono que va dentro de un input 
        icon: Icon(Icons.insert_drive_file),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }

  Widget _crearInputConsejo() {
    TextEditingController _contrato = new TextEditingController(text: widget.informationModel.extras.hint);
    return TextField(
      controller: _contrato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide(color: Colors.green)
        ),
        hintText: 'Consejo',
        labelText: 'Consejo',
        helperText: 'Consejo',
        suffixIcon: Icon(Icons.insert_drive_file), //Icono que va dentro de un input 
        icon: Icon(Icons.insert_drive_file),
        labelStyle: TextStyle(color: Colors.green)
      ),
    );

  }
}