import 'package:flutter/material.dart';
import 'package:flutter_common/routes/routes.dart';

import 'data_model/articles_state_model.dart';
import 'data_model/favors_state_model.dart';
import 'data_model/signin_state_model.dart';
import 'models/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String userName = '';
  List<ArticleModel> articles = [];
  List<String> favorIds = [];

  @override
  Widget build(BuildContext context) {
    return SignInStateWidget(
      signInUser: userName,
      setSignInUser: setUserName,
      child: ArticleStateWidget(
        articles: articles,
        updateArticles: updateArticles,
        child: FavorsStateWidget(
          favorIds: favorIds,
          updateFavorId: updateFavorId,
          child: MaterialApp(
            title: 'Flutter Common',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/articles',
            routes: routes
          )
        ),
      ),
    );
  }

  void setUserName(String name) {
    setState(() {
      userName = name;
    });
  }

  void updateArticles(List<ArticleModel> articles) {
    setState(() {
      this.articles = articles;
    });
  }

  void updateFavorId(String id) {
    setState(() {
      favorIds.contains(id)
        ? favorIds.remove(id)
        : favorIds.add(id);
    });
  }

}
