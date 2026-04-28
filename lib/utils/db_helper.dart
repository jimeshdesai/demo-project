import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'customers.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE customers(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          additionalPhones TEXT,
          street TEXT,
          suburb TEXT,
          postcode TEXT,
          state TEXT,
          createdAt INTEGER
        )
      ''');

        await db.execute(_productTableQuery);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(_productTableQuery);
        }
      },
    );
  }

  String get _productTableQuery => '''
CREATE TABLE products(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  sku TEXT NOT NULL UNIQUE,
  description TEXT,
  price REAL NOT NULL,
  specialPrice REAL,
  images TEXT,
  createdAt INTEGER
)
''';

  Future<int> insertCustomer(Map<String, dynamic> data) async {
    final db = await database;
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;

    return await db.insert('customers', data);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return db.query('customers', orderBy: 'createdAt DESC');
  }

  Future<int> updateCustomer(int id, Map<String, dynamic> data) async {
    final db = await database;
    data.remove('createdAt');

    return await db.update('customers', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return db.delete('customers', where: 'id=?', whereArgs: [id]);
  }

  Future<int> insertProduct(Map<String, dynamic> data) async {
    final db = await database;
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    return db.insert('products', data);
  }

  Future<bool> isSkuExists(String sku) async {
    final db = await database;
    final result = await db.query(
      'products',
      where: 'sku = ?',
      whereArgs: [sku],
      limit: 1,
    );
    return result.isNotEmpty;
  }


  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return db.query('products', orderBy: 'createdAt DESC');
  }

  Future<int> updateProduct(int id, Map<String, dynamic> data) async {
    final db = await database;
    data.remove('createdAt');
    return db.update('products', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isSkuExistsForOther(
      String sku,
      int currentId,
      ) async {
    final db = await database;
    final result = await db.query(
      'products',
      where: 'sku = ? AND id != ?',
      whereArgs: [sku, currentId],
      limit: 1,
    );
    return result.isNotEmpty;
  }


  Future<int> deleteProduct(int id) async {
    final db = await database;
    return db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
