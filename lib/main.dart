import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fulluter App',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // リストに表示する単語のリスト
  final _suggestions = <WordPair>[];
  // お気に入りに登録された単語のセット
  final _saved = new Set<WordPair>();

  // 単語を表示させるテキストのスタイルの設定
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSeed),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

Widget _buildSuggestions() {
  return new ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemBuilder: (context, i) {
      if (i.isOdd) return new Divider();
      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    },
  );
}

Widget _buildRow(WordPair pair) {
  final alreadySaved = _saved.contains(pair);

  return new ListTile(
    title: new Text(
      pair.asPascalCase,
      style: _biggerFont,
    ),
    trailing: new Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),
    onTap: () {
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
        } else {
          _saved.add(pair);
        }
      });
    },
  );
}

void _pushSaved() {
  Navigation.of(context).push(new MaterialPageRoute(builder: (context) {
    final tiles = _saved.map((pair) {
      return new ListTile(
          title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ));
    });
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Saved suggestions'),
      ),
      body: new ListView(children: divided),
    );
  }));
}
