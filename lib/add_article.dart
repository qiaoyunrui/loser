import 'package:flutter/cupertino.dart';

/// add article
import 'package:flutter/material.dart';
import 'package:loser/framework/global.dart';
import 'package:loser/framework/vincent.dart';

void main() {
  runApp(new WrapperApp(new Wrapper()));
}

class Wrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final TextEditingController _textController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _contentValid = false;

  /// 发送文章
  _onSend() {
    return _contentValid ? () => _handleSubmitted(_textController.text) : null;
  }

  _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _contentValid = false;
    });
    sendArticle(text, closure: (map) {
      if (map['code'] == 0) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("发布成功~😄"),
        ));
      } else {
        print(map['message']);
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("发送失败了~😞"),
        ));
      }
    });
  }

  build(context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("发布想法"),
        leading: new IconButton(
          tooltip: "返回",
          icon: new Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.send),
            tooltip: '发布',
            onPressed: _onSend(),
          ),
        ],
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: new TextField(
          onSubmitted: _handleSubmitted,
          controller: _textController,
          maxLength: 140,
          maxLines: null,
          // 行数无限制
          onChanged: (content) {
            setState(() {
              _contentValid = content.trim().length != 0;
            });
          },
          decoration: new InputDecoration(
            labelText: '想法',
            hintText: '说点什么吧...',
            helperText: '要说真话喔',
          ),
        ),
      ),
    );
  }
}
