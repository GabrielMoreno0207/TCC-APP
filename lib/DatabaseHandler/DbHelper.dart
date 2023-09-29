import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Future<Database>? _db;

  static const String DB_Nome = 'Login.db';
  static const String Table_Usuario = 'usuario';
  static const int Version = 2;

  static const String C_id = 'primary_key';
  static const String C_UsuarioNome = 'usuario_nome';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  DbHelper() {
    _db ??= initDb();
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Nome);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $Table_Usuario ("
        "$C_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$C_UsuarioNome TEXT,"
        "$C_Email TEXT,"
        "$C_Password TEXT"
        ")");
  }
}
