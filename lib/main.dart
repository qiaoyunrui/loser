import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new HomeApp();
  }
}

class HomeApp extends StatelessWidget {
  build(context) {
    return new MaterialApp(
      title: "loser",
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("死肥仔的日常"),
      ),
    );
  }
}
