import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/blocs/user_list_bloc.dart';
import 'package:userspost/models/user/paises.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/widgets/input_registerformuser_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

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
  List<Pais> paises;

  List<User> users;
  final UserListBloc _block = UserListBloc();

  @override
  void initState() {
    super.initState();
    sortAscending = false;
    _block.sendEvent.add(GetListEvent());
    paises = Pais.getPaises();
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<List<User>>(
                        stream: _block.counterStream,
                        builder: (contex, snapshot) {
                          if (snapshot.hasData) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  InputRegister(
                                      placeholder: 'Search...',
                                      placeholderSize: 20,
                                      controllerFunct: searchInputController,
                                      heightZise: 50),
                                  SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
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
                                            label: Text('Email'),
                                            numeric: false,
                                            tooltip: 'Email',
                                          ),
                                          DataColumn(
                                            label: Text('Genero'),
                                            numeric: false,
                                            tooltip: 'Genero',
                                          ),
                                          DataColumn(
                                            label: Text('Estado'),
                                            numeric: false,
                                            tooltip: 'Estado',
                                          ),
                                        ],
                                        rows: snapshot.data
                                            .map(
                                              (pais) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    Text(
                                                      pais.name,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      pais.gender,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      pais.status,
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      pais.email,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Text('Esperando datos');
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
