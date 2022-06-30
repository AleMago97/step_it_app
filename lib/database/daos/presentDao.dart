import 'package:step_it_app/database/entities/present.dart';
import 'package:floor/floor.dart';

@dao
abstract class PresentDao {
  @Query('SELECT * FROM Present')
  Future<List<Present>> findAllPresents();

  @insert
  Future<void> insertPresent(Present present);

  @delete
  Future<void> deletePresent(Present task);
}//PresentDao