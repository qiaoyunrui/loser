import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loser/framework/bean.dart';

// 网络请求相关

var host = "118.89.49.184";
var sub_url = "/juhezi/index.php";

var client = new HttpClient();

typedef void Closure<T>(T t);

getIntactUrl(method) {
  return "http://$host$sub_url?method=$method";
}

main() {
  sendArticle("Hello", closure: (map) {});
}

sendArticle(String content,
    {String title = "无", String category = "无", Closure<Map> closure}) {
  http.post(getIntactUrl("create"), body: {
    "title": title,
    "content": content,
    "category": category
  }).then((response) {
    String json = response.body;
//    print(response.body);
    JsonDecoder decoder = new JsonDecoder();
    Map map = decoder.convert(json);
    if (closure != null) {
      closure(map);
    }
  });
}
