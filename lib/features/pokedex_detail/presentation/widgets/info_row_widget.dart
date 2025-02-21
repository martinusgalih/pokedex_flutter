import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

Widget infoRow(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: PokedexTheme.labelGrey,
          ),
        ),
        Expanded(
          flex: 3,
          child: value is String
              ? Text(value,
              style: PokedexTheme.labelBlack)
              : value ?? const Text('-'),
        ),
      ],
    ),
  );
}