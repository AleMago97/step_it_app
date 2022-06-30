import 'package:flutter/material.dart';

class intro extends StatelessWidget {
  static const route = '/';
  static const routename = 'intro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage('assets/images/intro.jpg')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 247, 151, 27),
              ),
              child: Text('START'),
              onPressed: () {
                Navigator.pushNamed(context, '/login/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
