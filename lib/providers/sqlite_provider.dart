import 'package:mydespenseapp/despense/domain/to_buy_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../despense/domain/despense_entity.dart';

class DespenseDatabase {
  static final DespenseDatabase _instance = DespenseDatabase._();

  DespenseDatabase._();

  static DespenseDatabase get instance => _instance;

  Future<Database> database() async =>
      openDatabase(join(await getDatabasesPath(), 'despense_items.db'));

  Future<void> createDatabase() async {
    openDatabase(
      join(await getDatabasesPath(), 'despense_items.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE despenseitems(id INTEGER PRIMARY KEY autoincrement, name TEXT)');
        db.execute(
            'CREATE TABLE tobuyitems(id INTEGER PRIMARY KEY autoincrement, name TEXT, description TEXT, isbought BOOLEAN, despenseitemid INTEGER REFERENCES despenseitems(id))');
      },
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      version: 1,
    );
  }

  Future<void> insertDespenseItem(DespenseItem despenseItem) async {
    final db = await database();

    await db.insert(
      'despenseitems',
      despenseItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DespenseItem>> getDespenseItems() async {
    final db = await database();

    final List<Map<String, dynamic>> despenseItems =
        await db.query('despenseitems');
    return List.generate(
      despenseItems.length,
      (index) => DespenseItem(
          despenseItems[index]['id'], despenseItems[index]['name']),
    );
  }

  Future<void> insertToButItem(ToBuyItem toBuyItem) async {
    final db = await database();

    await db.insert(
      'tobuyitems',
      toBuyItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ToBuyItem>> getToBuyItems(int despenseItemId) async {
    final db = await database();
    final List<Map<String, dynamic>> toBuyItems = await db.query(
        'SELECT * FROM tobuyitems WHERE despenseitemid = $despenseItemId');
    return List.generate(
      toBuyItems.length,
      (index) => ToBuyItem(
        toBuyItems[index]['id'],
        toBuyItems[index]['name'],
        toBuyItems[index]['description'],
        toBuyItems[index]['isbought'],
      ),
    );
  }
}
