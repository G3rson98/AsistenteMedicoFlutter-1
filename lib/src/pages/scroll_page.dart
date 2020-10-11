import 'package:flutter/material.dart';
import 'package:asistentemedico/src/pages/home_page.dart';


class ScrollPage extends StatefulWidget {
  ScrollPage({Key key}) : super(key: key);

  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            Text('24/07/20', style: estiloTexto),
            Text('Viernes', style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
    return SafeArea(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),
            Image(
              image: AssetImage('assets/logo.png'),
              height: 80.0,
              width: 80.0,
            ),
            SizedBox(height: 5.0),
            Text(
              'Asistente médico', 
              style: TextStyle(color: Colors.blue, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            //aqui
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blue,
              textColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Text('Bienvenidos', style: TextStyle(fontSize: 20.0))
              ),
              onPressed: (){
                Navigator.pushNamed(context, 'begin');
              },
            ),
            SizedBox(height: 150.0)
          ],
        ),
      ),
    );
  }

  //MI PARTE LOGIN
  Widget _loginForm(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [

          SafeArea(
            child: Container(
              height: 215.0,
            ) ,
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget> [
                Text('Ingreso', style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                SizedBox(height: 30.0),
                Form(
                  key: formKey,
                  child:Column(
                    children: <Widget> [
                      _crearUsuario(),
                      SizedBox(height: 10.0),
                      _crearPassword(),
                      SizedBox(height: 50.0),
                      _crearBoton( context )
                    ],
                  ) ,
                ),
              ],
            ),
          )
        ],
      ),
    );

  }

  Widget _crearUsuario(){
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle, color: Color.fromRGBO(251, 196, 107, 1.0)),
          hintText: 'Usuario',
          labelText: 'Nombre de usuario'
        ),
        // onSaved: (value) => delegado.usuario = value,
      ),
    );
  
  }

    Widget _crearPassword(){
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Contraseña',
        ),
        // onSaved: (value) => delegado.contrasena = value,
      ),
    );
  
  }

  Widget _crearBoton( BuildContext context ){

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Color.fromRGBO(255, 0, 202, 1.0),
      textColor: Colors.white,
      onPressed: _submit,
      //()=> Navigator.pushNamed(context, 'home')
    );

  }

  void mostrarSnackbar (String mensaje, Color colorBG){
    final snackbar = SnackBar(
      content: Text( mensaje, style: TextStyle(color: Colors.white) ),
      duration: Duration( milliseconds: 1500 ),
      backgroundColor: colorBG,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }

  void _submit() async{

    formKey.currentState.save();

    // print( delegado.usuario );
    // print( delegado.contrasena );

    // var login = delegadoProvider.validarLogin(delegado);
    
    // if( await login ){
    //   Navigator.pushReplacementNamed(context, 'home');
    //   // Navigator.pushNamed(context, 'home');
    // }else{
    //   mostrarSnackbar('Credenciales incorrectas, intente de nuevo', Color.fromRGBO(255, 0, 202, 1.0));
    // }
  }
  //FIN MI PARTE LOGIN
}