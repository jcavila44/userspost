import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userspost/blocs/register_post_bloc.dart';
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/pages/posts/list_post_page.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class RegisterPostPage extends StatefulWidget {
  static final routeName = 'registerpost';
  // RegisterUserPage({Key key}) : super(key: key);
  @override
  _RegisterPostPage createState() => _RegisterPostPage();
}

class _RegisterPostPage extends State<RegisterPostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var data = '';

  final Post post = Post();

  final RegisterPostBloc _block = RegisterPostBloc();

  FocusNode focusNode;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User arguments = ModalRoute.of(context).settings.arguments;

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
              title: Text('Registro de Post'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<Post>(
                        stream: _block.registerStream,
                        // ignore: missing_return
                        builder: (contex, snapshot) {
                          if (snapshot?.data != null) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(14)),
                                    Text('Post: ${arguments.name}'),
                                    Padding(padding: EdgeInsets.all(14)),
                                    Text(
                                        'Titulo: ${snapshot?.data?.title ?? ""}'),
                                    Padding(padding: EdgeInsets.all(7)),
                                    Text('body: ${snapshot?.data?.body ?? ""}'),
                                    Padding(padding: EdgeInsets.all(7)),
                                    MaterialButton(
                                      minWidth: 200.0,
                                      height: 40.0,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          'registerpost',
                                          arguments: arguments,
                                        );
                                      },
                                      color: Colors.lightBlue,
                                      child: Text('Crear nuevo post',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InputRegister(
                                  placeholder: 'Usuario',
                                  placeholderSize: 25,
                                  defaultValue: arguments.name,
                                  enabled: false,
                                ),
                                SizedBox(height: 10),
                                InputRegister(
                                  placeholder: 'Titulo',
                                  placeholderSize: 25,
                                  onchangeInput: (String data) {
                                    setState(() {
                                      post.title = data;
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                InputRegister(
                                  placeholder: 'Body',
                                  placeholderSize: 25,
                                  onchangeInput: (String data) {
                                    setState(() {
                                      post.body = data;
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
                                          // Navigator.pushNamed(
                                          //     context, 'listusers');
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  ListPostsPage(
                                                      arguments: arguments),
                                            ),
                                          );
                                        },
                                        buttonColor: Colors.grey,
                                        labelColor: Colors.white,
                                      ),
                                      ButtonDrawer(
                                        iconButton: Icon(Icons.check),
                                        labelButton: 'Guardar',
                                        onPressed: () {
                                          if ((post.title == '' ||
                                                  post.title == null) ||
                                              (post.body == '' ||
                                                  post.body == null)) {
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
                                            post.user_id = arguments.id;
                                            _block.sendEvent.add(
                                                RegisterEvent(posts: post));
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
