import 'package:flutter/material.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/model/pokemon_species.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';
import 'package:pokedex/features/pokedex_detail/presentation/widgets/gender_ratio_widget.dart';
import 'package:pokedex/features/pokedex_detail/presentation/widgets/info_row_widget.dart';
import 'package:pokedex/features/pokedex_detail/provider/pokedex_detail_provider.dart';
import 'package:shimmer/shimmer.dart';

class AboutTab extends ConsumerWidget {
  final PokemonDetailModel pokemon;

  const AboutTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesAsync = ref.watch(pokemonSpeciesProvider(pokemon.id ?? 0));

    return speciesAsync.when(
      data: (species) => Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getFlavorText(species),
                style: PokedexTheme.labelBlack,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow("Name", species.name?.capitalize() ?? ''),
                  infoRow("Base Happiness", species.baseHappiness.toString()),
                  infoRow("Capture Rate", species.captureRate.toString()),
                  infoRow("Color", species.color?.name?.capitalize() ?? ''),
                  infoRow(
                      "Legendary", species.isLegendary ?? false ? "Yes" : "No"),
                  infoRow("Mythical", species.isMythical ?? false ? "Yes" : "No"),
                  infoRow("Height", "${(pokemon.height ?? 0) / 10} m"),
                  infoRow("Weight", "${(pokemon.weight ?? 0) / 10} kg"),
                  infoRow(
                    "Egg Groups",
                    species.eggGroups
                            ?.map((e) => e.name?.capitalize())
                            .join(', ') ??
                        '',
                  ),
                  infoRow(
                    "Abilities",
                    pokemon.abilities
                            ?.map((e) => e.ability?.name?.capitalize())
                            .join(', ') ??
                        '',
                  ),
                  infoRow("Gender Ratio",
                      buildGenderRatioRow(species.genderRate ?? 0)),
                  infoRow("Growth Rate", species.growthRate?.name?.capitalize()),
                  infoRow("Habitat", species.habitat?.name?.capitalize()),
                  infoRow("Shape", species.shape?.name?.capitalize()),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      loading: () => _buildShimmerLoading(),
      error: (err, _) =>
          Text("Error: $err", style: const TextStyle(color: Colors.red)),
    );
  }

  String getFlavorText(PokemonSpecies species) {
    final entry = species.flavorTextEntries?.firstWhere(
      (e) => e.language?.name == "en",
      orElse: () => FlavorTextEntry(
          flavorText: "",
          language: StringUrlData(name: "en", url: ""),
          version: StringUrlData(name: "", url: "")),
    );

    return entry?.flavorText?.replaceAll("\n", " ") ??
        "No description available";
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(width: double.infinity, height: 50),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(8, (_) => _shimmerRow()),
          ),
        ],
      ),
    );
  }

  Widget _shimmerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          _shimmerBox(width: 100, height: 16),
          const SizedBox(width: 20),
          _shimmerBox(width: 150, height: 16),
        ],
      ),
    );
  }

  Widget _shimmerBox({double width = 100, double height = 16}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
