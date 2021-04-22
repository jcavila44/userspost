import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userspost/blocs/user_list_bloc.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/pages/posts/list_post_page.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';
import 'package:userspost/widgets/circular_progress.dart';

class ListUsersPage extends StatefulWidget {
  ListUsersPage({Key key}) : super(key: key);
  static final routeName = 'listusers';

  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final searchInputController = TextEditingController();
  bool sortAscending;
  int searchAfter;

  List<User> users;
  final UserListBloc _block = UserListBloc();

  @override
  void initState() {
    super.initState();
    sortAscending = false;
    _block.sendEvent.add(GetListEvent());
  }

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }

  void ordenarColumna(int columnIndex, bool ordenar) {
    if (columnIndex == 0) {
      if (ordenar) {
        _block.listUsers.sort((a, b) => a.name.compareTo(b.name));
      } else {
        _block.listUsers.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
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
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp,
                      ]);
                      Navigator.pushNamed(context, 'registeruser');
                    },
                    color: Colors.blue,
                    child: Text('Añadir Usuario'),
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
              title: Text('Lista de usuarios'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<List<User>>(
                        stream: _block.listStream,
                        builder: (contex, snapshot) {
                          if (snapshot.hasData) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  InputRegister(
                                    defaultValue: null,
                                    placeholder: 'Buscar...',
                                    placeholderSize: 25,
                                    controllerFunct: searchInputController,
                                    onchangeInput: (String data) {
                                      setState(() {
                                        if (data.length > 2) {
                                          searchAfter = data.length;
                                          _block.sendEvent.add(
                                              GetListEventSearch(search: data));
                                        } else if (data.isEmpty &&
                                            searchAfter == 3) {
                                          _block.sendEvent.add(GetListEvent());
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 450,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columnSpacing: 30,
                                          dividerThickness: 0,
                                          dataRowHeight: 50,
                                          headingRowHeight: 50,
                                          sortColumnIndex:
                                              0, // icono de la flecha en el titulo
                                          sortAscending:
                                              sortAscending, //Orientacion de la flecha
                                          columns: [
                                            DataColumn(
                                              label: Text('Nombre'),
                                              numeric: false,
                                              onSort: (columnIndex, ascending) {
                                                setState(
                                                  () {
                                                    sortAscending =
                                                        !sortAscending;
                                                  },
                                                );
                                                ordenarColumna(
                                                    columnIndex, ascending);
                                              },
                                            ),
                                            DataColumn(
                                              label: Text('Género'),
                                              numeric: false,
                                              tooltip: 'Género',
                                            ),
                                            DataColumn(
                                              label: Text('Estado'),
                                              numeric: false,
                                              tooltip: 'Estado',
                                            ),
                                            DataColumn(
                                              label: Text('Gestion'),
                                              numeric: false,
                                              tooltip: 'Gestion',
                                            ),
                                            DataColumn(
                                              label: Text('VerPosts'),
                                              numeric: false,
                                              tooltip: 'VerPosts',
                                            ),
                                          ],
                                          rows: snapshot.data
                                              .map(
                                                (users) => DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text(
                                                        users.name,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        users.gender,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        users.status,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: ButtonDrawer(
                                                          iconButton: Icon(
                                                            Icons.settings,
                                                            color: Colors.white,
                                                          ),
                                                          labelButton: '',
                                                          onPressed: () {
                                                            SystemChrome
                                                                .setPreferredOrientations([
                                                              DeviceOrientation
                                                                  .portraitDown,
                                                              DeviceOrientation
                                                                  .portraitUp,
                                                            ]);
                                                            Navigator.pushNamed(
                                                              context,
                                                              'manageuser',
                                                              arguments: users,
                                                            );
                                                          },
                                                          buttonColor:
                                                              Colors.blue,
                                                          labelColor: null,
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: ButtonDrawer(
                                                          iconButton: Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          ),
                                                          labelButton: '',
                                                          onPressed: () {
                                                            SystemChrome
                                                                .setPreferredOrientations([
                                                              DeviceOrientation
                                                                  .landscapeLeft,
                                                              DeviceOrientation
                                                                  .landscapeRight,
                                                            ]);
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              CupertinoPageRoute(
                                                                builder: (context) =>
                                                                    ListPostsPage(
                                                                        arguments:
                                                                            users),
                                                              ),
                                                            );
                                                          },
                                                          buttonColor:
                                                              Colors.blue,
                                                          labelColor: null,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width / 3),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: CircularProgress()),
                                  ),
                                ),
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
      ),
    );
  }
}
