import 'package:pokedex/core/model/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/pokedex_repository.dart';
import 'package:riverpod/riverpod.dart';

class PokemonListState {
  List<PokemonModel> pokemons = [];
  final bool isLoading;
  int offset = 0;

  PokemonListState(
      {required this.pokemons, this.isLoading = false, required this.offset});

  PokemonListState copyWith({
    List<PokemonModel>? pokemons,
    bool? isLoading,
    int? offset,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
      offset: offset ?? this.offset,
    );
  }
}

class PokedexProvider extends StateNotifier<PokemonListState> {
  final PokemonRepository repository;

  PokedexProvider(this.repository)
      : super(PokemonListState(pokemons: [], offset: 0));

  Future<void> loadPokemons() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final pokemons = await repository.fetchPokemonList(state.offset, 20);

      state = PokemonListState(
        pokemons: [...state.pokemons, ...pokemons],
        isLoading: false,
        offset: state.offset + 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final pokemonListProvider =
    StateNotifierProvider<PokedexProvider, PokemonListState>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return PokedexProvider(repository);
});
