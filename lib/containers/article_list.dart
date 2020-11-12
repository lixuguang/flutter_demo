import 'package:flutter/material.dart';
import 'package:flutter_common/components/articles/article_item.dart';
import 'package:flutter_common/containers/drawer.dart';
import 'package:flutter_common/data_model/articles_state_model.dart';
import 'package:flutter_common/data_model/favors_state_model.dart';
import 'package:flutter_common/data_model/signin_state_model.dart';
import 'package:flutter_common/constants/my_colors.dart';
import 'package:flutter_common/models/article_model.dart';
import 'package:flutter_common/services/http_service.dart';

import '../data_model/signin_state_model.dart';

class ArticleList extends StatefulWidget {

  @override
  _ArticleListState createState() => _ArticleListState();

}

class _ArticleListState extends State<ArticleList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HttpService http = HttpService();

  bool showDialog = false;
  // curId = -1 to publish
  // curId > 0 to article
  String curId = '-1';

  @override
  void initState() {
    super.initState();
    http.getArticles().then((value)
      => ArticleStateWidget.of(context).updateArticles(value));
  }

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;
    final String userName = SignInStateWidget.of(context).signInUser;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Articles', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Builder(builder: (context) => Text('')),
        actions: [
          IconButton(
            icon: Icon(Icons.insert_comment),
            onPressed: () {
              Navigator.of(context).pushNamed('/hello-world');
            }
          )
        ],
      ),
      drawer: DrawerWidget(logout: () {}, userName: userName),
      body: _buildbody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: themeColor,
        onPressed: () {
          final String userName = _getUserName(context);
          if (userName.length > 0) {
            Navigator.of(context).pushNamed('/publish');
          } else {
            setState(() {
              showDialog = true;
              curId = '-1';
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.local_library, color: MyColors.black_99),
              onPressed: () {},
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.account_box, color: MyColors.black_99),
              onPressed: () {
                final String userName = _getUserName(context);
                if (userName.length > 0) {
                  _openDrawer();
                } else {
                  Navigator.of(context).pushNamed('/sign-in');
                }
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      )
    );
  }

  Widget _buildbody(BuildContext context) {
    return Stack(
      children: [
        _buildList(context),
        Visibility(
          visible: showDialog,
          child: Positioned(
            child: Container(
              child: _buildDialog(context),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .3)
              ),
            )
          )
        )
        /* if (showDialog) Positioned(
          child: Container(
            child: _buildDialog(context),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .3)
            ),
          )
        ) */
      ],
    );
  }

  ListView _buildList(BuildContext context) {
    final List<ArticleModel> articles = ArticleStateWidget.of(context).articles;
    final Function updateFavorId = FavorsStateWidget.of(context).updateFavorId;
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: ArticleItem(
            article: articles[index],
            updateFavorId: updateFavorId,
          ),
          onTap: () {
            final String userName = _getUserName(context);
            if (userName.length > 0) {
              Navigator.of(context)
                .pushNamed('/article', arguments: articles[index].id);
            } else {
              setState(() {
                showDialog = true;
                curId = articles[index].id;
              });
            }
          }
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 0.5,
        color: Colors.black26,
      )
    );
  }

  Center _buildDialog(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;
    return Center(
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Sign in to see more',
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  onPressed: () {
                    String id = curId;
                    setState(() {
                      showDialog = false;
                      curId = '-1';
                    });
                    Navigator.of(context)
                      .pushNamed('/sign-in', arguments: id);
                  },
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.cancel_outlined, color: MyColors.black_c4,),
                onPressed: () {
                  setState(() {
                    showDialog = false;
                  });
                }
              ),
            )
          ],
        ),
        width: 240.0,
        height: 160.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0)
        ),
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  String _getUserName(BuildContext context) {
    return SignInStateWidget.of(context).signInUser;
  }

  /* void _closeDrawer() {
    Navigator.of(context).pop();
  } */

}
