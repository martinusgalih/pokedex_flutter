import 'package:pokedex/core/model/pokemon_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pokedex/core/network/api_service.dart';

class PokemonRepository {
  final ApiService _apiService;

  PokemonRepository(this._apiService);

  Future<List<PokemonModel>> fetchPokemonList(int offset, int limit) async {
    final response = await _apiService.get("pokemon", params: {
      "offset": offset,
      "limit": limit,
    });

    final List data = response.data["results"];
    return data.map((e) => PokemonModel.fromJson(e)).toList();
  }
}

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return PokemonRepository(apiService);
});
