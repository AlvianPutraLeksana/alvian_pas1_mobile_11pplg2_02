import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'favorite_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('football.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        name INTEGER PRIMARY KEY,
        badge TEXT,
        stadium TEXT,
        location TEXT
      )
    ''');
  }

  Future<bool> isFavorite(int name) async {
    final db = await instance.database;
    final result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }

  Future<int> addFavorite(FavoriteFootball football) async {
    final db = await instance.database;
    return await db.insert('favorites', football.toMap());
  }

  Future<int> removeFavorite(int name) async {
    final db = await instance.database;
    return await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<List<FavoriteFootball>> getAllFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((json) => FavoriteFootball.fromMap(json)).toList();
  }
} 