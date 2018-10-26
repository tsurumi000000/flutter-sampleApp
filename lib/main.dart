import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final WordPair = new WordPair.random()
    return MaterialApp(
      title: 'welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
      ),
        body: new Center(
          child: new Text(wordPair.asPascalCase),
        ),
      )
    )
  }
}