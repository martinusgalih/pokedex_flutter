class PokemonSpecies {
  final int? baseHappiness;
  final int? captureRate;
  final StringUrlData? color;
  final List<StringUrlData>? eggGroups;
  final EvolutionChain? evolutionChain;
  final List<FlavorTextEntry>? flavorTextEntries;
  final List<Genus>? genera;
  final StringUrlData? generation;
  final StringUrlData? growthRate;
  final StringUrlData? habitat;
  final StringUrlData? shape;
  final bool? hasGenderDifferences;
  final int? genderRate;
  final int? hatchCounter;
  final int id;
  final bool? isBaby;
  final bool? isLegendary;
  final bool? isMythical;
  final String? name;

  PokemonSpecies({
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.eggGroups,
    this.evolutionChain,
    this.flavorTextEntries,
    this.genera,
    this.generation,
    this.growthRate,
    this.habitat,
    this.shape,
    this.hasGenderDifferences,
    this.genderRate,
    this.hatchCounter,
    required this.id,
    this.isBaby,
    this.isLegendary,
    this.isMythical,
    this.name,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {
    return PokemonSpecies(
      baseHappiness: json['base_happiness'] as int?,
      captureRate: json['capture_rate'] as int?,
      color: json['color'] != null ? StringUrlData.fromJson(json['color']) : null,
      eggGroups: (json['egg_groups'] as List?)
          ?.map((e) => StringUrlData.fromJson(e))
          .toList(),
      evolutionChain: json['evolution_chain'] != null
          ? EvolutionChain.fromJson(json['evolution_chain'])
          : null,
      flavorTextEntries: (json['flavor_text_entries'] as List?)
          ?.map((e) => FlavorTextEntry.fromJson(e))
          .toList(),
      genera: (json['genera'] as List?)?.map((e) => Genus.fromJson(e)).toList(),
      generation: json['generation'] != null
          ? StringUrlData.fromJson(json['generation'])
          : null,
      growthRate:
      json['growth_rate'] != null ? StringUrlData.fromJson(json['growth_rate']) : null,
      habitat: json['habitat'] != null ? StringUrlData.fromJson(json['habitat']) : null,
      shape: json['shape'] != null ? StringUrlData.fromJson(json['shape']) : null,
      hasGenderDifferences: json['has_gender_differences'] as bool?,
      genderRate: json['gender_rate'] as int?,
      hatchCounter: json['hatch_counter'] as int?,
      id: json['id'] as int,
      isBaby: json['is_baby'] as bool?,
      isLegendary: json['is_legendary'] as bool?,
      isMythical: json['is_mythical'] as bool?,
      name: json['name'] as String?,
    );
  }
}

class StringUrlData {
  final String? name;
  final String? url;

  StringUrlData({this.name, this.url});

  factory StringUrlData.fromJson(Map<String, dynamic> json) {
    return StringUrlData(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }
}

class EvolutionChain {
  final String? url;

  EvolutionChain({this.url});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    return EvolutionChain(url: json['url'] as String?);
  }
}

class FlavorTextEntry {
  final String? flavorText;
  final StringUrlData? language;
  final StringUrlData? version;

  FlavorTextEntry({this.flavorText, this.language, this.version});

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) {
    return FlavorTextEntry(
      flavorText: json['flavor_text'] as String?,
      language: json['language'] != null ? StringUrlData.fromJson(json['language']) : null,
      version: json['version'] != null ? StringUrlData.fromJson(json['version']) : null,
    );
  }
}

class Genus {
  final String? genus;
  final StringUrlData? language;

  Genus({this.genus, this.language});

  factory Genus.fromJson(Map<String, dynamic> json) {
    return Genus(
      genus: json['genus'] as String?,
      language: json['language'] != null ? StringUrlData.fromJson(json['language']) : null,
    );
  }
}
