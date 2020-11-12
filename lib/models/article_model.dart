class ArticleModel {
  final String id;
  final String title;
  final String author;
  final String content;
  final int thumbs;
  final int coins;
  final int favors;

  ArticleModel({
    this.id,
    this.title,
    this.author,
    this.content,
    this.thumbs,
    this.coins,
    this.favors
  });

  ArticleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        author = json['author'] as String,
        thumbs = json['thumbs'] as int,
        favors = json['favors'] as int,
        coins = json['coins'] as int,
        content = json['content'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'author': author,
    'content': content,
    'thumbs': thumbs,
    'favors': favors,
    'coins': coins,
  };
}
