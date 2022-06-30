import 'package:flutter/material.dart';
import 'package:step_it_app/screens/homepage.dart';

class ProfilePage extends StatelessWidget {
  static const route = '/profile/';
  static const routename = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              onPressed: () => _toHomePage(context),
            ),
            backgroundColor: Color.fromARGB(255, 247, 151, 27),
            title: Text(
              'PROFILE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        body: (ListView(
          children: [
            ListTile(
              leading: Icon(Icons.face),
              title: Text('User Name:   CCA'),
            ),
            ListTile(
              leading: Icon(Icons.cake),
              title: Text('Birthday:   30/05/2022'),
            ),
            ListTile(
              leading: Icon(Icons.girl),
              title: Text('Gender:   W'),
            ),
            ListTile(
              leading: Icon(Icons.arrow_upward),
              title: Text('Height:   170 cm'),
            ),
            ListTile(
              leading: Icon(Icons.scale),
              title: Text('Weight:   60 kg'),
            ),
            ListTile(
              leading: Icon(Icons.run_circle_outlined),
              title: Text('Daily Goal:   8000 steps'),
            ),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text('Pet:   Dog'),
            ),
          ],
        )));
  }
}

void _toHomePage(BuildContext context) {
  Navigator.of(context).pop();
}
