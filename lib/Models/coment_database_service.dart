import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'coment_model.dart';

class ComentDatabaseService {
  static final ComentDatabaseService _databaseService = ComentDatabaseService._internal();
  factory ComentDatabaseService() => _databaseService;
  ComentDatabaseService._internal();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/Comentarios.db'; 
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async{
      await db.execute(
        'CREATE TABLE Comentarios(id TEXT PRIMARY KEY, forumId TEXT, content TEXT, userName TEXT)' 
      );
      log('TABLE CREATED');
  }

  Future<List<ComentModel>> getComents() async {
      final db = await _databaseService.database;
      var data = await db.rawQuery('SELECT * FROM Comentarios');
      List<ComentModel> comentarios = List.generate(data.length, (index) => ComentModel.fromJson(data[index]));
      print(comentarios.length);
      return comentarios;
  }

  Future<void> insertComent(ComentModel coment) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert('INSERT INTO Comentarios(id, forumId, content, userName) Values(?,?,?,?)', [coment.id,coment.forumId, coment.content, coment.userName]);
    log('updated $data');
  }

  Future<void> editComent(ComentModel coment) async {
    final db = await _databaseService.database;
    var data = await db.rawUpdate('UPDATE Comentarios SET forumId=?,content=?,userName=? WHERE id=?', [coment.forumId, coment.content, coment.userName, coment.id]);
    log('updated $data');
  }

  Future<void> deleteComent(String id) async {
      final db = await _databaseService.database;
      var data = await db.rawDelete('DELETE FROM Comentarios WHERE id=?', [id]);
      log('deleted $data');
  }
 
  
}
