import 'package:flutter/material.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

class MovesTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const MovesTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemExtent: 50,
        itemCount: pokemon.moves?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pokemon.moves?[index].move?.name?.capitalize() ?? '', style: PokedexTheme.labelBlack),
            leading: const SizedBox(
              width: 18,
              height: 18,
              child: Image(image: AssetImage("assets/images/tm_move.png")),
            ),
          );
        },
      ),
    );
  }
}
