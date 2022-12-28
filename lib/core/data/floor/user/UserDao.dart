import 'package:floor/floor.dart';

import '../../model/user.dart';

@dao
abstract class UserDAO {
  @insert
  Future<List<int>> insertUser(List<User> user);

  @Query('SELECT * FROM User')
  Future<List<User>> retrieveUsers();

  @Query('DELETE FROM User WHERE id = :id')
  Future<User?> deleteUser(int id);
}