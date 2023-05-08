import 'package:flutter/foundation.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE mushrooms(
        id INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL,
        name TEXT,
        latin_name TEXT,
        family TEXT,
        edibility TEXT,
        smell TEXT)""");
  }

  static Future<Database> db() async {
    return openDatabase(
      'mushroom.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (mushroom)
  static Future<int> createItem(Mushroom mushroom) async {
    final db = await SQLHelper.db();
    final data = mushroom.toMap();
    final id = await db.insert('mushrooms', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Mushroom>?> getItems() async {
    final db = await SQLHelper.db();
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

  // Read a single item by id
  static Future<Mushroom> getMushroom(int id) async {
    final db = await SQLHelper.db();
    final maps =
        await db.query('mushrooms', where: "id = ?", whereArgs: [id], limit: 1);

    return Mushroom.fromMap(maps.first);
  }

  // Update an item by id
  /*  static Future<int> updateItem(
      int id, String title, String? description) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  } */

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
