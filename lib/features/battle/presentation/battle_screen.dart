import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/extension/string_extensions.dart';
import 'package:pokedex/core/model/pokemon_detail_model.dart';
import 'package:pokedex/core/theme/pokedex_theme.dart';
import 'package:pokedex/features/battle/presentation/widgets/shake_animation.dart';
import 'package:pokedex/features/pokedex_detail/provider/pokedex_detail_provider.dart';
import 'package:flutter/widgets.dart';

class BattleScreen extends ConsumerStatefulWidget {
  final PokemonDetailModel playerPokemon;

  const BattleScreen({super.key, required this.playerPokemon});

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen>
    with SingleTickerProviderStateMixin {
  late int playerHP;
  int? enemyHP;
  bool isPlayerTurn = true;
  final Random _random = Random();
  late AnimationController _shakeController;
  int? lastPlayerDamage;
  int? lastEnemyDamage;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playerHP = getStatValue('hp');
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _audioPlayer.stop();
    super.dispose();
  }

  Future<void> _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/pokemon_battle.mp3'));
  }

  void _attack(int enemyMaxHP, int enemyAttack, PokemonDetailModel rayquaza) {
    if (enemyHP == null || enemyHP! <= 0 || playerHP <= 0) return;

    if (isPlayerTurn) {
      setState(() {
        int damage = (_random.nextDouble() * getStatValue('attack')).toInt();
        enemyHP = (enemyHP! - damage).clamp(0, enemyMaxHP);
        lastPlayerDamage = damage;
        lastEnemyDamage = null;
        _shakeController.forward(from: 0);
      });

      if (enemyHP! <= 0) {
        _showResultDialog("You won!");
        return;
      }

      Future.delayed(const Duration(seconds: 1), () {
        if (enemyHP! > 0) {
          setState(() => isPlayerTurn = false);
          _enemyAttack(enemyMaxHP, getEnemyStatValue('hp', rayquaza));
        }
      });
    }
  }

  void _enemyAttack(int enemyMaxHP, int enemyAttack) {
    Future.delayed(const Duration(seconds: 1), () {
      if (playerHP > 0) {
        setState(() {
          int damage = (_random.nextDouble() * enemyAttack).toInt();
          playerHP = (playerHP - damage).clamp(0, getStatValue('hp'));
          lastEnemyDamage = damage;
          lastPlayerDamage = null;
          _shakeController.forward(from: 0);
        });

        if (playerHP <= 0) {
          _showResultDialog("You lost!");
          return;
        }

        Future.delayed(const Duration(seconds: 1), () {
          setState(() => isPlayerTurn = true);
        });
      }
    });
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  result,
                  style:
                      PokedexTheme.labelP2pMedium.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                  ),
                  child: Text(
                    'OK',
                    style: PokedexTheme.labelP2pMedium
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int getStatValue(String statName) {
    return widget.playerPokemon.stats
            ?.firstWhere(
              (s) => s.stat?.name == statName,
              orElse: () => Stat(baseStat: 100),
            )
            .baseStat ??
        100;
  }

  int getEnemyStatValue(String statName, PokemonDetailModel pokemon) {
    return pokemon.stats
        ?.firstWhere(
          (s) => s.stat?.name == statName,
      orElse: () => Stat(baseStat: 100),
    ).baseStat ?? 100;
  }



  @override
  Widget build(BuildContext context) {
    final enemyPokemon = ref.watch(
        pokemonDetailProvider('https://pokeapi.co/api/v2/pokemon/rayquaza'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/battle_background_night.png',
              fit: BoxFit.cover,
            ),
          ),
          enemyPokemon.when(
            data: (rayquaza) {
              enemyHP ??= getEnemyStatValue('hp', rayquaza);
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      ShakeAnimation(
                        controller: _shakeController,
                        child: _buildPokemon(
                            rayquaza.name ?? '',
                            rayquaza.sprites?.frontDefault,
                            enemyHP ?? 100,
                            getEnemyStatValue('hp', rayquaza),
                            false),
                      ),
                      if (lastPlayerDamage != null || lastEnemyDamage != null)
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              if (lastPlayerDamage != null)
                                Text(
                                  "You hit Rayquaza with $lastPlayerDamage damage!",
                                  style: PokedexTheme.labelP2pSmall,
                                ),
                              if (lastEnemyDamage != null)
                                Text(
                                  "Rayquaza hit you with $lastEnemyDamage damage!",
                                  style: PokedexTheme.labelP2pSmall,
                                ),
                            ],
                          ),
                        ),
                      const Spacer(),
                    ],
                  ),
                  Column(
                    children: [
                      const Spacer(),
                      ShakeAnimation(
                        controller: _shakeController,
                        child: _buildPokemon(
                            widget.playerPokemon.name ?? "Player",
                            widget.playerPokemon.sprites?.backDefault,
                            playerHP,
                            getStatValue('hp'),
                            true),
                      ),
                      ElevatedButton(
                        onPressed: isPlayerTurn
                            ? () =>
                            _attack(getEnemyStatValue('hp', rayquaza), getStatValue('attack'), rayquaza)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PokedexTheme.orange,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(isPlayerTurn ? "Attack" : "Enemy's Turn"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                ]
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text("Error loading enemy: $err")),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemon(
      String name, String? spriteUrl, int hp, int maxHp, bool isPlayerPokemon) {
    return Row(
      mainAxisAlignment:
          isPlayerPokemon ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (!isPlayerPokemon) const Spacer(),
        Padding(
          padding: isPlayerPokemon
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          child: Column(
            crossAxisAlignment: isPlayerPokemon
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.capitalize(),
                      style: PokedexTheme.labelP2pLarge,
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 10,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[300],
                          ),
                        ),
                        Container(
                          width: (120 * (hp / maxHp)).clamp(0, 120),
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: hp > maxHp * 0.5
                                ? Colors.green
                                : (hp > maxHp * 0.2
                                    ? Colors.yellow
                                    : Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "HP: $hp / $maxHp",
                      style: PokedexTheme.labelP2pSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (spriteUrl != null)
                Image.network(
                  spriteUrl,
                  width: isPlayerPokemon ? 150 : 100,
                  height: isPlayerPokemon ? 150 : 100,
                  filterQuality: FilterQuality.none,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
            ],
          ),
        ),
        if (isPlayerPokemon) const Spacer(),
      ],
    );
  }
}
