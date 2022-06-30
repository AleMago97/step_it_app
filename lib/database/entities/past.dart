import 'package:floor/floor.dart';

@entity
class Past {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String track;
  final String day;
  Past(this.id, this.track, this.day);
}//Past