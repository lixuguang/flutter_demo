

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_common/components/shadow_button/shadow_button.dart';
import 'package:flutter_common/data_model/articles_state_model.dart';
import 'package:flutter_common/models/article_model.dart';
import 'package:flutter_common/services/http_service.dart';

class PublishPage extends StatelessWidget {

  final String id;
  final HttpService http = HttpService();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _author = TextEditingController();
  final TextEditingController _content = TextEditingController();

  PublishPage({ @required this.id });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id != null ? 'Edit' : 'Add'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (id != null) {
      final List<ArticleModel> articles = ArticleStateWidget.of(context).articles;
      final ArticleModel showArticle = articles.firstWhere(
        (element) => element.id == id
      );
      _title.text = showArticle.title;
      _author.text = showArticle.author;
      _content.text = showArticle.content;
    }
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _title,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Article Title',
                    hintText: 'Article Title'
                  ),
                  validator: (v) => v.trim().length > 0
                    ? null
                    : 'Please input a title.'
                ),
                TextFormField(
                  controller: _author,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Author',
                    hintText: 'Author'
                  ),
                  validator: (v) => v.trim().length > 0
                    ? null
                    : 'Please input an author\'s name.'
                ),
                TextFormField(
                  controller: _content,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    hintText: 'Content',
                    alignLabelWithHint: true
                  ),
                  maxLines: 10,
                  validator: (v) => v.trim().length > 0
                    ? null
                    : 'Please input article content.',
                ),
                _mySigninButton()
              ],
            )
          )
        )
      )
    );
    /* return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _title,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Article Title',
                hintText: 'Article Title'
              )
            ),
            TextField(
              controller: _author,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Author',
                hintText: 'Author'
              )
            ),
            TextField(
              controller: _content,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Content',
                hintText: 'Content',
                alignLabelWithHint: true
              ),
              maxLines: 10,
            ),
            _mySigninButton()
          ],
        )
      ),
    ); */
  }

  Widget _mySigninButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Builder(
        builder: (BuildContext context) {
          final updateArticles = ArticleStateWidget.of(context).updateArticles;
          return ShadowButton(
            text: 'PUBLISH',
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),
            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12.0),
            borderRadius: BorderRadius.circular(60.0),
            onPressed: () async {
              final ArticleModel newArticle = ArticleModel(
                id: id,
                title: _title.text,
                author: _author.text,
                content: _content.text
              );
              bool isSuccess = id != null
                ? await http.updateArticle(id: id, article: newArticle)
                : await http.postArticles(article: newArticle);
              if (isSuccess) {
                final articles = await http.getArticles();
                await updateArticles(articles);
                Navigator.of(context).pushReplacementNamed('/articles');
              }
            },
          );
        }
      )
    );
  }

}