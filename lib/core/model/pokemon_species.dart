class PokemonSpecies {
  final int baseHappiness;
  final int captureRate;
  final ColorData color;
  final List<ColorData> eggGroups;
  final EvolutionChain evolutionChain;
  final List<FlavorTextEntry> flavorTextEntries;
  final List<Genus> genera;
  final ColorData generation;
  final ColorData growthRate;
  final ColorData habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;

  PokemonSpecies({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
    required this.evolutionChain,
    required this.flavorTextEntries,
    required this.genera,
    required this.generation,
    required this.growthRate,
    required this.habitat,
    required this.hasGenderDifferences,
    required this.hatchCounter,
    required this.id,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.name,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {
    return PokemonSpecies(
      baseHappiness: json['base_happiness'],
      captureRate: json['capture_rate'],
      color: ColorData.fromJson(json['color']),
      eggGroups: (json['egg_groups'] as List).map((e) => ColorData.fromJson(e)).toList(),
      evolutionChain: EvolutionChain.fromJson(json['evolution_chain']),
      flavorTextEntries: (json['flavor_text_entries'] as List).map((e) => FlavorTextEntry.fromJson(e)).toList(),
      genera: (json['genera'] as List).map((e) => Genus.fromJson(e)).toList(),
      generation: ColorData.fromJson(json['generation']),
      growthRate: ColorData.fromJson(json['growth_rate']),
      habitat: ColorData.fromJson(json['habitat']),
      hasGenderDifferences: json['has_gender_differences'],
      hatchCounter: json['hatch_counter'],
      id: json['id'],
      isBaby: json['is_baby'],
      isLegendary: json['is_legendary'],
      isMythical: json['is_mythical'],
      name: json['name'],
    );
  }
}

class ColorData {
  final String name;
  final String url;

  ColorData({required this.name, required this.url});

  factory ColorData.fromJson(Map<String, dynamic> json) {
    return ColorData(
      name: json['name'],
      url: json['url'],
    );
  }
}

class EvolutionChain {
  final String url;

  EvolutionChain({required this.url});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    return EvolutionChain(url: json['url']);
  }
}

class FlavorTextEntry {
  final String flavorText;
  final ColorData language;
  final ColorData version;

  FlavorTextEntry({required this.flavorText, required this.language, required this.version});

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) {
    return FlavorTextEntry(
      flavorText: json['flavor_text'],
      language: ColorData.fromJson(json['language']),
      version: ColorData.fromJson(json['version']),
    );
  }
}

class Genus {
  final String genus;
  final ColorData language;

  Genus({required this.genus, required this.language});

  factory Genus.fromJson(Map<String, dynamic> json) {
    return Genus(
      genus: json['genus'],
      language: ColorData.fromJson(json['language']),
    );
  }
}
