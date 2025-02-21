import 'package:flutter/material.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

class BaseStatsTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const BaseStatsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: pokemon.stats?.map((stat) {
        return SizedBox(
          height: 25,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  stat.stat?.name?.capitalize() ?? '',
                  style: PokedexTheme.labelGrey,
                ),
              ),
              SizedBox(
                width: 25,
                child: Text(
                  "${stat.baseStat ?? 0}",
                  style: PokedexTheme.labelBlack,
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: LinearProgressIndicator(
                  value: (stat.baseStat ?? 0) / 200,
                  color: PokedexTheme.getStatColor(stat.stat?.name ?? ''),
                  backgroundColor: Colors.grey[300],
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        );
      }).toList() ?? [],
    );
  }
}
