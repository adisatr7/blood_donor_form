import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/utils/database_helper.dart';

class UserService {
  static final UserService instance = UserService._init();

  UserService._init();

  /// Insert a new user into the database.
  Future<int> insertUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('users', user.toMap());
  }

  /// Get a user by NIK and password.
  Future<User?> getByNikAndPassword(String nik, String password) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'users',
      where: 'nik = ? AND password = ?',
      whereArgs: [nik, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  /// Get a user by ID.
  Future<User?> getById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }

    return null;
  }

  /// Check if a user exists by NIK.
  Future<bool> isExist(String nik) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('users', where: 'nik = ?', whereArgs: [nik]);

    return maps.isNotEmpty;
  }

  /// Update a user in the database.
  Future<int> update(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Delete a user from the database.
  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
