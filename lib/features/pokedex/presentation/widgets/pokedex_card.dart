import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/model/pokemon_model.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';
import 'package:pokedex/features/pokedex_detail/presentation/pokedex_detail_screen.dart';
import 'package:pokedex/features/pokedex_detail/provider/pokedex_detail_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class PokedexCard extends ConsumerWidget {
  final PokemonModel pokemon;

  const PokedexCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetail = ref.watch(pokemonDetailProvider(pokemon.url));

    return pokemonDetail.when(
      data: (detail) {
        final backgroundColor =
        PokedexTheme.getTypeColor(detail.types?.first.type?.name ?? '');
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokedexDetailScreen(pokemon: detail),
              ),
            );
          },
          child: Card(
            color: backgroundColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -95,
                  right: -80,
                  child: Opacity(
                    opacity: 0.15,
                    child: SvgPicture.asset(
                      'assets/images/pokeball_white.svg',
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name.toUpperCase(),
                        style: PokedexTheme.labelWhiteNormal,
                      ),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: detail.types?.map((type) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(bottom: 4),
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.network(
                    pokemon.imageUrl,
                    width: 100,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      error: (error, _) => const Center(child: Text("Something went wrong")),
    );
  }
}
