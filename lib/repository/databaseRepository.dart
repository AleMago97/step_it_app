import 'package:step_it_app/database/database.dart';
import 'package:step_it_app/database/entities/past.dart';
import 'package:step_it_app/database/entities/present.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  final AppDatabase database;

  DatabaseRepository({required this.database});

  Future<List<Present>> findAllPresents() async {
    final results = await database.presentDao.findAllPresents();
    return results;
  } //findAllPresents

  Future<void> insertPresent(Present present) async {
    await database.presentDao.insertPresent(present);
    notifyListeners();
  } //insertPresent

  Future<void> removePresent(Present present) async {
    await database.presentDao.deletePresent(present);
    notifyListeners();
  } //removePresent

  Future<List<Past>> findAllPasts() async {
    final results = await database.pastDao.findAllPasts();
    return results;
  } //findAllPasts

  Future<void> insertPast(Past past) async {
    await database.pastDao.insertPast(past);
    notifyListeners();
  } //insertPast

  Future<void> removePast(Past past) async {
    await database.pastDao.deletePast(past);
    notifyListeners();
  } //removePast

} //DatabaseRepository
