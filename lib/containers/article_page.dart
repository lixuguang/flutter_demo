import 'package:flutter/material.dart';
import 'package:flutter_common/constants/my_colors.dart';
import 'package:flutter_common/data_model/articles_state_model.dart';
import 'package:flutter_common/models/article_model.dart';

class ArticlePage extends StatelessWidget {

  final String articleId;

  ArticlePage({ @required this.articleId });

  @override
  Widget build(BuildContext context) {
    final List<ArticleModel> articles = ArticleStateWidget.of(context).articles;
    final ArticleModel showArticle = articles.firstWhere(
      (element) => element.id == articleId
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(showArticle.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/publish', arguments: articleId);
            }
          )
        ],
      ),
      body: _buildBody(showArticle)
    );
  }

  Widget _buildBody(ArticleModel article) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12.0, bottom: 4.0),
              child: Text(
                article.title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: MyColors.black_33,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                article.author,
                style: TextStyle(
                  fontSize: 16.0,
                  color: MyColors.black_a8
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                article.content,
                style: TextStyle(
                  color: MyColors.black_66,
                  fontSize: 14.0
                ),
              )
            )
          ],
        )
      )
    );
  }

}