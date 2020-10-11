import 'package:asistentemedico/src/models/usuario_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UsuarioModel usuario = new UsuarioModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          perfilForm(context),
        ],
      ),
    );
  }

  Widget perfilForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 60.0),
            // padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: <Widget>[
                Text('Mi Perfil',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                SizedBox(height: 30.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      _crearUsuario(),
                      SizedBox(height: 10.0),
                      _crearNombre(),
                      SizedBox(height: 10.0),
                      _crearApellidoPaterno(),
                      SizedBox(height: 10.0),
                      _crearApellidoMaterno(),
                      SizedBox(height: 10.0),
                      _crearCorreo(),
                      // SizedBox(height: 50.0),
                      // _crearPassword(),
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
        decoration: InputDecoration(
            icon: Icon(Icons.account_circle,
                color: Color.fromRGBO(251, 196, 107, 1.0)),
            hintText: 'Usuario',
            labelText: 'Nombre de usuario'),
        onSaved: (value) {
          print('value: ' + value);
          this.usuario.nombreUsuario = value;
        },
      ),
    );
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.person_outline,
                color: Color.fromRGBO(251, 196, 107, 1.0)),
            hintText: 'nombre',
            labelText: 'Nombre'),
        onSaved: (value) {
          print('value: ' + value);
          this.usuario.nombre = value;
        },
      ),
    );
  }

  Widget _crearApellidoPaterno() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.arrow_right,
                color: Color.fromRGBO(251, 196, 107, 1.0)),
            hintText: 'apellido',
            labelText: 'Apellido Paterno'),
        onSaved: (value) {
          print('value: ' + value);
          this.usuario.apellidoPaterno = value;
        },
      ),
    );
  }

  Widget _crearApellidoMaterno() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.arrow_right,
                color: Color.fromRGBO(251, 196, 107, 1.0)),
            hintText: 'apellido',
            labelText: 'Apellido Materno'),
        onSaved: (value) {
          print('value: ' + value);
          this.usuario.apellidoMaterno = value;
        },
      ),
    );
  }

  Widget _crearCorreo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        // obscureText: true,
        // enableInteractiveSelection: false,
        enabled: false,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email,
              color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Correo',
        ),
        onSaved: (value) {
          print('value: ' + value);
          this.usuario.correo = value;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Contraseña',
        ),
        onSaved: (value) {
          print('value: ' + value);
        },
      ),
    );
  }

  Widget _crearFechaNac() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Contraseña',
        ),
        onSaved: (value) {
          print('value: ' + value);
        },
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Guardar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Color.fromRGBO(255, 0, 202, 1.0),
      textColor: Colors.white,
      onPressed: _submit,
      //()=> Navigator.pushNamed(context, 'home')
    );
  }

  void _submit() async {
    // formKey.currentState.save();
    // var login = delegadoProvider.validarLogin(delegado);

    // if (await login) {
    //   Navigator.pushReplacementNamed(context, 'home');
    //   // Navigator.pushNamed(context, 'home');
    // } else {
    //   mostrarSnackbar('Credenciales incorrectas, intente de nuevo',
    //       Color.fromRGBO(255, 0, 202, 1.0));
    // }
  }
}
