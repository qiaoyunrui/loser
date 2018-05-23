import 'package:flutter/cupertino.dart';

/// add article
import 'package:flutter/material.dart';
import 'package:loser/framework/global.dart';

void main() {
  runApp(new WrapperApp(new Wrapper()));
}

class Wrapper extends StatelessWidget {
  /// 发送文章
  _onSend() {}

  build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("发布文章"),
        leading: new IconButton(
          tooltip: "返回",
          icon: new Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.send),
            tooltip: '发布',
            onPressed: _onSend,
          ),
        ],
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Container(),
    );
  }
}
