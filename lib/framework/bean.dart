/// 实体类

class Article {
  String id;
  String title;
  String content;
  String date;
  String category;

  Article(this.content, {this.id, this.title, this.date, this.category});
}

class Result<T> {
  /// code:
  /// 0 - 成功
  /// 1 - 失败

  int code;

  String message;

  T data;
}
