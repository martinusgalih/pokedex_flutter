import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/network/api_service.dart';

final pokemonDetailProvider = FutureProvider.family<PokemonDetailModel, String>((ref, url) async {
  final apiService = ref.read(apiServiceProvider);
  final response = await apiService.get(url);
  return PokemonDetailModel.fromJson(response.data);
});
