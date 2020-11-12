import 'package:flutter/material.dart';
import 'package:flutter_common/constants/my_colors.dart';

class Logo extends StatelessWidget {

  final BoxShape shape;
  final double size;

  Logo({ @required this.size, this.shape = BoxShape.rectangle });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(
        size: size
      ),
      decoration: BoxDecoration(
        shape: shape,
        color: MyColors.black_f2,
        boxShadow: [
          BoxShadow(
            color:Colors.black12,
            offset: Offset(0, 2.0),
            blurRadius: 4.0
          )
        ]
      ),
      padding: EdgeInsets.all(20.0),
    );
  }

}