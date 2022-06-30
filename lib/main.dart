import 'package:flutter/material.dart';
import 'package:step_it_app/screens/topPage.dart';
import 'package:step_it_app/screens/homePage.dart';
import 'package:step_it_app/screens/intro.dart';
import 'package:step_it_app/screens/loginPage.dart';
import 'package:step_it_app/screens/profilepage.dart';
import 'package:step_it_app/screens/petPage.dart';
import 'package:step_it_app/database/database.dart';
import 'package:step_it_app/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:step_it_app/screens/activityPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final databaseRepository = DatabaseRepository(database: database);

  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => intro(),
        '/login/': (context) => LoginPage(),
        '/home/': (context) => HomePage(),
        '/profile/': (context) => ProfilePage(),
        '/pet/': (context) => PetPage(),
        '/top/': (context) => TopPage(),
        '/activity/': (context) => ActivityPage(),
      },
    );
  } //build
} //MyApp
