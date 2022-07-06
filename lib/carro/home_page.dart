import 'package:flutter/material.dart';
import 'package:flutter_carros/carro/carro_form_page.dart';
import 'package:flutter_carros/carro/carro_listview.dart';
import 'package:flutter_carros/carro/carros_api.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'carro.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Carros"),
            bottom: TabBar(tabs: [
              Tab(text: "Clássicos"),
              Tab(text: "Esportivo"),
              Tab(text: "Luxo")
            ]),
          ),
          body: TabBarView(children: [
            CarroListview(TipoCarro.classico),
            CarroListview(TipoCarro.esportivos),
            CarroListview(TipoCarro.luxo),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _onclickAddCarro(),
          )),
    );
  }

  _onclickAddCarro() {
    Carro c = Carro();
    push(context, CarroFormPage(carro: c));
  }
}
