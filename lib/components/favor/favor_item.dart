import 'package:flutter/material.dart';
import 'package:flutter_common/components/articles/article_header.dart';
import 'package:flutter_common/models/article_model.dart';

class FavorItem extends StatelessWidget {

  final ArticleModel article;

  FavorItem({ @required this.article });

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          ArticleHeader(
            title: article.title,
            author: article.author
          ),
          _buildContent(context)
        ],
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Text(
        article.content,
        style: const TextStyle(
          height: 1.4,
          fontSize: 13
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
    );
  }
}
