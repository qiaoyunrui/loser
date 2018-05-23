// global code

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final ThemeData gDefaultTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.orangeAccent[400],
);

final ThemeData gIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.green,
);

final String gAppName = "肥宅快乐生活";

class WrapperApp extends StatelessWidget {
  WrapperApp(this.content);

  final Widget content;

  build(context) {
    return new MaterialApp(
      title: gAppName,
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? gIOSTheme
          : gDefaultTheme,
      home: content,
    );
  }
}
