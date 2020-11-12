

import 'package:flutter/material.dart';

class FavorsStateWidget extends InheritedWidget {

  final List<String> favorIds;
  final Function updateFavorId;

  FavorsStateWidget({
    @required this.favorIds,
    @required this.updateFavorId,
    Widget child
  }): super(child: child);

  static FavorsStateWidget of(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<FavorsStateWidget>().widget;
  }

  @override
  bool updateShouldNotify(FavorsStateWidget oldWidget) {
    return oldWidget.favorIds != favorIds;
  }

}