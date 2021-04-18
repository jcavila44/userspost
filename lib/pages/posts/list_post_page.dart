import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userspost/blocs/post_list_bloc.dart';
import 'package:userspost/models/post/post_model.dart';
import 'package:userspost/models/user/user_model.dart';
import 'package:userspost/pages/comments/comments_post_page.dart';
import 'package:userspost/widgets/buttons_drawer_widget.dart';
import 'package:userspost/widgets/sidebar_widget.dart';

class ListPostsPage extends StatefulWidget {
  final User arguments;

  ListPostsPage({Key key, this.arguments}) : super(key: key);
  static final routeName = 'listposts';

  @override
  _ListPostsPageState createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final searchInputController = TextEditingController();

  // final Post arguments = ModalRoute.of(context).settings.arguments;

  bool sortAscending;

  List<Post> posts;
  final PostListBloc _block = PostListBloc();

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
        _block.listPosts.sort((a, b) => a.title.compareTo(b.title));
      } else {
        _block.listPosts.sort((a, b) => b.title.compareTo(a.title));
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
                      // Navigator.pushNamed(context, 'registerpost');
                      Navigator.pushNamed(
                        context,
                        'registerpost',
                        arguments: widget.arguments,
                      );
                    },
                    color: Colors.blue,
                    child: Text('Añadir Post'),
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
              title: Text('Lista de posts'),
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
                      StreamBuilder<List<Post>>(
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
                                              label: Text('Ver Comentarios'),
                                              numeric: false,
                                              tooltip: 'Ver Comentarios',
                                            ),
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
                                                      Text(posts.title
                                                          // posts.title
                                                          //     .substring(1, 40),
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
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              CupertinoPageRoute(
                                                                builder: (context) =>
                                                                    CommentsPostsPage(
                                                                        arguments:
                                                                            posts),
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
