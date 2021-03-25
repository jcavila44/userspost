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
                  Icons.supervised_user_circle_sharp,
                  color: Colors.black,
                ),
                labelButton: "Usuarios",
                onPressed: () {
                  print("perras");
                },
              ),
              SizedBox(height: 10),
              ButtonDrawer(
                iconButton: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                labelButton: "Posts",
                onPressed: () {
                  print("perras");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
