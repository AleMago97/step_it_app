import 'package:step_it_app/database/entities/past.dart';
import 'package:step_it_app/repository/databaseRepository.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_it_app/utils/strings.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'dart:ffi';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  static const route = '/activity/';
  static const routename = 'Activity';
  @override
  State<ActivityPage> createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  String track = 'step';
  double? step = 0;

  String day = 'date';
  var data = null;

  @override
  void initState() {
    track = '$step';
    day = '$data';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${ActivityPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 151, 27),
          title: Text(
            'ACTIVITY',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: RefreshIndicator(
          color: Color.fromARGB(255, 164, 97, 21),
          onRefresh: () async {
            final sp = await SharedPreferences.getInstance();
            final String? userId = sp.getString('userId');
            FitbitActivityTimeseriesDataManager
                fitbitActivityTimeseriesDataManager =
                FitbitActivityTimeseriesDataManager(
              clientID: Strings.fitbitClientID,
              clientSecret: Strings.fitbitClientSecret,
              type: 'steps',
            );
            final stepsData = await fitbitActivityTimeseriesDataManager
                .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
              date: DateTime.now().subtract(Duration(days: 1)),
              userID: userId,
              resource: fitbitActivityTimeseriesDataManager.type,
            )) as List<FitbitActivityTimeseriesData>;
            step = stepsData[0].value;
            data = stepsData[0].dateOfMonitoring;
            setState(() {
              track = '$step';
              day = '$data';
            });
            final wp = track;
            final wd = day;

            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertPast(Past(null, wp, wd));
          },
          child:
              Consumer<DatabaseRepository>(builder: (context, dbr, child) {
            return FutureBuilder(
              initialData: null,
              future: dbr.findAllPasts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Past>;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, pastIndex) {
                        final past = data[pastIndex];
                        return Card(
                          elevation: 5,
                          child: Dismissible(
                            key: UniqueKey(),
                            background: Container(
                                color: Color.fromARGB(255, 249, 247, 245)),
                            child: ListTile(
                              leading: Icon(MdiIcons.run),
                              title: Text('${past.track} on the ${past.day}'),
                            ),
                            onDismissed: (direction) async {
                              await Provider.of<DatabaseRepository>(context,
                                      listen: false)
                                  .removePast(past);
                            },
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                } //else
              }, //builder of FutureBuilder
            );
          }),
        ));
  } //build

} //HomePage