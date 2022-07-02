import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_carros/carro/carro_bloc.dart';
import 'package:flutter_carros/carro/carro_page.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'carro.dart';
import 'carros_api.dart';

class TipoCarro {
  static final String classico = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroListview extends StatefulWidget {

  String tipo;

 
  CarroListview(this.tipo);

  @override
  State<CarroListview> createState() => _CarroListviewState();
}

class _CarroListviewState extends State<CarroListview>
    with AutomaticKeepAliveClientMixin<CarroListview> {
  List<Carro>? carros;
  
  final _blocCarro = CarroBloc();
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  @override
  void initState() {
    super.initState();
    //carros = CarrosApi.getCarros(widget.tipo);
    //Future<List<Carro>> futureCarro = CarrosApi.getCarros(widget.tipo);

    _blocCarro.loadCarro(widget.tipo);
  }



  _body() {
    return StreamBuilder(
      stream: _blocCarro.stream,
      builder: (BuildContext context, AsyncSnapshot<List<Carro>> snapshot) {
        List<Carro>? carros = [];

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro ao buscar o carro",
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData) {
          carros = snapshot.data;
          print(snapshot.data.toString());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _listView(carros);
      },
    );

    print("Carro");
  }

  Container _listView(carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros.length,
          itemBuilder: (context, index) {
            Carro c = carros[index];
            String nome = "";

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        c.urlFoto.toString(),
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        TextButton(
                          child: const Text('SHARE'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

            /*
          return ListTile(
            leading: Image.network(c.urlFoto.toString()),
            title: Text(
              c.nome.toString(),
            ),
          );
          */
          }),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose(){
    super.dispose();
    _blocCarro.dispose();
  }
}
