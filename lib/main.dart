import 'package:flutter/material.dart';

import './firebase_db.dart';
import './google_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Firebase & Stuffs')),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Google SignIn'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => GoogleAuthPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text('Firebase Database'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FireBaseDB(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text('Test'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => FireBaseDB(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
