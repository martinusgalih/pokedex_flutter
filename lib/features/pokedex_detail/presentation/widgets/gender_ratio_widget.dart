import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

Widget buildGenderRatioRow(int genderRate) {
  double femalePercentage =
      (genderRate >= 0 && genderRate <= 8) ? (genderRate / 8) * 100 : 0.0;
  double malePercentage = 100 - femalePercentage;

  return Row(
    children: [
      const Icon(Icons.female, color: Colors.pink, size: 16),
      const SizedBox(width: 2),
      Text('${femalePercentage.toStringAsFixed(1)}%',
          style: PokedexTheme.labelBlack
      ),
      const SizedBox(width: 8),
      const Icon(Icons.male, color: Colors.blue, size: 16),
      const SizedBox(width: 2),
      Text('${malePercentage.toStringAsFixed(1)}%',
          style: PokedexTheme.labelBlack
      ),
    ],
  );
}
