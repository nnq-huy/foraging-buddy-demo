import 'dart:io';
import 'package:flutter/services.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDb() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "mushrooms.db");

// Check if the database exists
  var exists = await databaseExists(path);

  if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "mushrooms.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }

// open the database
  var db = await openDatabase(path, readOnly: true);
  return db;
}

Future<List<Mushroom>?> getMushrooms() async {
  final db = await openDb();
  List<Mushroom> mushrooms = [];
  final mapData = await db.query('mushrooms', orderBy: "id");

  if (mapData.isEmpty) {
    return null;
  }
  for (var map in mapData) {
    mushrooms.add(Mushroom.fromMap(map));
  }
  return mushrooms;
}

Future<Mushroom> getMushroom(int id) async {
  final db = await openDb();
  final maps =
      await db.query('mushrooms', where: "id = ?", whereArgs: [id], limit: 1);

  return Mushroom.fromMap(maps.first);
}
