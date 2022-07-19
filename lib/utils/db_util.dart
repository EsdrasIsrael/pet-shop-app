import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pet_shop.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await  DbUtil.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> delete(String table, int id) async {
    final db = await DbUtil.database();

    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

_onCreate(db, versao) async {
  await db.execute(_vets);
  await db.execute(_pets);
}

String get _vets => '''
    CREATE TABLE vets (id TEXT PRIMARY KEY, nome TEXT, telefone TEXT, email TEXT, imagem TEXT, especializacao TEXT)
  ''';

String get _pets => '''
    CREATE TABLE pets (id TEXT PRIMARY KEY, nome TEXT, idade TEXT, especie TEXT, imagem TEXT, sexo TEXT)
  ''';