import 'package:demo2025/utils/logger.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NamerApp());
}

class NamerApp extends StatelessWidget {
  const NamerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NamerState(),
      child: MaterialApp(
        title: "Namer",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: NamerHomePage(),
      ),
    );
  }
}

class NamerState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class NamerHomePage extends StatelessWidget {
  const NamerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NamerState>();
    var pair = appState.current;
    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Card(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase),
      ),
    );
    Text(pair.asLowerCase);
  }
}
