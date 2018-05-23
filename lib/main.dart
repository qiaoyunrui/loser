import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loser/chat_message.dart';
import 'package:loser/framework/global.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new WrapperApp(new ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _message = <ChatMessage>[];
  bool _isComposing = false;

  _handleSubmitted(String text) {
//    print('消息为 $text');
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
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
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? new CupertinoButton(
                      // iOS 平台上的按钮样式
                      child: new Text(
                        "发送",
                      ),
                      onPressed: _onSend(),
                    )
                  : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _onSend(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _onSend() =>
      _isComposing ? () => _handleSubmitted(_textController.text) : null;

  build(context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("肥宅快乐生活"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          // 设置阴影，ios 没有阴影，Android 上有阴影
        ),
        body: new Container(
          child: new Column(
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
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null,
        ));
  }

  dispose() {
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
