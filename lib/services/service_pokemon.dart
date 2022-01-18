import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemon/models/model_pokemon.dart';

class ServicePokemon {
  static Future<PokemonModel> getData() async {
    Response res = await Dio().get(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

    return PokemonModel.fromJson(jsonDecode(res.data));
  }
}
