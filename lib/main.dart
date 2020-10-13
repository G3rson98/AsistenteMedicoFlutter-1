import 'package:asistentemedico/src/pages/alergia_page.dart';
import 'package:asistentemedico/src/pages/login_page.dart';
import 'package:asistentemedico/src/pages/profile_page.dart';
import 'package:asistentemedico/src/pages/registrarUsuario_page.dart';
import 'package:asistentemedico/src/pages/results_page.dart';
import 'package:asistentemedico/src/pages/search_page.dart';
import 'package:asistentemedico/src/widget/confirm_illness_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asistentemedico/src/pages/home_page.dart';
import 'package:asistentemedico/src/pages/scroll_page.dart';
import 'package:asistentemedico/src/pages/informacion_page.dart';
import 'package:asistentemedico/src/pages/buttom_nav_bar_page.dart';
import 'package:asistentemedico/src/pages/multimedia_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors
            .white)); // Se indica esto para que en toda la aplicación los colores del safeArea sean blancos.
    return MaterialApp(
      title: 'Asistente médico',
      debugShowCheckedModeBanner: false,
      initialRoute: 'scroll',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'informacion': (BuildContext context) => InformacionPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'begin': (BuildContext context) => ButtomNavigationBar(),
        'perfil': (BuildContext context) => ProfilePage(),
        //ID DE LA CARPETA RAIZ DEL USUARIO LOGUEADO
        'multimedia': (BuildContext context) => MultimediaPage(1),
        'login': (BuildContext context) => LoginPage(),
        'registrarUsuario': (BuildContext context) => RegistrarUsuario(),
        'search': (BuildContext context) => SearchPage(),
        'alergias': (BuildContext context) => AlergiasPage(misAlergias: []),
      },
    );
  }
}
