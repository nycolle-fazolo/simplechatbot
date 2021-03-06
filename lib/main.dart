import 'package:flutter/material.dart';
import 'package:simplechatbot/screens/chatbot.dart';
import 'package:simplechatbot/screens/todolist.dart';

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
      //home: ChatBotPage(),
    );
  }
}
