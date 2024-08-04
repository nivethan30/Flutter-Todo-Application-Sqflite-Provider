import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'on_create.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  String dbName = 'todo.db';
  int dbVersion = 1;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = path.join(await getDatabasesPath(), dbName);
    return await openDatabase(dbPath,
        version: dbVersion,
        onCreate: TableCreation.onCreate,
        onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(db, oldVersion, newVersion) async {}
}
