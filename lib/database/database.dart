import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:step_it_app/database/entities/past.dart';

import 'daos/presentDao.dart';
import 'daos/pastDao.dart';
import 'entities/present.dart';
import 'entities/past.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Present, Past])
abstract class AppDatabase extends FloorDatabase {
  PresentDao get presentDao;
  PastDao get pastDao;
}//AppDatabase