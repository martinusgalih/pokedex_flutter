import 'package:pokedex/core/model/pokemon_species.dart';

class PokemonDetailModel {
  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final List<TypeElement>? types;
  final List<Ability>? abilities;
  final Cries? cries;
  final List<Move>? moves;
  final Sprites? sprites;
  final List<Stat>? stats;

  PokemonDetailModel({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.types,
    this.abilities,
    this.cries,
    this.moves,
    this.sprites,
    this.stats,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      types: (json['types'] as List?)
          ?.map((type) => TypeElement.fromJson(type))
          .toList(),
      abilities: (json['abilities'] as List?)
          ?.map((ability) => Ability.fromJson(ability))
          .toList(),
      cries: json['cries'] != null ? Cries.fromJson(json['cries']) : null,
      moves: (json['moves'] as List?)
          ?.map((move) => Move.fromJson(move))
          .toList(),
      sprites: json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null,
      stats: (json['stats'] as List?)
          ?.map((stat) => Stat.fromJson(stat))
          .toList(),
    );
  }
}

class Ability {
  final StringUrlData? ability;
  final bool? isHidden;
  final int? slot;

  Ability({this.ability, this.isHidden, this.slot});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability: json['ability'] != null ? StringUrlData.fromJson(json['ability']) : null,
      isHidden: json['is_hidden'] as bool?,
      slot: json['slot'] as int?,
    );
  }
}

class Move {
  final StringUrlData? move;

  Move({this.move});

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      move: json['move'] != null ? StringUrlData.fromJson(json['move']) : null,
    );
  }
}

class Cries {
  final String? latest;
  final String? legacy;

  Cries({this.latest, this.legacy});

  factory Cries.fromJson(Map<String, dynamic> json) {
    return Cries(
      latest: json['latest'] as String?,
      legacy: json['legacy'] as String?
    );
  }
}

class TypeElement {
  final int? slot;
  final StringUrlData? type;

  TypeElement({this.slot, this.type});

  factory TypeElement.fromJson(Map<String, dynamic> json) {
    return TypeElement(
      slot: json['slot'] as int?,
      type: json['type'] != null ? StringUrlData.fromJson(json['type']) : null,
    );
  }
}

class Sprites {
  final String? frontDefault;
  final String? frontShiny;
  final String? backDefault;
  final String? backShiny;
  final String? frontFemale;
  final String? frontShinyFemale;
  final String? backFemale;
  final String? backShinyFemale;

  final String? officialArtworkFrontDefault;
  final String? officialArtworkBackDefault;
  final String? dreamWorld;
  final String? homeFrontDefault;
  final String? homeFrontShiny;
  final String? showdownFrontDefault;
  final String? showdownBackDefault;
  final String? showdownFrontShiny;

  Sprites({
    this.frontDefault,
    this.frontShiny,
    this.backDefault,
    this.backShiny,
    this.frontFemale,
    this.frontShinyFemale,
    this.backFemale,
    this.backShinyFemale,
    this.officialArtworkFrontDefault,
    this.officialArtworkBackDefault,
    this.dreamWorld,
    this.homeFrontDefault,
    this.homeFrontShiny,
    this.showdownFrontDefault,
    this.showdownBackDefault,
    this.showdownFrontShiny,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'] as String?,
      frontShiny: json['front_shiny'] as String?,
      backDefault: json['back_default'] as String?,
      backShiny: json['back_shiny'] as String?,
      frontFemale: json['front_female'] as String?,
      frontShinyFemale: json['front_shiny_female'] as String?,
      backFemale: json['back_female'] as String?,
      backShinyFemale: json['back_shiny_female'] as String?,

      officialArtworkFrontDefault: json['other']?['official-artwork']?['front_default'] as String?,
      officialArtworkBackDefault: json['other']?['official-artwork']?['back_default'] as String?,
      dreamWorld: json['other']?['dream_world']?['front_default'] as String?,
      homeFrontDefault: json['other']?['home']?['front_default'] as String?,
      homeFrontShiny: json['other']?['home']?['front_shiny'] as String?,
      showdownFrontDefault: json['other']?['showdown']?['front_default'] as String?,
      showdownBackDefault: json['other']?['showdown']?['back_default'] as String?,
      showdownFrontShiny: json['other']?['showdown']?['front_shiny'] as String?,
    );
  }
}

class Stat {
  final int? baseStat;
  final int? effort;
  final StringUrlData? stat;

  Stat({this.baseStat, this.effort, this.stat});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'] as int?,
      effort: json['effort'] as int?,
      stat: json['stat'] != null ? StringUrlData.fromJson(json['stat']) : null,
    );
  }
}

