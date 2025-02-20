import 'package:flutter/cupertino.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';

class AboutTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const AboutTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Height: ${pokemon.height / 10} m", style: const TextStyle(fontSize: 16)),
          Text("Weight: ${pokemon.weight / 10} kg", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          const Text("Abilities:", style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pokemon.abilities
                .map((ability) => Text("• ${ability.ability.name}"))
                .toList(),
          ),
        ],
      ),
    );
  }
}