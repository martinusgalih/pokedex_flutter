class EvolutionDetail {
  final int? minLevel;
  final String? trigger;
  final String? item;

  EvolutionDetail({
    this.minLevel,
    this.trigger,
    this.item,
  });

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) {
    return EvolutionDetail(
      minLevel: json['min_level'] as int?,
      trigger: json['trigger']?['name'],
      item: json['item']?['name'],
    );
  }
}

class EvolutionChain {
  final String name;
  final List<EvolutionDetail> evolutionDetails;
  final List<EvolutionChain> evolvesTo;

  EvolutionChain({
    required this.name,
    required this.evolutionDetails,
    required this.evolvesTo,
  });

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    return EvolutionChain(
      name: json['species']['name'] as String,
      evolutionDetails: (json['evolution_details'] as List?)
          ?.map((e) => EvolutionDetail.fromJson(e))
          .toList() ??
          [],
      evolvesTo: (json['evolves_to'] as List?)
          ?.map((e) => EvolutionChain.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class PokemonEvolutionModel {
  final String? babyTriggerItem;
  final EvolutionChain chain;

  PokemonEvolutionModel({
    this.babyTriggerItem,
    required this.chain,
  });

  factory PokemonEvolutionModel.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionModel(
      babyTriggerItem: json['baby_trigger_item']?['name'],
      chain: EvolutionChain.fromJson(json['chain']),
    );
  }
}
