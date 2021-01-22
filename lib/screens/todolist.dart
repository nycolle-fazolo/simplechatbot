import 'package:flutter/material.dart';
import 'package:simplechatbot/screens/chatbot.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _toDoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
        actions: <Widget>[
          IconButton(
            icon: new Image.asset("assets/robot-icon.jpg"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatBotPage();
              }));
            },
          )
        ],
        //
      ),
      body: ListView(
        children: _getItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
    //throw UnimplementedError();
  }

  Future<AlertDialog> _displayAddDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextFormField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Enter task ...'),
                autofocus: true),
            actions: <Widget>[
              OutlineButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              OutlineButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addToDoItem(_textFieldController.text);
                },
              )
            ],
          );
        });
  }

  Future<AlertDialog> _displayEditDialog(
      BuildContext context, int itemIndex) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit your task'),
            content: TextFormField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: _getItem(_textFieldController.text, itemIndex)),
              autofocus: true,
            ),
            actions: <Widget>[
              OutlineButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              OutlineButton(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _removeToDoItem(_textFieldController.text, itemIndex);
                },
              ),
              OutlineButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _updateToDoItem(_textFieldController.text, itemIndex);
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _toDoWidgets = <Widget>[];
    int index = 0;

    for (String title in _toDoList) {
      _toDoWidgets.add(_buildToDoItem(title, index));
      index++;
    }

    return _toDoWidgets;
  }

  String _getItem(String title, int index) {
    return _toDoList[index].toString();
  }

  Widget _buildToDoItem(String title, int index) {
    return Card(
      child: ListTile(
        //leading: Icon(Icons.edit, color: Colors.cyan,),
        title: Text(title),
        trailing: Icon(
          Icons.edit,
          color: Colors.cyan,
        ),
        onTap: () => _displayEditDialog(context, index),
      ),
    );
    //return ListTile(title: Text(title));
  }

  void _addToDoItem(String title) {
    setState(() {
      _toDoList.add(title);
    });
    _textFieldController.clear();
  }

  void _updateToDoItem(String title, int index) {
    setState(() {
      _toDoList[index] = title;
    });
    _textFieldController.clear();
  }

  void _removeToDoItem(String title, int index) {
    setState(() {
      _toDoList.removeAt(index);
    });
    _textFieldController.clear();
  }
}
