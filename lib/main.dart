import 'package:flutter/material.dart';
import 'package:loser/chat_message.dart';

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
  createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _message = <ChatMessage>[];

  _handleSubmitted(String text) {
//    print('消息为 $text');
    _textController.clear();
    if (text.trim().isEmpty) return;
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 700),
      ),
    );
    setState(() {
      _message.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: '发送消息'),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            )
          ],
        ),
      ),
    );
  }

  build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("死肥仔的日常"),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _message[index],
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _message.length,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }

  dispose() {
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
