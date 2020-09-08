import 'package:flutter/material.dart';
import 'package:asistentemedico/src/pages/home_page.dart';
import 'package:asistentemedico/src/pages/settings_page.dart';
import 'package:asistentemedico/src/pages/profile_page.dart';

class ButtomNavigationBar extends StatefulWidget {
  ButtomNavigationBar({Key key}) : super(key: key);

  @override
  _ButtomNavigationBarState createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  int currentIndex = 0; // Variable para indicar el index del boton seleccionado.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex), // Indicamos cual es la página a mostrar a traves del index que se envia por parametro
      bottomNavigationBar: _buttomNavigationBar(context),
    );
  }

  Widget _callPage(int paginaActual){
    switch(paginaActual){
      case 0: return HomePage();
      case 1: return ProfilePage();
      case 2: return SettingsPage();

      default: return HomePage();
    }
  }

   Widget _buttomNavigationBar(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(36, 247, 188,1.0),
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color: Color.fromRGBO(255, 255, 255,0.55)),
        ),
      ),
      child: BottomNavigationBar( // Este widget necesita que le indiquemos una lista con 2 o más item(indicando el icon y title a cada uno), por defecto no se puede indicar un color
      // Para decorar este widget la única forma es a través de un widget personalizado, es decir un tema personalizado.
        currentIndex: currentIndex, // Indicamos el valor actual del index, es decir que boton está seleccionado.
        onTap: (index){ // Esta función permite actualizar el valor de la variable currentIndex, con el valor del boron tapeado.
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Container(),
          ),
        ],
      ),
    );
  }

}