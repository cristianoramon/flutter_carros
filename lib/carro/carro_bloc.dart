import 'dart:async';

import 'package:flutter_carros/carro/simple_bloc.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarroBloc extends SimpleBloc<List<Carro>>{

  void loadCarro(tipo) async {

    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (e) {
      // TODO
      addError(e);
    }
  }

 
}
