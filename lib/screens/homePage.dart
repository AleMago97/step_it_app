import 'dart:ffi';
import 'package:step_it_app/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:step_it_app/screens/loginPage.dart';
import 'package:step_it_app/utils/formats.dart';
import 'package:step_it_app/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_it_app/screens/profilepage.dart';
import 'package:step_it_app/screens/petpage.dart';
import 'package:step_it_app/screens/topPage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'dart:convert';
import 'package:step_it_app/database/entities/present.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/home/';
  static const routename = 'HomePage';

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String name = 'step';
  double? passi = 0;
  DateTime data = DateTime.now();
  String day = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    name = '$passi';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My first app',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 151, 27),
          title: Text(
            'HOME',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () => _toTopPage(context),
                icon: Icon(Icons.emoji_events))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 151, 27),
                  ),
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                  )),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () => _toProfilePage(context),
              ),
              ListTile(
                leading: Icon(Icons.pets),
                title: Text('Pet Mood'),
                onTap: () => _toPetPage(context),
              ),
              ListTile(
                leading: Icon(Icons.run_circle_outlined),
                title: Text('Activity'),
                onTap: () => _toActivityPage(context),
              ),
              ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text('Top Days'),
                onTap: () => _toTopPage(context),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () => _toLoginPage(context),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            _authorization(context),
            SizedBox(
              height: 40,
            ),
            _buildCard(context)
          ],
        ),
      ),
    );
  }

  Widget _authorization(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 164, 97, 21),
            elevation: 5,
          ),
          onPressed: () async {
            String? userId = await FitbitConnector.authorize(
                context: context,
                clientID: Strings.fitbitClientID,
                clientSecret: Strings.fitbitClientSecret,
                redirectUri: Strings.fitbitRedirectUri,
                callbackUrlScheme: Strings.fitbitCallbackScheme);
            final sp = await SharedPreferences.getInstance();
            sp.setString('userId', userId!);
          },
          child: Text('Tap to authorize'),
        ),
        SizedBox(
          height: 80,
          width: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 164, 97, 21),
            elevation: 5,
          ),
          onPressed: () async {
            await FitbitConnector.unauthorize(
              clientID: Strings.fitbitClientID,
              clientSecret: Strings.fitbitClientSecret,
            );
          },
          child: Text('Tap to unauthorize'),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      width: 350,
      height: 500,
      child: Card(
        elevation: 10,
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                if (passi! == 0)
                  Container(
                    width: 340,
                    height: 490,
                    child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Have you made your puppy happy yet?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Text('Tap me to discover..',
                          style: TextStyle(fontSize: 15)),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 247, 151, 27),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            elevation: 5,
                          ),
                          onPressed: () async {
                            final sp = await SharedPreferences.getInstance();
                            final String? userId = sp.getString('userId');
                            FitbitActivityTimeseriesDataManager
                                fitbitActivityTimeseriesDataManager =
                                FitbitActivityTimeseriesDataManager(
                              clientID: Strings.fitbitClientID,
                              clientSecret: Strings.fitbitClientSecret,
                              type: 'steps',
                            );
                            final stepsData =
                                await fitbitActivityTimeseriesDataManager.fetch(
                                    FitbitActivityTimeseriesAPIURL
                                        .dayWithResource(
                              date: DateTime.now().subtract(Duration(days: 0)),
                              userID: userId,
                              resource:
                                  fitbitActivityTimeseriesDataManager.type,
                            )) as List<FitbitActivityTimeseriesData>;
                            passi = stepsData[0].value;
                            setState(() {
                              name = '$passi';
                            });
                          },
                          child: Icon(Icons.pets)),
                    ]),
                  )
                else if (passi! >= 4000 && passi! < 8000)
                  Container(
                      width: 340,
                      height: 490,
                      child: Column(children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Almost there..',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '.. don\'t give up!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image(
                          image: AssetImage("assets/images/medio.png"),
                          fit: BoxFit.fitHeight,
                          height: 200,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Steps: $name on the $day'),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 247, 151, 27),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              final sp = await SharedPreferences.getInstance();
                              final String? userId = sp.getString('userId');
                              FitbitActivityTimeseriesDataManager
                                  fitbitActivityTimeseriesDataManager =
                                  FitbitActivityTimeseriesDataManager(
                                clientID: Strings.fitbitClientID,
                                clientSecret: Strings.fitbitClientSecret,
                                type: 'steps',
                              );
                              final stepsData =
                                  await fitbitActivityTimeseriesDataManager
                                      .fetch(FitbitActivityTimeseriesAPIURL
                                          .dayWithResource(
                                date:
                                    DateTime.now().subtract(Duration(days: 0)),
                                userID: userId,
                                resource:
                                    fitbitActivityTimeseriesDataManager.type,
                              )) as List<FitbitActivityTimeseriesData>;
                              passi = stepsData[0].value;
                              setState(() {
                                name = '$passi';
                              });
                            },
                            child: Icon(Icons.pets)),
                      ]))
                else if (passi! < 4000)
                  Container(
                      width: 340,
                      height: 490,
                      child: Column(children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Come on!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'It\'s time to move',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image(
                          image: AssetImage("assets/images/triste.png"),
                          fit: BoxFit.fitHeight,
                          height: 200,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Steps: $name on the $day'),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 247, 151, 27),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              final sp = await SharedPreferences.getInstance();
                              final String? userId = sp.getString('userId');
                              FitbitActivityTimeseriesDataManager
                                  fitbitActivityTimeseriesDataManager =
                                  FitbitActivityTimeseriesDataManager(
                                clientID: Strings.fitbitClientID,
                                clientSecret: Strings.fitbitClientSecret,
                                type: 'steps',
                              );
                              final stepsData =
                                  await fitbitActivityTimeseriesDataManager
                                      .fetch(FitbitActivityTimeseriesAPIURL
                                          .dayWithResource(
                                date:
                                    DateTime.now().subtract(Duration(days: 0)),
                                userID: userId,
                                resource:
                                    fitbitActivityTimeseriesDataManager.type,
                              )) as List<FitbitActivityTimeseriesData>;
                              passi = stepsData[0].value;
                              setState(() {
                                name = '$passi';
                              });
                            },
                            child: Icon(Icons.repeat)),
                      ]))
                else if (passi! >= 8000)
                  Container(
                    width: 340,
                    height: 490,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'You reached your goal',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image(
                        image: AssetImage("assets/images/felice.png"),
                        fit: BoxFit.fitHeight,
                        height: 180,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Steps: $name on the $day'),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 247, 151, 27),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            elevation: 5,
                          ),
                          onPressed: () async {
                            final sp = await SharedPreferences.getInstance();
                            final String? userId = sp.getString('userId');
                            FitbitActivityTimeseriesDataManager
                                fitbitActivityTimeseriesDataManager =
                                FitbitActivityTimeseriesDataManager(
                              clientID: Strings.fitbitClientID,
                              clientSecret: Strings.fitbitClientSecret,
                              type: 'steps',
                            );
                            final stepsData =
                                await fitbitActivityTimeseriesDataManager.fetch(
                                    FitbitActivityTimeseriesAPIURL
                                        .dayWithResource(
                              date: DateTime.now().subtract(Duration(days: 0)),
                              userID: userId,
                              resource:
                                  fitbitActivityTimeseriesDataManager.type,
                            )) as List<FitbitActivityTimeseriesData>;
                            passi = stepsData[0].value;
                            setState(() {
                              name = '$passi';
                            });
                          },
                          child: Icon(Icons.repeat)),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: 50,
                        width: 340,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Save your result..',
                                  style: TextStyle(fontSize: 15)),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 247, 151, 27),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(14),
                                    elevation: 4,
                                  ),
                                  onPressed: () async {
                                    final wp = name;
                                    await Provider.of<DatabaseRepository>(
                                            context,
                                            listen: false)
                                        .insertPresent(Present(null, wp));
                                  },
                                  child: Icon(Icons.emoji_events))
                            ]),
                      )
                    ]),
                  ),
              ],
            )),
      ),
    );
  }

  void _toLoginPage(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');

    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed('/login/');
  }

  void _toProfilePage(BuildContext context) {
    Navigator.of(context).pushNamed('/profile/');
  }

  void _toPetPage(BuildContext context) {
    Navigator.of(context).pushNamed('/pet/');
  }

  void _toTopPage(BuildContext context) {
    Navigator.of(context).pushNamed('/top/');
  }

  void _toActivityPage(BuildContext context) {
    Navigator.of(context).pushNamed('/activity/');
  }
}
