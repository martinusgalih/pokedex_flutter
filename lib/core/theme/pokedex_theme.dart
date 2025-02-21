import 'package:flutter/material.dart';

class PokedexTheme {
  static const Color gray = Color(0xFFB7B7CE);
  static const Color brown = Color(0xFFA8A77A);
  static const Color orange = Color(0xFFEE8130);
  static const Color blue = Color(0xFF6390F0);
  static const Color yellow = Color(0xFFF7D02C);
  static const Color green = Color(0xFF7AC74C);
  static const Color cyan = Color(0xFF96D9D6);
  static const Color red = Color(0xFFD43A30);
  static const Color purple = Color(0xFFA33EA1);
  static const Color darkPurple = Color(0xFF735797);
  static const Color orangeAccent = Color(0xFFE2BF65);
  static const Color indigo = Color(0xFFA98FF3);
  static const Color darkIndigo = Color(0xFF6F35FC);
  static const Color greenAccent = Color(0xFFA6B91A);
  static const Color pink = Color(0xFFF95587);
  static const Color pinkAccent = Color(0xFFD685AD);
  static const Color darkYellow = Color(0xFFB6A136);
  static const Color darkBrown = Color(0xFF705746);

  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return brown;
      case 'fire':
        return orange;
      case 'water':
        return blue;
      case 'electric':
        return yellow;
      case 'grass':
        return green;
      case 'ice':
        return cyan;
      case 'fighting':
        return red;
      case 'poison':
        return purple;
      case 'ground':
        return orangeAccent;
      case 'flying':
        return indigo;
      case 'bug':
        return greenAccent;
      case 'fairy':
        return pinkAccent;
      case 'psychic':
        return pink;
      case 'rock':
        return darkYellow;
      case 'dark':
        return darkBrown;
      case 'ghost':
        return darkPurple;
      case 'steel':
        return gray;
      case 'dragon':
        return darkIndigo;
      default:
        return Colors.black12;
    }
  }

  static Color getStatColor(String statName) {
    switch (statName.toLowerCase()) {
      case 'hp':
        return red;
      case 'attack':
        return orange;
      case 'defense':
        return blue;
      case 'special-attack':
        return purple;
      case 'special-defense':
        return green;
      case 'speed':
        return yellow;
      default:
        return gray;
    }
  }

  static const TextStyle labelGrey = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle labelBlack = TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  static const TextStyle labelWhiteLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: Colors.white,
  );

  static const TextStyle labelWhiteNormal = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle labelWhiteSmall = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.white,
  );
}
