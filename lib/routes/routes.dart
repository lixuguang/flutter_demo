import 'package:flutter/material.dart';
import 'package:flutter_common/containers/article_list.dart';
import 'package:flutter_common/containers/article_page.dart';
import 'package:flutter_common/containers/favor_list.dart';
import 'package:flutter_common/containers/hello_world.dart';
import 'package:flutter_common/containers/publish_page.dart';
import 'package:flutter_common/containers/sign_in.dart';

Map<String, WidgetBuilder> routes = {
  '/articles': (context) => ArticleList(),
  '/article': (context) => ArticlePage(
    articleId: ModalRoute.of(context).settings.arguments
  ),
  '/favors': (context) => FavorList(),
  '/publish': (context) {
    final String id = ModalRoute.of(context).settings.arguments;
    return PublishPage(id: id);
  },
  '/sign-in': (context) => SignIn(),
  '/hello-world': (context) => HelloWorld()
};
