import 'dart:async';

import 'package:flutter_carros/carro/carro.dart';
import 'package:flutter_carros/favorito/db_helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO {
  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Carro carro) async {
    var dbClient = await db;

    if (dbClient != null) {
      var id = await dbClient.insert("carro", carro.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('id: $id');
    }

    return 0;
  }

  Future<List<Carro>> findAll() async {
    final dbClient = await db;
    List<Carro> carros = [];
    if (dbClient != null) {
      final list = await dbClient.rawQuery('select * from carro');
      carros = list.map<Carro>((json) => Carro.fromJson(json)).toList();
      return carros;
    }

    return carros;
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;
    List<Carro> carros = [];

    if (dbClient != null) {
      final list =
          await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);

      carros = list.map<Carro>((json) => Carro.fromJson(json)).toList();
    }

    return carros;
  }

  Future<Carro?> findById(int id) async {
    var dbClient = await db;

    if (dbClient != null) {
      final list =
          await dbClient.rawQuery('select * from carro where id = ?', [id]);

      if (list.length > 0) {
        return new Carro.fromJson(list.first);
      }

      return null;
    }

    Future<bool> exists(Carro carro) async {
      Carro? c;
      if (carro != null) {
        c = await findById(carro.id ?? 0);
        var exists = c != null;
        return exists;
      } else {
        return false;
      }
    }

    Future<int> count() async {
      final dbClient = await db;
      final list;

      if (dbClient != null) {
        list = await dbClient.rawQuery('select count(*) from carro');
        return Sqflite.firstIntValue(list) ?? 0;
      }

      return 0;
    }

    Future<int> delete(int id) async {
      var dbClient = await db;
      if (dbClient != null) {
        return await dbClient.rawDelete('delete from carro where id = ?', [id]);
      }
      return 0;
    }

    Future<int> deleteAll() async {
      var dbClient = await db;

      if (dbClient != null) {
        return await dbClient.rawDelete('delete from carro');
      }
      return 0;
    }
  }
}
