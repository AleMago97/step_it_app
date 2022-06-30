import 'package:step_it_app/database/entities/past.dart';
import 'package:floor/floor.dart';

@dao
abstract class PastDao {
  @Query('SELECT * FROM Past')
  Future<List<Past>> findAllPasts();

  @insert
  Future<void> insertPast(Past past);

  @delete
  Future<void> deletePast(Past task);
}//PastDao