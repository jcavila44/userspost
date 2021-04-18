import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/pages/home_page.dart';
import 'package:userspost/widgets/circular_progress.dart';

class SplashWidget extends StatefulWidget {
  static final routeName = 'splash';

  const SplashWidget({Key key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: CircularProgress(),
        ),
      ),
    );
  }
}
