import 'package:demo2025/namer/namer_advanced.dart';
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
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (isFavorite()) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  bool isFavorite() {
    return favorites.contains(current);
  }
}

class NamerHomePage extends StatefulWidget {
  const NamerHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _NamerHomePageState();
}

class _NamerHomePageState extends State<NamerHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = NameGeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  //根据屏幕宽度自动决定是否拓展左侧导航栏
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorite'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: theme.colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
          floatingActionButton: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return NamerAppAdvanced();
            }));
          }, child: Text('Go to Advanced page')),
        );
      },
    );
  }
}

class NameGeneratorPage extends StatelessWidget {
  const NameGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NamerState>();
    var pair = appState.current;
    final icon = appState.isFavorite() ? Icons.favorite : Icons.favorite_border;
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('like'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NamerState>();
    var favorites = appState.favorites;
    if (favorites.isEmpty) {
      return Center(child: Text('No Favorites yet..'),);
    }
    return ListView(
      children: [
        Padding(padding: const EdgeInsets.all(20),
          child: Text('You have ${favorites.length} favorites:'),),
        for(var pair in favorites)
          ListTile(
            leading: Icon(Icons.favorite), title: Text(pair.asLowerCase),)
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
    Text(pair.asLowerCase);
  }
}
