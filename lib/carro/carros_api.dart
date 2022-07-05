import 'dart:convert';

import 'package:flutter_carros/favorito/carro_dao.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarrosFake() async {
    Map<String, String> headers = {"Content-Type": "application/json"};

    final List<Carro> carros = [];
    carros.add(Carro(
        nome: "BMW M5",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/BMW.png"));
    carros.add(Carro(
        nome: "Renault Megane RS Trophi2",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Renault_Megane_Trophy.png"));
    carros.add(Carro(
        nome: "Maserati Grancabrio Sport",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Maserati_Grancabrio_Sport.png"));
    return carros;
  }

  static Future<List<Carro>> getCarros(String tipo) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    final List<Carro> carros = [];

    try {
      Uri url = Uri.parse(
          'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');
      print(url);
      var response = await http.get(url);
      List list = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return carros;
    } catch (err) {
      print(err);
      return carros;
    }
  }
}
