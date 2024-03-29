import 'package:flutter/material.dart';



class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);

  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView( // PageView: Sirve para pasar de una pagina a otra, por defecto se mueven las páginas en forma horizontal. 
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(), 
          _pagina2(context)
        ],
      ),
    );
  }

  Widget _pagina1(){
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(), 
        _texto(),
      ],
    );
  }

  Widget _colorFondo(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      //color: Color.fromRGBO(150, 188, 200, 1.0),
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
    );
  }

  Widget _imagenFondo(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/fondoScroll.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _texto(){
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 45.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('13/10/20', style: estiloTexto),
            Text('Martes', style: TextStyle(fontSize: 20.0, color: Colors.white)),
            SizedBox(height: 100.0),
            Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white)
          ],
        ),
      ],
    );
  }

  Widget _pagina2(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _colorFondo(),
          _bienvenida(context),
        ],
      )
    );
  }

  Widget _bienvenida(BuildContext context){
    return Align(
            alignment: Alignment.bottomCenter,
            child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100.0),
              Image(
                image: AssetImage('assets/logo.png'),
                height: 80.0,
                width: 80.0,
                color: Colors.white,
              ),
              SizedBox(height: 5.0),
              Text(
                'Asistente médico', 
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.white,
                textColor: Colors.grey[700],
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0))
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'login');
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.white,
                textColor: Colors.grey[700],
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Text('Registrarse', style: TextStyle(fontSize: 20.0))
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'registrarUsuario');
                },
              ),
              SizedBox(height: 100.0)
            ],
          ),
        );
  }

}