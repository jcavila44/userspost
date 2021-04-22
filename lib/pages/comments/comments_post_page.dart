import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/blocs/comments_post_bloc.dart';
import 'package:userspost/models/comments/comments_model.dart';
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/pages/posts/list_post_page.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class CommentsPostsPage extends StatefulWidget {
  final Post arguments;
  final User argumentsUser;

  CommentsPostsPage({Key key, this.arguments, this.argumentsUser})
      : super(key: key);
  static final routeName = 'commentspost';

  @override
  _CommentsPostsPageState createState() => _CommentsPostsPageState();
}

class _CommentsPostsPageState extends State<CommentsPostsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final searchInputController = TextEditingController();

  // final Post arguments = ModalRoute.of(context).settings.arguments;

  bool sortAscending;

  List<Comments> comments;
  final CommentsPostBloc _block = CommentsPostBloc();

  @override
  void initState() {
    super.initState();
    sortAscending = false;
    _block.sendEvent.add(GetListEvent(id_user: widget.arguments.id));
  }

  @override
  void dispose() {
    _block.dispose();
    super.dispose();
  }

  void ordenarColumna(int columnIndex, bool ordenar) {
    if (columnIndex == 0) {
      if (ordenar) {
        _block.listComments.sort((a, b) => a.name.compareTo(b.name));
      } else {
        _block.listComments.sort((a, b) => b.name.compareTo(a.name));
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
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) =>
                              ListPostsPage(arguments: widget.argumentsUser),
                        ),
                      );
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
              title: Text('Lista de comentarios de los posts'),
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
                      StreamBuilder<List<Comments>>(
                        stream: _block.listStream,
                        builder: (contex, snapshot) {
                          if (snapshot.hasData) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  // InputRegister(
                                  //   placeholder: 'Search...',
                                  //   placeholderSize: 25,
                                  //   controllerFunct: searchInputController,
                                  // ),
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
                                              label: Text('Id'),
                                              numeric: false,
                                              tooltip: 'Id',
                                            ),
                                            DataColumn(
                                              label: Text('Titulo'),
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
                                              label: Text('comentario'),
                                              numeric: false,
                                              tooltip: 'comentario',
                                            ),
                                            // DataColumn(
                                            //   label: Text('Ver Comentarios'),
                                            //   numeric: false,
                                            //   tooltip: 'Ver Comentarios',
                                            // ),
                                          ],
                                          rows: snapshot.data
                                              .map(
                                                (posts) => DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text(
                                                        posts.id.toString(),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(posts.name),
                                                    ),
                                                    DataCell(
                                                      Text(posts.email),
                                                    ),
                                                    DataCell(
                                                      // Text(posts.body),

                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: ButtonDrawer(
                                                          iconButton: Icon(
                                                            Icons.search,
                                                            color: Colors.white,
                                                          ),
                                                          labelButton: 'Ver',
                                                          onPressed: () {
                                                            showDialog(
                                                                builder: (context) => AlertDialog(
                                                                    content: Text(
                                                                        posts
                                                                            .body,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify)),
                                                                context:
                                                                    context);
                                                          },
                                                          buttonColor:
                                                              Colors.blue,
                                                          labelColor: null,
                                                        ),
                                                      ),
                                                    ),
                                                    // DataCell(
                                                    //   Container(
                                                    //     padding:
                                                    //         EdgeInsets.all(3),
                                                    //     child: ButtonDrawer(
                                                    //       iconButton: Icon(
                                                    //         Icons.search,
                                                    //         color: Colors.white,
                                                    //       ),
                                                    //       labelButton: '',
                                                    //       onPressed: () {
                                                    //         Navigator.pushNamed(
                                                    //             context,
                                                    //             'manageuser');
                                                    //       },
                                                    //       buttonColor:
                                                    //           Colors.blue,
                                                    //       labelColor: null,
                                                    //     ),
                                                    //   ),
                                                    // ),
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
                                        child: CircularProgressIndicatorApp()),
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

class CircularProgressIndicatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.red,
      strokeWidth: 8,
    );
  }
}
