import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokedex/domain/pokedex_provider.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokedex_card.dart';
import 'package:shimmer/shimmer.dart';

class PokedexScreen extends ConsumerStatefulWidget {
  const PokedexScreen({super.key});

  @override
  ConsumerState<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends ConsumerState<PokedexScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    Future.microtask(
            () => ref.read(pokemonListProvider.notifier).loadPokemons());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(pokemonListProvider.notifier).loadPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListState = ref.watch(pokemonListProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 650 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: pokemonListState.pokemons.isEmpty && pokemonListState.isLoading
          ? _buildShimmerGrid(crossAxisCount)
          : Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 12, right: 12),
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              ),
              itemCount: pokemonListState.pokemons.length,
              itemBuilder: (context, index) {
                return PokedexCard(
                    pokemon: pokemonListState.pokemons[index]);
              },
            ),
          ),
          if (pokemonListState.isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildShimmerLoading(),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 12, right: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 120,
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
