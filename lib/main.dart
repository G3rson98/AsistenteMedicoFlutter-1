import 'package:asistentemedico/src/models/diagnosis_query_model.dart';
import 'package:asistentemedico/src/pages/search_page.dart';
import 'package:asistentemedico/src/widget/question_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:asistentemedico/src/pages/home_page.dart';
import 'package:asistentemedico/src/pages/scroll_page.dart';
import 'package:asistentemedico/src/pages/informacion_page.dart';
import 'package:asistentemedico/src/pages/buttom_nav_bar_page.dart';
import 'package:asistentemedico/src/pages/multimedia_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  List<Evidence> listEvidence = [
  ];
  String question = "¿Qué tan seguido le duele su cabeza?";
  List<dynamic> posibleAnswers = [
            {
                "id": "s_1907",
                "name": "Seconds to minutes",
                "choices": [
                    {
                        "id": "present",
                        "label": "Yes"
                    },
                    {
                        "id": "absent",
                        "label": "No"
                    },
                    {
                        "id": "unknown",
                        "label": "Don't know"
                    }
                ]
            },
            {
                "id": "s_1868",
                "name": "From a few minutes to 4 hours",
                "choices": [
                    {
                        "id": "present",
                        "label": "Yes"
                    },
                    {
                        "id": "absent",
                        "label": "No"
                    },
                    {
                        "id": "unknown",
                        "label": "Don't know"
                    }
                ]
            },
            {
                "id": "s_1870",
                "name": "From 4 hours to 3 days",
                "choices": [
                    {
                        "id": "present",
                        "label": "Yes"
                    },
                    {
                        "id": "absent",
                        "label": "No"
                    },
                    {
                        "id": "unknown",
                        "label": "Don't know"
                    }
                ]
            },
            {
                "id": "s_1901",
                "name": "Over 3 days",
                "choices": [
                    {
                        "id": "present",
                        "label": "Yes"
                    },
                    {
                        "id": "absent",
                        "label": "No"
                    },
                    {
                        "id": "unknown",
                        "label": "Don't know"
                    }
                ]
            }
        ];
  int number = 1;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white
      )
    ); // Se indica esto para que en toda la aplicación los colores del safeArea sean blancos.
    return MaterialApp(
      title: 'Asistente médico',
      debugShowCheckedModeBanner: false,
      initialRoute: 'question',
      routes: {
        'home'        :   (BuildContext context) => HomePage(),
        'informacion' :   (BuildContext context) => InformacionPage(),
        'scroll'      :   (BuildContext context) => ScrollPage(),
        'begin'       :   (BuildContext context) => ButtomNavigationBar(),
        'question'    :   (BuildContext context) => QuestionWidget(listEvidence: listEvidence, question: question, posibleAnswers: posibleAnswers, numberOfQuery: number),
        'multimedia'  :   (BuildContext context) => MultimediaPage(),
        'search'      :   (BuildContext context) => SearchPage(),
      },
    );
  }
}