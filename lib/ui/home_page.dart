import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_with_sqlite/bloc/todo_data_bloc.dart';
import 'package:flutter_bloc_with_sqlite/model/todo_task.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  final TodoDataBloc _todoDataBloc = TodoDataBloc();

  final DismissDirection _onDismissedDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: getTodosDataWidget(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.indigoAccent,
                  size: 28,
                ),
                onPressed: () {
                  _todoDataBloc.getTodosData();
                },
              ),
              Expanded(
                child: Text(
                  "Todo",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Wrap(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.indigoAccent,
                        size: 28,
                      ),
                      onPressed: () {
                        _showTodoSearchSheet(context);
                      }),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: FloatingActionButton(
          elevation: 5.0,
          onPressed: () {
            _showAddTodoSheet(context);
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.indigoAccent,
          ),
        ),
      ),
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                              ),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: "i have to...",
                                labelText: "new Todo",
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty Description';
                                }
                                return value.contains('')
                                    ? "Do not use @ char"
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15.0),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.indigoAccent,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    final newTodo = Todo(
                                      description:
                                          _todoDescriptionController.value.text,
                                    );
                                    if (newTodo.description.isNotEmpty) {
                                      _todoDataBloc.addTodosData(newTodo);
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showTodoSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFromController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(10.0),
                      topLeft: const Radius.circular(10.0),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFromController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Search for Todo...',
                                  labelText: 'Search...',
                                  labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500,
                                  )),
                              validator: (String value) {
                                return value.contains('@')
                                    ? 'Do not use the @ char'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _todoDataBloc.getTodosData(
                                      query:
                                          _todoSearchDescriptionFromController
                                              .value.text);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getTodosDataWidget() {
    return StreamBuilder(
      stream: _todoDataBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodosDataCard(snapshot);
      },
    );
  }

  Widget getTodosDataCard(AsyncSnapshot<List<Todo>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemposition) {
                Todo todo = snapshot.data[itemposition];
                final Widget dismissableCard = new Dismissible(
                  key: new ObjectKey(todo),
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    _todoDataBloc.deleteTodosDataById(todo.id);
                  },
                  direction: _onDismissedDirection,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[200], width: 5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      leading: InkWell(
                        onTap: () {
                          todo.isDone = !todo.isDone;
                          _todoDataBloc.updateTodosData(todo);
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: todo.isDone
                                ? Icon(
                                    Icons.done,
                                    size: 26.0,
                                    color: Colors.indigoAccent,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 26.0,
                                    color: Colors.tealAccent,
                                  ),
                          ),
                        ),
                      ),
                      title: Text(
                        todo.description,
                        style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ),
                );
                return dismissableCard;
              },
            )
          : Container(
              child: Center(
                child: noTodosDataFound(),
              ),
            );
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    _todoDataBloc.getTodosData();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget noTodosDataFound() {
    return Container(
      child: Text(
        "Start Adding Todos...",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    _todoDataBloc.dispose();
  }
}
