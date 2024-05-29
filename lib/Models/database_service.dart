import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseService{
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/Users.db'; //ajustar para o nosso banco de dados
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async{
      await db.execute(
        'CREATE TABLE Users(id TEXT PRIMARY KEY, name TEXT, email TEXT, password TEXT, isAdm boolean)' //belmondo disse que a letra minuscula não faz diferença mas se der merda ja sabemos
      );
      log('TABLE CREATED');
  }

  Future<List<UserModel>> getUsers() async {
      final db = await _databaseService.database;
      var data = await db.rawQuery('SELECT * FROM Users');
      List<UserModel> users = List.generate(data.length, (index) => UserModel.fromJson(data[index]));
      print(users.length);
      return users;
  }

  Future<void> insertUser(UserModel user) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert('INSERT INTO Users(id, name, email, password, isAdm) Values(?,?,?,?,?)', [user.id, user.name, user.email, user.password, user.isAdm]);
    log('updated $data');
  }

  Future<void> editUser(UserModel user) async {
    final db = await _databaseService.database;
    var data = await db.rawUpdate('UPDATE Users SET name=?,email=?,password=? WHERE id=?', [user.name, user.email, user.password, user.id]);
    log('updated $data');
  }

  Future<void> deleteUser(String id) async {
      final db = await _databaseService.database;
      var data = await db.rawDelete('DELETE FROM Users WHERE id=?', [id]);
      log('deleted $data');
  }
}
