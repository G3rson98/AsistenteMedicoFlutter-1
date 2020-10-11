import 'package:asistentemedico/src/models/usuario_model.dart';
import 'package:asistentemedico/src/services/usuario_service.dart';
import 'package:flutter/material.dart';


class RegistrarUsuario extends StatefulWidget {
  RegistrarUsuario({Key key}) : super(key: key);

  @override
  _RegistrarUsuarioState createState() => _RegistrarUsuarioState();
}

class _RegistrarUsuarioState extends State<RegistrarUsuario> {

  final formRegKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
            padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Regístrate',
                  style: TextStyle(color: Color.fromRGBO(36, 247, 188, 1.0), fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: _registerForm(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _crearCorreo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'daniel@gmail.com',
          labelText: 'Correo electrónico'
        ),
        // onSaved: (value) => usuario.correo = value,
      ),
    );
  
  }

  Widget _crearUsuario(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Usuario',
          labelText: 'Nombre de usuario'
        ),
        // onSaved: (value) => usuario.correo = value,
      ),
    );
  }

  Widget _crearNombre(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Daniel',
          labelText: 'Nombre'
        ),
        // onSaved: (value) => usuario.correo = value,
      ),
    );
  }

  Widget _crearApellidoP(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Robles',
          labelText: 'Apellido paterno'
        ),
        // onSaved: (value) => usuario.correo = value,
      ),
    );
  }

  Widget _crearApellidoM(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Alpire',
          labelText: 'Apellido materno'
        ),
        // onSaved: (value) => usuario.correo = value,
      ),
    );
  }

    Widget _crearPassword(){
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Color.fromRGBO(36, 247, 188, 1.0)),
          labelText: 'Contraseña',
        ),
        // onSaved: (value) => usuario.password = value,
      ),
    );
  
  }

  Widget _crearBoton( BuildContext context ){

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Enviar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Color.fromRGBO(36, 196, 249, 1.0),
      textColor: Colors.white,
      onPressed: () {},
      // onPressed: (_bloquearBoton) ? null : _submit,
      //()=> Navigator.pushNamed(context, 'home')
    );

  }

  Widget _registerForm(){

    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
          SizedBox(height: 10.0),
          Form(
            key: formRegKey,
            child:Column(
              children: <Widget> [
                _crearCorreo(),
                _crearUsuario(),
                _crearNombre(),
                _crearApellidoP(),
                _crearApellidoM(),
                _crearPassword(),
                SizedBox(height: 30.0),
                _crearBoton(context),    
              ],
            ) ,
          ),
        ],
      ),
    );

  }

}