import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemon/models/model_pokemon.dart';
import 'package:pokemon/screens/about/about.dart';
import 'package:pokemon/screens/home_page/homePage.dart';
import 'package:pokemon/screens/search/search.dart';

class RouterGenenrator {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (context) => AboutPage(
            data: (args as Pokemon),
          ),
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context) => SearchPage(
            data: (args as List<Pokemon>),
          ),
        );
    }
  }
}
