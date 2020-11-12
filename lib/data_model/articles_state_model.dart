

import 'package:flutter/material.dart';
import 'package:flutter_common/models/article_model.dart';

class ArticleStateWidget extends InheritedWidget {

  final List<ArticleModel> articles;
  final Function updateArticles;

  ArticleStateWidget({
    @required this.articles,
    @required this.updateArticles,
    Widget child
  }): super(child: child);

  static ArticleStateWidget of(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<ArticleStateWidget>().widget;
  }

  @override
  bool updateShouldNotify(ArticleStateWidget oldWidget) {
    return oldWidget.articles != articles;
  }

}