import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'buttons_drawer_widget.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.all(3),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonDrawer(
                iconButton: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                labelButton: 'Home',
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                buttonColor: null,
                labelColor: Colors.black,
              ),
              SizedBox(height: 10),
              ButtonDrawer(
                iconButton: Icon(
                  Icons.supervised_user_circle_sharp,
                  color: Colors.black,
                ),
                labelButton: 'Users',
                onPressed: () {
                  Navigator.pushNamed(context, 'listusers');
                },
                buttonColor: null,
                labelColor: Colors.black,
              ),
              SizedBox(height: 10),
              ButtonDrawer(
                iconButton: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                labelButton: 'Posts',
                onPressed: () {},
                buttonColor: null,
                labelColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
