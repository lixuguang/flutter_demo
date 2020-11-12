import 'package:flutter/material.dart';
import 'package:flutter_common/constants/my_colors.dart';

class ArticleHeader extends StatelessWidget {
  final String title;
  final String author;

  ArticleHeader({ @required this.title, @required this.author });

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: <Widget>[
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: MyColors.black_33
          )),
          Spacer(),
          Text(author, style: TextStyle(
            fontSize: 14,
            color: MyColors.black_33
          ))
        ]
      ),
      padding: EdgeInsets.symmetric(vertical: 4),
    );
  }
}
