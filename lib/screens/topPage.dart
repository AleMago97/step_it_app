import 'dart:async';
import 'package:flutter/material.dart';
import 'package:step_it_app/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:step_it_app/database/entities/present.dart';
import 'package:intl/intl.dart';

class TopPage extends StatelessWidget {
  TopPage({Key? key}) : super(key: key);

  static const route = '/top/';
  static const routename = 'Top';

  DateTime data = DateTime.now();
  String day = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 151, 27),
          title: Text(
            'TOP DAYS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Center(
            child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          return FutureBuilder(
              initialData: null,
              future: dbr.findAllPresents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Present>;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, presentIndex) {
                        final present = data[presentIndex];
                        return Card(
                          elevation: 5,
                          child: Dismissible(
                            key: UniqueKey(),
                            background: Container(
                                color: Color.fromARGB(255, 249, 247, 245)),
                            child: ListTile(
                              leading: Icon(Icons.emoji_events),
                              title: Text('${present.name} on the $day'),
                            ),
                            onDismissed: (direction) async {
                              await Provider.of<DatabaseRepository>(context,
                                      listen: false)
                                  .removePresent(present);
                            },
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                } //else
              });
        })));
  } //build

} //HomePage

void _toHomePage(BuildContext context) {
  Navigator.of(context).pop();
}
