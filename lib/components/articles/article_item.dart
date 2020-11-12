import 'package:flutter/material.dart';
import 'package:flutter_common/models/article_model.dart';

import 'article_footer.dart';
import 'article_header.dart';

class ArticleItem extends StatelessWidget {

  final ArticleModel article;
  final Function updateFavorId;

  ArticleItem({ @required this.article, this.updateFavorId });

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          ArticleHeader(title: article.title, author: article.author),
          _buildContent(context),
          ArticleFooter(articleId: article.id, updateFavorIds: updateFavorId)
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
      padding: EdgeInsets.only(top: 4.0),
    );
  }
}
