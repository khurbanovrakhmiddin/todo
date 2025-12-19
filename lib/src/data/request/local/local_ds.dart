import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note_id INTEGER NOT NULL,
        file_path TEXT NOT NULL,
        FOREIGN KEY (note_id) REFERENCES notes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE audio (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note_id INTEGER NOT NULL,
        file_path TEXT NOT NULL,
        FOREIGN KEY (note_id) REFERENCES notes (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> createNote(
    String title,
    String subtitle,
    List<String> photoPaths,
    List<String> audioPaths,
  ) async {
    final db = await instance.database;

    return await db.transaction((txn) async {
      final noteId = await txn.insert('notes', {
        'title': title,
        'subtitle': subtitle,
        'created_at': DateTime.now().toIso8601String(),
      });

      for (var path in photoPaths) {
        await txn.insert('photos', {'note_id': noteId, 'file_path': path});
      }

      for (var path in audioPaths) {
        await txn.insert('audio', {'note_id': noteId, 'file_path': path});
      }

      return noteId;
    });
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await instance.database;

    final notes = await db.query('notes', orderBy: 'id DESC');

    List<Map<String, dynamic>> result = [];

    for (var note in notes) {
      final noteId = note['id'];

      final photos = await db.query(
        'photos',
        where: 'note_id = ?',
        whereArgs: [noteId],
      );
      final audio = await db.query(
        'audio',
        where: 'note_id = ?',
        whereArgs: [noteId],
      );

      var fullNote = Map<String, dynamic>.from(note);
      fullNote['photos'] = photos.map((p) => p['file_path']).toList();
      fullNote['audio'] = audio.map((a) => a['file_path']).toList();

      result.add(fullNote);
    }
    return result;
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
