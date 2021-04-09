import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/selectinput_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class GestionUserPage extends StatefulWidget {
  GestionUserPage({Key key}) : super(key: key);
  static final routeName = 'manageuser';

  @override
  _GestionUserPageState createState() => _GestionUserPageState();
}

class _GestionUserPageState extends State<GestionUserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final nick1 = TextEditingController();
  final nick2 = TextEditingController();
  FocusNode focusNode;
  // ignore: unused_field
  String _selectedLocation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User arguments = ModalRoute.of(context).settings.arguments;

    _selectedLocation = arguments?.gender ?? '';

    if (arguments != null) {
      print('Nombre' + arguments.name + '->' + arguments.id.toString());
    } else {
      print('no');
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Scaffold(
            key: _scaffoldKey,
            // El Drawer es el menú izquierdo
            drawer: SideBarWidget(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              title: Text('Gestión de Usuario'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InputRegister(
                            defaultValue: arguments.name,
                            placeholder: 'Nombre',
                            placeholderSize: 25,
                            controllerFunct: nick1,
                          ),
                          SizedBox(height: 20),
                          InputRegister(
                            defaultValue: arguments.email,
                            placeholder: 'Email',
                            placeholderSize: 25,
                            controllerFunct: nick2,
                          ),
                          SizedBox(height: 20),
                          SelectWidget(
                            selectedLocation: _selectedLocation,
                            onchangeInput: (newValue) {
                              setState(() {
                                print('Genero: ' + newValue);
                                _selectedLocation = newValue;
                                arguments.gender = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonDrawer(
                                  iconButton: Icon(Icons.delete),
                                  labelButton: 'Eliminar',
                                  onPressed: () {
                                    // Navigator.pushNamed(context, 'home');
                                  },
                                  buttonColor: Colors.red,
                                  labelColor: Colors.white,
                                ),
                                ButtonDrawer(
                                  iconButton: Icon(Icons.check),
                                  labelButton: 'Actualizar',
                                  onPressed: () {},
                                  buttonColor: Colors.blue,
                                  labelColor: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
