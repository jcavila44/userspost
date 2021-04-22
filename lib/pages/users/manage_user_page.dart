import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userspost/blocs/update_user_bloc.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/selectinput_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

import 'list_user_page.dart';

class GestionUserPage extends StatefulWidget {
  GestionUserPage({Key key}) : super(key: key);
  static final routeName = 'manageuser';

  @override
  _GestionUserPageState createState() => _GestionUserPageState();
}

class _GestionUserPageState extends State<GestionUserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  User user = User();
  final UpdateUserBloc _block = UpdateUserBloc();

  FocusNode focusNode;
  // ignore: unused_field
  String _selectedLocation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final User arguments = ModalRoute.of(context).settings.arguments;
    user = arguments;
    _selectedLocation = arguments?.gender ?? '';

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Scaffold(
            floatingActionButton: keyboardIsOpened
                ? null
                : CupertinoButton(
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                      Navigator.pushNamed(context, 'listusers');
                    },
                    color: Colors.grey,
                    child: Text('Volver al listado'),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
            ),
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
                    StreamBuilder<User>(
                      stream: _block.registerStream,
                      // ignore: missing_return
                      builder: (contex, snapshot) {
                        if (_block.respinseApi != 0 &&
                            _block.respinseApi == 200) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(50),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 20),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/icons/checking.gif',
                                    width: 300,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'El usuario fue gestionado correctamente. 😎👌',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                ButtonDrawer(
                                  iconButton: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  labelButton: 'Volver al listado',
                                  onPressed: () {
                                    SystemChrome.setPreferredOrientations([
                                      DeviceOrientation.landscapeLeft,
                                      DeviceOrientation.landscapeRight,
                                    ]);
                                    Navigator.pushNamed(context, 'listusers');
                                  },
                                  buttonColor: Colors.blue,
                                  labelColor: Colors.white,
                                )
                              ],
                            ),
                          );

                          // Navigator.pushNamed(context, 'listusers');
                          // return Text('');
                        } else if (_block.respinseApi != 0 &&
                            _block.respinseApi != 200) {
                          return Text('Falló');
                        }
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InputRegister(
                                defaultValue: arguments.name,
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
                                defaultValue: arguments.email,
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
                                    Expanded(
                                      child: ButtonDrawer(
                                        iconButton: Icon(Icons.delete),
                                        labelButton: 'Eliminar',
                                        onPressed: () {
                                          _block.sendEvent
                                              .add(DeleteEvent(user: user));
                                        },
                                        buttonColor: Colors.red,
                                        labelColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: ButtonDrawer(
                                        iconButton: Icon(Icons.check),
                                        labelButton: 'Actualizar',
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
                                                .add(UpdateEvent(user: user));
                                          }
                                        },
                                        buttonColor: Colors.blue,
                                        labelColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
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
