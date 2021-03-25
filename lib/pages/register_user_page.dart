import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class RegisterUserPage extends StatefulWidget {
  //static final routeName = 'registerUser';
  // RegisterUserPage({Key key}) : super(key: key);
  @override
  _RegisterUserPage createState() => _RegisterUserPage();
}

class _RegisterUserPage extends State<RegisterUserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            title: Text("Regitro de usuarios"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                      initialValue: '',
                      // controller: name,
                      validator: (value) {
                        if (value.length < 1) {
                          return 'El nombre no debe estar vacio.';
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Genero',
                      ),
                      initialValue: '',
                      // controller: email,
                      validator: (value) {
                        if (value.length < 1) {
                          return 'El genero no debe estar vacio.';
                        }
                        return null;
                      }),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                      ),
                      initialValue: '',
                      // controller: gender,
                      validator: (value) {
                        if (value.length < 1) {
                          return 'El correo no debe estar vacio.';
                        }
                        return null;
                      }),
                  RaisedButton(
                    child: Text('Registrar'),
                    onPressed: () {
                      print(_formKey);
                      // if (_formKey.currentState.validate()) {
                      //   userFormBloc.add(user?.id == null
                      //       ? CreateUser(user: user)
                      //       : UpdateUser(user: user));
                      // }
                    },
                  )
                ],
              ),

              // width: double.infinity,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Container(
              //       child: Text(
              //         "Bienvenido al Home",
              //         style: TextStyle(
              //           fontSize: 30,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ),
              //     SizedBox(height: 20),
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: Image.asset(
              //         'assets/icons/ninodance.gif',
              //         width: 300,
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
