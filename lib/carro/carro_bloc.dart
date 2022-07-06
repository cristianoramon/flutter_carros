import 'dart:async';

import 'package:flutter_carros/carro/simple_bloc.dart';
import 'package:flutter_carros/favorito/carro_dao.dart';
import 'package:flutter_carros/utils/network.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarroBloc extends SimpleBloc<List<Carro>> {
  List<Carro> carros = [];
  void loadCarro(tipo) async {
    try {
      bool networkOn = await isNetworkOn();

      if (networkOn) {
        carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
      } else {
        carros = await CarrosApi.getCarros(tipo);
        add(carros);
      }

      final carroDao = CarroDAO();

      for (Carro c in carros) {
        carroDao.save(c);
        carros.add(c);
      }

      add(carros);
    } catch (e) {
      // TODO
      addError(e);
    }
  }
}
