import 'package:pokedex/core/network/endpoints.dart';

class PokemonModel {
  final String name;
  final String url;

  PokemonModel({required this.name, required this.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      url: json['url'],
    );
  }

  int get id {
    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }

  String get imageUrl => Endpoints.getHomeFrontDefaultImage(id);
}
