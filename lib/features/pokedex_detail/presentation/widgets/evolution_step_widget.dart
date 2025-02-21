
import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

class EvolutionStep {
  final String from;
  final String to;
  final int? level;

  EvolutionStep({required this.from, required this.to, this.level});
}

class EvolutionStepWidget extends StatelessWidget {
  final EvolutionStep step;

  const EvolutionStepWidget(this.step, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/pokeball_8bit.png", width: 18, height: 18),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(step.from, style: PokedexTheme.labelBlack),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "(${step.level != null ? 'Level ${step.level}' : 'Unknown'})",
              style: PokedexTheme.labelGrey,
            ),
          ),
          Image.asset("assets/images/pokeball_8bit.png", width: 18, height: 18),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(step.to, style: PokedexTheme.labelBlack),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}