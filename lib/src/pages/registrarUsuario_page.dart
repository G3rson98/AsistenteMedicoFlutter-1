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
  final scaffoldKeyRegUser = GlobalKey<ScaffoldState>();
  final usuarioProvider = new UsuarioProvider();

  String _value = 'Femenino';
  bool _bloquearBoton = false;
  Usuario usuario = new Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyRegUser,
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
        onSaved: (value) => usuario.correo = value,
      ),
    );
  
  }

  Widget _crearUsuario(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Usuario',
          labelText: 'Nombre de usuario'
        ),
        onSaved: (value) => usuario.nombreUsuario = value,
      ),
    );
  }

  Widget _crearNombre(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Daniel',
          labelText: 'Nombres'
        ),
        onSaved: (value) => usuario.nombre = value,
      ),
    );
  }

  Widget _crearApellidoP(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Robles',
          labelText: 'Apellido paterno'
        ),
        onSaved: (value) => usuario.apellidoPaterno = value,
      ),
    );
  }

  Widget _crearApellidoM(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.done, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'Alpire',
          labelText: 'Apellido materno'
        ),
        onSaved: (value) => usuario.apellidoMaterno = value,
      ),
    );
  }

  Widget _crearCelular(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: '7283193',
          labelText: 'Nro. Celular'
        ),
        onSaved: (value) => usuario.celular = int.parse(value),
      ),
    );
  }

  Widget _crearFechaNac(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          icon: Icon(Icons.date_range, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: 'AAAA-mm-dd',
          labelText: 'Fecha de nacimiento'
        ),
        onSaved: (value) => usuario.fechaNac = value,
      ),
    );
  }

  Widget _crearAltura(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.chevron_right, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: '1.70',
          labelText: 'Altura'
        ),
        onSaved: (value) => usuario.altura = double.parse(value),
      ),
    );
  }

  Widget _crearPeso(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),

      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.chevron_right, color: Color.fromRGBO(36, 247, 188, 1.0)),
          hintText: '65.5',
          labelText: 'Peso'
        ),
        onSaved: (value) => usuario.peso = double.parse(value),
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
        onSaved: (value) => usuario.password = value,
      ),
    );
  
  }

    Widget _crearGenero(){
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      // padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey[200],
          ),

      child: DropdownButton(
        value: _value,
        style: TextStyle(
          color: Color.fromRGBO(36, 247, 188, 1.0), 
          fontSize: 16, 
          fontWeight: FontWeight.bold
        ),
        items: [
                DropdownMenuItem(
                  child: Text("Femenino"),
                  value: 'Femenino',
                ),
                DropdownMenuItem(
                  child: Text("Masculino"),
                  value: 'Masculino',
                ),
              ],
        onChanged: (value){
          setState(() {
            _value = value;
            usuario.genero=_value;
            print(_value);
          });
        }
      ),
    );
  
  }

  Widget _crearBoton( BuildContext context ){

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Enviar', style: TextStyle(fontSize: 18),),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 5.0,
      color: Color.fromRGBO(36, 196, 249, 1.0),
      textColor: Colors.white,
      // onPressed: () {},
      onPressed: (_bloquearBoton) ? null : _submit,
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
                _crearCelular(),
                _crearFechaNac(),
                _crearPeso(),
                _crearAltura(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: Row(
                  children: <Widget>[
                    Text(
                      'Género:',
                      style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 30,),
                    _crearGenero(),
                  ],
                  ),
                ),
                SizedBox(height: 30.0),
                _crearBoton(context),    
              ],
            ) ,
          ),
        ],
      ),
    );

  }

  void _submit() async{

    print(_bloquearBoton);

    formRegKey.currentState.save();

    print(usuario.correo);
    print(usuario.password);

    setState(() {
      _bloquearBoton = true;
    });

    print(_bloquearBoton);

    var regUser = usuarioProvider.insertarUsuario(usuario);
    
    if( await regUser ){
      setState(() {
        _bloquearBoton = true;
      });
      mostrarSnackbar2('Usuario creado con éxito', Color.fromRGBO(36, 196, 249, 1.0));
      Navigator.pop(context);
    }else{
      setState(() {
        _bloquearBoton = true;
      });
      mostrarSnackbar2('Error al crear el usuario', Color.fromRGBO(36, 196, 249, 1.0));
    }
  }

  void mostrarSnackbar2(String mensaje, Color colorBG) {
    final snackbarReg = SnackBar(
      content: Text(mensaje, style: TextStyle(color: Colors.white)),
      duration: Duration(milliseconds: 2500),
      backgroundColor: colorBG,
    );

    scaffoldKeyRegUser.currentState.showSnackBar(snackbarReg);
  }

}