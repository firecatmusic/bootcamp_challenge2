import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? uid;
  final String? name;
  final String? email;
  final String? photo;

  User({this.id, this.uid, this.name, this.email, this.photo});
}
