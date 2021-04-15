import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userspost/pages/comments_post_page.dart';
import 'package:userspost/pages/manage_user_page.dart';
import 'package:userspost/pages/register_post_page.dart';
import 'package:userspost/pages/register_user_page.dart';
import 'package:userspost/widgets/splash_widget.dart';
import 'package:userspost/pages/list_user_page.dart';
import 'package:userspost/pages/list_post_page.dart';

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
        RegisterUserPage.routeName: (BuildContext context) =>
            RegisterUserPage(),
        ListUsersPage.routeName: (BuildContext context) => ListUsersPage(),
        GestionUserPage.routeName: (BuildContext context) => GestionUserPage(),
        ListPostsPage.routeName: (BuildContext context) => ListPostsPage(),
        RegisterPostPage.routeName: (BuildContext context) =>
            RegisterPostPage(),
        CommentsPostsPage.routeName: (BuildContext context) =>
            CommentsPostsPage(),
      },
      debugShowCheckedModeBanner: false, //Quita el letrero de debugs
    );
  }
}
