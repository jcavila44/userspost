import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/blocs/register_user_bloc.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/selectinput_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class RegisterUserPage extends StatefulWidget {
  static final routeName = 'registeruser';
  // RegisterUserPage({Key key}) : super(key: key);
  @override
  _RegisterUserPage createState() => _RegisterUserPage();
}

class _RegisterUserPage extends State<RegisterUserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var data = 'hola onchange';

  final User user = User();
  final RegisterUserBloc _block = RegisterUserBloc();

  FocusNode focusNode;
  String _selectedLocation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text('Registro de usuarios'),
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
                            placeholder: 'Nombre',
                            placeholderSize: 25,
                            onchangeInput: (String data) {
                              setState(() {
                                user.name = data;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          InputRegister(
                            placeholder: 'Email',
                            placeholderSize: 25,
                            onchangeInput: (String data) {
                              setState(() {
                                user.email = data;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          SelectWidget(
                            selectedLocation: _selectedLocation,
                            onchangeInput: (newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                                user.gender = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonDrawer(
                                  iconButton: Icon(Icons.arrow_back),
                                  labelButton: 'Atras',
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'home');
                                  },
                                  buttonColor: Colors.grey,
                                  labelColor: Colors.white,
                                ),
                                ButtonDrawer(
                                  iconButton: Icon(Icons.check),
                                  labelButton: 'Guardar',
                                  onPressed: () {
                                    print('Genero :' + user.gender);
                                    _block.sendEvent
                                        .add(RegisterEvent(user: user));
                                    // _block.user = user;
                                    // print('Nombre 2 :' + user.name);
                                  },
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
