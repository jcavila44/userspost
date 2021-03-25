import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userspost/widgets/splash_widget.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Funciona para darle color a las letras de la  barra de notificacion
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      home: SplashWidget(),
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SplashWidget.routeName: (BuildContext context) => SplashWidget(),
      },
      debugShowCheckedModeBanner: false, //Quita el letrero de debugs
    );
  }
}
