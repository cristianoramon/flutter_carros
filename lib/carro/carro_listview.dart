import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'carro.dart';
import 'carros_api.dart';

class TipoCarro {
  static final String classico = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroListview extends StatelessWidget {
  String tipo;

  CarroListview(this.tipo);

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carro>> carros = CarrosApi.getCarros(tipo);

    return FutureBuilder(
      future: carros,
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
                          onPressed: () {/* ... */},
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
}
