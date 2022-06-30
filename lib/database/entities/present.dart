import 'package:floor/floor.dart';

@entity
class Present {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  Present(this.id, this.name);
}//Present