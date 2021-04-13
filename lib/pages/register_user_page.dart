import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                    StreamBuilder<User>(
                        stream: _block.registerStream,
                        // ignore: missing_return
                        builder: (contex, snapshot) {
                          if (snapshot?.data != null) {
                            // Fluttertoast.showToast(
                            //     msg: 'Usuario creado correctamente.',
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.blue,
                            //     textColor: Colors.white,
                            //     fontSize: 18.0);
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                // height: 200,
                                child: Card(
                                  // color: Colors.black,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(14)),
                                      Text(
                                          'Nombre: ${snapshot?.data?.name ?? ""}'),
                                      Padding(padding: EdgeInsets.all(7)),
                                      Text(
                                          'Correo: ${snapshot?.data?.email ?? ""}'),
                                      Padding(padding: EdgeInsets.all(7)),
                                      Text(
                                          'Genero: ${snapshot?.data?.gender ?? ""}'),
                                      Padding(padding: EdgeInsets.all(7)),
                                      Text(
                                          'Estado: ${snapshot?.data?.status ?? ""}'),
                                      Padding(padding: EdgeInsets.all(7)),
                                      MaterialButton(
                                        minWidth: 200.0,
                                        height: 40.0,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'registeruser');
                                        },
                                        color: Colors.lightBlue,
                                        child: Text('Crear nuevo usuario',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ));
                          }
                          return Form(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ButtonDrawer(
                                        iconButton: Icon(Icons.arrow_back),
                                        labelButton: 'Atras',
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'listusers');
                                        },
                                        buttonColor: Colors.grey,
                                        labelColor: Colors.white,
                                      ),
                                      ButtonDrawer(
                                        iconButton: Icon(Icons.check),
                                        labelButton: 'Guardar',
                                        onPressed: () {
                                          if ((user.email == '' ||
                                                  user.email == null) ||
                                              (user.name == '' ||
                                                  user.name == null) ||
                                              (user.gender == '' ||
                                                  user.gender == null)) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Debe diligenciar la información requerida.',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 18.0);
                                          } else {
                                            _block.sendEvent
                                                .add(RegisterEvent(user: user));
                                          }
                                        },
                                        buttonColor: Colors.blue,
                                        labelColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
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
