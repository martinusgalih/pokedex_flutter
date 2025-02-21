import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/model/pokemon_evolution_model.dart';
import 'package:pokedex/core/model/pokemon_species.dart';
import 'package:pokedex/core/network/api_service.dart';

final pokemonDetailProvider =
    FutureProvider.family<PokemonDetailModel, String>((ref, url) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(url);
  return PokemonDetailModel.fromJson(response.data);
});

final pokemonSpeciesProvider =
    FutureProvider.family<PokemonSpecies, int>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  final response =
      await apiService.get("https://pokeapi.co/api/v2/pokemon-species/$id");
  return PokemonSpecies.fromJson(response.data);
});

final evolutionChainProvider =
    FutureProvider.family<PokemonEvolutionModel, int>((ref, id) async {
  final pokemonSpecies = await ref.watch(pokemonSpeciesProvider(id).future);

  final evolutionChainUrl = pokemonSpecies.evolutionChain?.url;
  if (evolutionChainUrl == null) {
    throw Exception("Evolution chain not found for Pokémon ID: $id");
  }

  final evolutionId = int.parse(
    evolutionChainUrl.split('/').reversed.skip(1).first,
  );

  final apiService = ref.read(apiServiceProvider);
  final response = await apiService
      .get("https://pokeapi.co/api/v2/evolution-chain/$evolutionId");

  return PokemonEvolutionModel.fromJson(response.data);
});
