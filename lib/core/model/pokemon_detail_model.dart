class PokemonDetailModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<TypeElement> types;
  final List<Ability> abilities;
  final List<Move> moves;
  final Sprites sprites;
  final List<Stat> stats;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.sprites,
    required this.stats,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => TypeElement.fromJson(type))
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => Ability.fromJson(ability))
          .toList(),
      moves:
          (json['moves'] as List).map((move) => Move.fromJson(move)).toList(),
      sprites: Sprites.fromJson(json['sprites']),
      stats:
          (json['stats'] as List).map((stat) => Stat.fromJson(stat)).toList(),
    );
  }
}

class Ability {
  final Species ability;
  final bool isHidden;
  final int slot;

  Ability({required this.ability, required this.isHidden, required this.slot});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability: Species.fromJson(json['ability']),
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }
}

class Move {
  final Species move;

  Move({required this.move});

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      move: Species.fromJson(json['move']),
    );
  }
}

class TypeElement {
  final int slot;
  final Species type;

  TypeElement({required this.slot, required this.type});

  factory TypeElement.fromJson(Map<String, dynamic> json) {
    return TypeElement(
      slot: json['slot'],
      type: Species.fromJson(json['type']),
    );
  }
}

class Species {
  final String name;
  final String url;

  Species({required this.name, required this.url});

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }
}

class Sprites {
  final String frontDefault;
  final String? frontShiny;

  Sprites({required this.frontDefault, this.frontShiny});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }
}

class Stat {
  final int baseStat;
  final int effort;
  final Species stat;

  Stat({required this.baseStat, required this.effort, required this.stat});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: Species.fromJson(json['stat']),
    );
  }
}
