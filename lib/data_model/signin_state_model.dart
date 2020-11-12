import 'package:flutter/material.dart';

class SignInStateWidget extends InheritedWidget {

  final String signInUser;
  final Function setSignInUser;

  SignInStateWidget({
    @required this.signInUser,
    @required this.setSignInUser,
    Widget child
  }): super(child: child);

  static SignInStateWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SignInStateWidget>();
  }

  @override
  bool updateShouldNotify(SignInStateWidget oldWidget) {
    return oldWidget.signInUser != signInUser;
  }

}