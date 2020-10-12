import 'package:asistentemedico/src/models/usuario_model.dart';
import 'package:asistentemedico/src/services/usuario_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final usuarioProvider = new UsuarioProvider();

  bool _bloquearBoton = false;

  Usuario usuario = new Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 215.0,
            ),
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
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingreso',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                SizedBox(height: 30.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      _crearUsuario(),
                      SizedBox(height: 10.0),
                      _crearPassword(),
                      SizedBox(height: 50.0),
                      _crearBoton(context)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearUsuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        initialValue: 'joaquin@gmail.com',
        decoration: InputDecoration(
            icon: Icon(Icons.alternate_email,
                color: Color.fromRGBO(36, 247, 188, 1.0)),
            hintText: 'daniel@gmail.com',
            labelText: 'Correo electrónico'),
        onSaved: (value) => usuario.correo = value,
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        initialValue: '123456',
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Color.fromRGBO(36, 247, 188, 1.0)),
          labelText: 'Contraseña',
        ),
        onSaved: (value) => usuario.password = value,
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Color.fromRGBO(36, 196, 249, 1.0),
      textColor: Colors.white,
      onPressed: (_bloquearBoton) ? null : _submit,
      //()=> Navigator.pushNamed(context, 'home')
    );
  }

  void _submit() async{

    print(_bloquearBoton);

    formKey.currentState.save();

    print(usuario.correo);
    print(usuario.password);

    setState(() {
      _bloquearBoton = true;
    });

    print(_bloquearBoton);

    var login = usuarioProvider.validarLogin(usuario);
    
    if( await login ){
      setState(() {
        _bloquearBoton = true;
      });
      Navigator.pushReplacementNamed(context, 'begin');
      // Navigator.pushNamed(context, 'home');
    }else{
      setState(() {
        _bloquearBoton = true;
      });
      mostrarSnackbar('Credenciales incorrectas, intente de nuevo', Color.fromRGBO(36, 196, 249, 1.0));
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(36, 196, 249, 1.0),
        Color.fromRGBO(36, 247, 188, 1.0)
      ])),
    );

    final circulo = Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.08),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -40.0, right: -5.0, child: circulo),
        Positioned(bottom: 100.0, right: 10.0, child: circulo),
        Positioned(bottom: -30.0, left: -10.0, child: circulo),
        Container(
          height: 300.0,
          width: 500.0,
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.local_hospital, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Asistente Médico',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  void mostrarSnackbar(String mensaje, Color colorBG) {
    final snackbar = SnackBar(
      content: Text(mensaje, style: TextStyle(color: Colors.white)),
      duration: Duration(milliseconds: 1500),
      backgroundColor: colorBG,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
