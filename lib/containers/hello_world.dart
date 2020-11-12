
import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return Text('Hello World');
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }

}

/* class HelloWorld extends StatefulWidget {

  @override
  _HelloWorldState createState() => _HelloWorldState();

}

class _HelloWorldState extends State<HelloWorld> {

  String comment = 'World';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $comment'),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton.icon(
          icon: Icon(Icons.send),
          label: Text('send'),
          onPressed: () {
            setState(() {
              comment = 'There';
            });
          },
        )
      ),
    );
  }
} */