import 'package:bootcamp_challenge2/core/data/floor/user/UserDao.dart';
import 'package:floor/floor.dart';

import '../model/user.dart';

@Database(version: 1, entities: [User])
abstract class AppDatabase extends FloorDatabase {
  UserDAO get userDAO;
}