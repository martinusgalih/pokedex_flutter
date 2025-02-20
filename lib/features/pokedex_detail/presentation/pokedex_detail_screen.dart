import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex_detail/presentation/widgets/about_tab.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

class PokedexDetailScreen extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const PokedexDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Jumlah tab
      child: Scaffold(
        backgroundColor: PokedexTheme.getTypeColor(pokemon.types.first.type.name),
        appBar: AppBar(
          title: Text(pokemon.name.toUpperCase(), style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 4,
              child: Image.network(
                pokemon.sprites.frontDefault,
                width: 200,
                height: 200,
              ),
            ),

            // Sliding Panel
            SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.4, // Tinggi awal panel
              maxHeight: MediaQuery.of(context).size.height * 0.9, // Tinggi maksimal panel
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              panelBuilder: (scrollController) => Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.red,
                      tabs: [
                        Tab(text: "About"),
                        Tab(text: "Base Stats"),
                        Tab(text: "Evolution"),
                        Tab(text: "Moves"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AboutTab(pokemon: pokemon),
                          BaseStatsTab(pokemon: pokemon),
                          EvolutionTab(pokemon: pokemon),
                          MovesTab(pokemon: pokemon),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class BaseStatsTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const BaseStatsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: pokemon.stats.map((stat) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stat.stat.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
            LinearProgressIndicator(
              value: stat.baseStat / 100, // Normalize to 0 - 1
              color: Colors.red,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }
}

class EvolutionTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const EvolutionTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Evolution details not implemented yet!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }
}

class MovesTab extends StatelessWidget {
  final PokemonDetailModel pokemon;

  const MovesTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: pokemon.moves.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(pokemon.moves[index].move.name),
          leading: const Icon(Icons.sports_martial_arts),
        );
      },
    );
  }
}
