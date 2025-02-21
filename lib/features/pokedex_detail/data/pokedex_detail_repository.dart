import 'package:dio/dio.dart';
import 'package:pokedex/core/model/pokemon_evolution_model.dart';
import 'package:pokedex/core/model/pokemon_species.dart';

class PokedexDetailRepository {
  final Dio dio;

  PokedexDetailRepository(this.dio);

  Future<PokemonSpecies> fetchPokemonSpecies(int id) async {
    try {
      final response =
          await dio.get("https://pokeapi.co/api/v2/pokemon-species/$id");

      if (response.statusCode == 200) {
        return PokemonSpecies.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch Pokémon species");
      }
    } catch (e) {
      throw Exception("Error fetching Pokémon species: $e");
    }
  }

  Future<PokemonEvolutionModel> fetchEvolutionChain(int id) async {
    try {
      final response =
          await dio.get("https://pokeapi.co/api/v2/evolution-chain/$id");

      if (response.statusCode == 200) {
        return PokemonEvolutionModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch evolution chain");
      }
    } catch (e) {
      throw Exception("Error fetching evolution chain: $e");
    }
  }
}
