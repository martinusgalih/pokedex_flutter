import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/features/pokedex_detail/presentation/view/about_tab.dart';
import 'package:pokedex/features/pokedex_detail/presentation/view/base_stat_tab.dart';
import 'package:pokedex/features/pokedex_detail/presentation/view/evolution_tab.dart';
import 'package:pokedex/features/pokedex_detail/presentation/view/moves_tab.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';

class PokedexDetailScreen extends StatefulWidget {
  final PokemonDetailModel pokemon;

  PokedexDetailScreen({super.key, required this.pokemon});

  @override
  State<PokedexDetailScreen> createState() => _PokedexDetailScreenState();
}

class _PokedexDetailScreenState extends State<PokedexDetailScreen> {
  late final AudioPlayer _audioPlayer;
  double _pokemonOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCry() async {
    final cryUrl =
        widget.pokemon.cries?.latest ?? widget.pokemon.cries?.legacy ?? '';
    if (cryUrl.isEmpty) {
      return;
    }
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setSourceUrl(cryUrl);
      await _audioPlayer.resume();
    } catch (e) {
      print("Error playing cries: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: PokedexTheme.getTypeColor(
            widget.pokemon.types?.first.type?.name ?? ''),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  // TODO: Add action
                },
                icon: const Icon(Icons.favorite_border))
          ],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pokemon.name?.capitalize() ?? '',
                          style: PokedexTheme.labelWhiteLarge,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: widget.pokemon.types?.map((type) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                type.type?.name?.toUpperCase() ?? '',
                                style: PokedexTheme.labelWhiteSmall,
                              ),
                            );
                          }).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "#${widget.pokemon.id.toString().padLeft(3, '0')}",
                    style: PokedexTheme.labelWhiteLarge,
                  ),
                ],
              ),

            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              right: -180,
              child: Opacity(
                opacity: 0.15,
                child: SvgPicture.asset(
                  'assets/images/pokeball_white.svg',
                  width: 700,
                  height: 700,
                ),
              ),
            ),
            SlidingUpPanel(
              onPanelSlide: (position) {
                setState(() {
                  _pokemonOpacity = 1 - position;
                });
              },
              minHeight: MediaQuery.of(context).size.height * 0.4,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
                      indicatorColor: Colors.blueAccent,
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
                          AboutTab(pokemon: widget.pokemon),
                          BaseStatsTab(pokemon: widget.pokemon),
                          EvolutionTab(id: widget.pokemon.id ?? 0),
                          MovesTab(pokemon: widget.pokemon),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  _playCry();
                },
                child: AnimatedOpacity(
                  opacity: _pokemonOpacity,
                  duration: const Duration(milliseconds: 200),
                  child: Align(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Image.network(
                        widget.pokemon.sprites?.officialArtworkFrontDefault ??
                            '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}