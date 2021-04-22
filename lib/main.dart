import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userspost/pages/users/list_user_page.dart';
import 'package:userspost/pages/users/register_user_page.dart';
import 'package:userspost/pages/users/manage_user_page.dart';
import 'package:userspost/pages/posts/list_post_page.dart';
import 'package:userspost/pages/posts/register_post_page.dart';
import 'package:userspost/pages/comments/comments_post_page.dart';
import 'package:userspost/widgets/splash_widget.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        SplashWidget.routeName: (BuildContext context) => SplashWidget(),
        HomePage.routeName: (BuildContext context) => HomePage(),
        ListUsersPage.routeName: (BuildContext context) => ListUsersPage(),
        RegisterUserPage.routeName: (BuildContext context) =>
            RegisterUserPage(),
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
