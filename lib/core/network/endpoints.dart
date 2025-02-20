class Endpoints {
  static const String baseUrl = 'https://pokeapi.co/api/v2/';

  static const String pokemonBackDefaultImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/';
  static const String pokemonBackFemaleImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/';
  static const String pokemonBackShinyImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/';
  static const String pokemonBackShinyFemaleImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/female/';
  static const String pokemonFrontDefaultImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/';
  static const String pokemonFrontFemaleImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/';
  static const String pokemonFrontShinyImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/';
  static const String pokemonFrontShinyFemaleImage = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/female/';

  static String getBackDefaultImage(int id) => '$pokemonBackDefaultImage$id.png';
  static String getBackFemaleImage(int id) => '$pokemonBackFemaleImage$id.png';
  static String getBackShinyImage(int id) => '$pokemonBackShinyImage$id.png';
  static String getBackShinyFemaleImage(int id) => '$pokemonBackShinyFemaleImage$id.png';
  static String getFrontDefaultImage(int id) => '$pokemonFrontDefaultImage$id.png';
  static String getFrontFemaleImage(int id) => '$pokemonFrontFemaleImage$id.png';
  static String getFrontShinyImage(int id) => '$pokemonFrontShinyImage$id.png';
  static String getFrontShinyFemaleImage(int id) => '$pokemonFrontShinyFemaleImage$id.png';
}