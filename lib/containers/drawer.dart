import 'package:flutter/material.dart';
import 'package:flutter_common/components/logo/logo.dart';
import 'package:flutter_common/data_model/signin_state_model.dart';
import 'package:flutter_common/constants/my_colors.dart';

class DrawerWidget extends StatelessWidget {

  final Function logout;
  final String userName;

  DrawerWidget({ @required this.logout, @required this.userName });

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildList(context)
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 64.0, right: 16.0, bottom: 30.0, left: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(size: 60.0, shape: BoxShape.circle),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'ShadowTricker',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final Color iconColor = MyColors.black_99;
    return Column(
      children: [
        ListTile(
          title: Text(
            'Favorite',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.black_66
            )
          ),
          leading: Icon(Icons.bookmark_border_outlined, color: iconColor),
          onTap: () {
            Navigator.of(context).pushNamed('/favors');
          },
        ),
        ListTile(
          title: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.black_66
            )
          ),
          leading: Icon(Icons.logout, color: iconColor),
          onTap: () {
            SignInStateWidget.of(context).setSignInUser('');
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

}