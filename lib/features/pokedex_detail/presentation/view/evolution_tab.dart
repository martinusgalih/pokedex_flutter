import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/core/model/pokemon_evolution_model.dart';
import 'package:pokedex/features/pokedex_detail/presentation/widgets/evolution_step_shimmer.dart';
import 'package:pokedex/features/pokedex_detail/presentation/widgets/evolution_step_widget.dart';
import 'package:pokedex/features/pokedex_detail/provider/pokedex_detail_provider.dart';

class EvolutionTab extends ConsumerWidget {
  final int id;

  const EvolutionTab({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evolutionAsync = ref.watch(evolutionChainProvider(id));

    return evolutionAsync.when(
      data: (evolutionModel) {
        List<EvolutionStep> evolutionSteps =
            _extractEvolutionSteps(evolutionModel.chain);

        return ListView.builder(
          itemCount: evolutionSteps.length,
          itemBuilder: (context, index) {
            final step = evolutionSteps[index];
            return EvolutionStepWidget(step);
          },
        );
      },
      loading: () => ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => const EvolutionStepShimmer(),
      ),
      error: (e, _) => Center(child: Text("Error loading evolution data: $e")),
    );
  }

  List<EvolutionStep> _extractEvolutionSteps(EvolutionChain chain) {
    List<EvolutionStep> steps = [];

    for (var evolution in chain.evolvesTo) {
      steps.add(EvolutionStep(
        from: chain.name.capitalize(),
        to: evolution.name.capitalize(),
        level: evolution.evolutionDetails.isNotEmpty
            ? evolution.evolutionDetails.first.minLevel
            : null,
      ));
      steps.addAll(_extractEvolutionSteps(evolution));
    }
    return steps;
  }
}
