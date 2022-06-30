import 'package:flutter/material.dart';
import 'package:step_it_app/screens/homepage.dart';

class PetPage extends StatelessWidget {
  static const route = '/pet/';
  static const routename = 'PetPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: () => _toHomePage(context),
          ),
          backgroundColor: Color.fromARGB(255, 247, 151, 27),
          title: Text(
            'PET MOOD',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage("assets/images/triste.png"),
                  fit: BoxFit.fitHeight,
                  height: 150,
                ),
                Text('Less than 4000 steps')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage("assets/images/medio.png"),
                  fit: BoxFit.fitHeight,
                  height: 150,
                ),
                Text('Between 4000 & 8000 steps')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage("assets/images/felice.png"),
                  fit: BoxFit.fitHeight,
                  height: 150,
                ),
                Text('More than 8000 steps')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _toHomePage(BuildContext context) {
  Navigator.of(context).pop();
}
