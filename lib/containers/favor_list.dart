import 'package:flutter/material.dart';
import 'package:flutter_common/components/favor/favor_item.dart';
import 'package:flutter_common/data_model/articles_state_model.dart';
import 'package:flutter_common/data_model/favors_state_model.dart';
import 'package:flutter_common/models/article_model.dart';

class FavorList extends StatefulWidget {

  @override
  _FavorListState createState() => _FavorListState();

}

class _FavorListState extends State<FavorList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _buildbody(context),
    );
  }

  Widget _buildbody(BuildContext context) {
    final List<String> favorIds = FavorsStateWidget.of(context).favorIds;
    final List<ArticleModel> articles = ArticleStateWidget.of(context).articles;
    /* final favorArticles = articles.where((ArticleModel article) {
      return article.id == '2';
    }).toList(); */
    List<ArticleModel> favorArticles = [];
    favorIds.forEach((String id) {
      articles.forEach((article) {
        if (article.id == id) {
          favorArticles.add(article);
        }
      });
    });
    print(favorArticles);
    return ListView.separated(
      itemCount: favorArticles.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: FavorItem(article: favorArticles[index]),
          onTap: () {
            Navigator.of(context).pushNamed(
              '/article',
              arguments: favorArticles[index].id
            );
          }
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 0.5,
        color: Colors.black26,
      )
    );
  }

}
