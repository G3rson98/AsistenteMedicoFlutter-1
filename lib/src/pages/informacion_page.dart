import 'package:flutter/material.dart';

class InformacionPage extends StatefulWidget {
  InformacionPage({Key key}) : super(key: key);

  @override
  _InformacionPageState createState() => _InformacionPageState();
}

class _InformacionPageState extends State<InformacionPage> {

  final estiloTexto1 = TextStyle(fontSize: 16.0);
  final estiloTexto2 = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final estiloTexto3 = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          _crearFondo(),
          _crearTitulo(), 
          _crearAccion(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
        ],
        ),
      ),
    );
  }

  Widget _crearFondo(){
    return Image(
            image: NetworkImage('https://mobisoftinfotech.com/resources/wp-content/uploads/2018/07/medical_diagnosis_apps_on_demand_healthcare_blog_banner_image_mobisoft_infotech.png')
    );
  }

  Widget _crearTitulo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
      child: Row(
        children: <Widget>[
          
          Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Diagnóstico: ', style: estiloTexto1),
                Text('Coronavirus (COVID-19) ', style: estiloTexto2),
                SizedBox( height: 10.0),
                Text('Enfermedad de moda', style: estiloTexto3),
              ],
            ),
          ),
          Icon(Icons.assessment, color: Colors.red, size: 30.0), 
          Text('89%', style: TextStyle(fontSize: 20.0),)
        ],
      ),
    );
  }

  Widget _crearAccion(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _accion(Icons.call, 'CALL'),
         _accion(Icons.map, 'MAPS'),
         _accion(Icons.share, 'SHARE')
        ],
      ),
    );
  }

  Widget _accion(IconData icon,String texto){
    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.lightBlue,size: 40.0),
        SizedBox(height: 5.0,),
        Text(texto, style: TextStyle(color: Colors.lightBlue, fontSize: 15.0))
      ],
    );
  }

  Widget _crearTexto(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Text(
        'La COVID-19 afecta de distintas maneras en función de cada persona. La mayoría de las personas que se contagian presentan síntomas de intensidad leve o moderada, y se recuperan sin necesidad de hospitalización.La COVID-19 afecta de distintas maneras en función de cada persona. La mayoría de las personas que se contagian presentan síntomas de intensidad leve o moderada',
        textAlign: TextAlign.justify,
        style: TextStyle(),
      ),
    );
  }
}