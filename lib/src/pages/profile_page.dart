import 'package:asistentemedico/src/models/usuario_model.dart';
import 'package:asistentemedico/src/services/usuario_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Usuario usuario;
  UsuarioProvider usuarioProv = new UsuarioProvider();
  String _opcionSexo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil',
            style: TextStyle(color: Colors.white, fontSize: 25.0)),
        backgroundColor: Color.fromRGBO(36, 247, 188, 1.0),
      ),
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
            width: size.width * 0.90,
            margin: EdgeInsets.symmetric(vertical: 25.0),
            // padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: <Widget>[
                Text('Datos Basicos',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                SizedBox(height: 30.0),
                inputFormulario(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inputFormulario() {
    return FutureBuilder<Usuario>(
        //Sacar el id del usuario del Shared Preferences
        future: this.usuarioProv.getUsuario(1),
        builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
          if (snapshot.hasData) {
            this.usuario = snapshot.data;
            final list = new List<Widget>();
            list.add(_crearUsuario());
            list.add(SizedBox(height: 10.0));
            list.add(_crearNombre());
            list.add(SizedBox(height: 10.0));
            list.add(_crearApellidoPaterno());
            list.add(SizedBox(height: 10.0));
            list.add(_crearApellidoMaterno());
            list.add(SizedBox(height: 10.0));
            list.add(_crearCorreo());
            list.add(SizedBox(height: 10.0));
            list.add(_crearCelular());
            list.add(SizedBox(height: 10.0));
            list.add(_crearDropdownSexo());
            list.add(SizedBox(height: 10.0));
            list.add(_crearFecha(context));
            list.add(SizedBox(height: 10.0));
            list.add(_crearAltura());
            list.add(SizedBox(height: 10.0));
            list.add(_crearPeso());
            list.add(SizedBox(height: 25.0));
            list.add(_crearBoton(context));
            return Form(
                key: formKey,
                child: Column(
                  children: list,
                ));
          } else {
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget _crearUsuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        initialValue: usuario.nombreUsuario,
        decoration: InputDecoration(
            icon: Icon(Icons.account_circle,
                color: Color.fromRGBO(251, 196, 107, 1.0)),
            hintText: 'Usuario',
            labelText: 'Nombre de usuario'),
        onSaved: (value) {
          print('value: ' + value);
          print(this.usuario.nombreUsuario);
          this.usuario.nombreUsuario = value;
        },
      ),
    );
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        initialValue: usuario.nombre,
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
        initialValue: usuario.apellidoPaterno,
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
        initialValue: usuario.apellidoMaterno,
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
        initialValue: usuario.correo,
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

  Widget _crearDropdownSexo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.wc, color: Color.fromRGBO(251, 196, 107, 1.0)),
          SizedBox(width: 20.0),
          Expanded(
            child: DropdownButton(
              value: (usuario.genero != null && _opcionSexo == "")
                  ? this.usuario.genero
                  : (_opcionSexo == "") ? 'Seleccione' : _opcionSexo,
              items: getOpcionesDropdown(),
              onChanged: (opt) {
                setState(() {
                  usuario.genero = (opt == 'Seleccione') ? null : opt;
                  print('Genero: ' + usuario.genero);
                  _opcionSexo = opt;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _crearCelular() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        // obscureText: true,
        initialValue:
            (usuario.celular == null) ? "" : usuario.celular.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Celular',
        ),
        onSaved: (value) {
          print('value: ' + value);
          usuario.celular = num.tryParse(value);
        },
      ),
    );
  }

  Widget _crearAltura() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        // obscureText: true,
        initialValue: (usuario.altura == null) ? "" : usuario.altura.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          icon: Icon(Icons.arrow_right,
              color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Altura',
        ),
        onSaved: (value) {
          print('value: ' + value);
          usuario.altura = num.tryParse(value);
        },
      ),
    );
  }

  Widget _crearPeso() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        // obscureText: true,
        initialValue: (usuario.peso == null) ? "" : usuario.peso.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          icon: Icon(Icons.arrow_right,
              color: Color.fromRGBO(251, 196, 107, 1.0)),
          labelText: 'Peso',
        ),
        onSaved: (value) {
          print('value: ' + value);
          usuario.peso = num.tryParse(value);
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

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    List<String> opciones = ['Seleccione', 'Masculino', 'Femenino'];
    opciones.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
  }

  Widget _crearFecha(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        // enableInteractiveSelection: false,
        initialValue: (usuario.fechaNac == null || usuario.fechaNac == "")
            ? ""
            : usuario.fechaNac,
        decoration: InputDecoration(
          icon: Icon(Icons.perm_contact_calendar,
              color: Color.fromRGBO(251, 196, 107, 1.0)),
          hintText: 'AAAA-mm-dd',
          labelText: 'Fecha de nacimiento',
        ),
        onSaved: (value) {
          print('value: ' + value);
          usuario.fechaNac = value;
        },
      ),
    );
  }

  void _submit() async {
    formKey.currentState.save();
    usuario.genero = _opcionSexo;
    print('Usuario: ' + this.usuario.toString());
    var bandera = usuarioProv.editarUsuario(usuario);

    if (await bandera) {
      Navigator.pushReplacementNamed(context, 'begin');
      // Navigator.pushNamed(context, 'home');

    }
  }
}
