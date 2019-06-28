import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthPage extends StatefulWidget {
  @override
  _GoogleAuthPageState createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  void _signOut() {
    _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google SignIn'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                color: Colors.red,
                child: Image(
                  image: NetworkImage(
                      'https://pixel.nymag.com/imgs/fashion/daily/2019/04/30/keanu-reeves/SAINT-LAURENT_FALL19_21_HR.w536.h536.2x.jpg'),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('SignIn with Google'),
                onPressed: () {
                  _handleSignIn().then((FirebaseUser user) {});
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Sign Out'),
                onPressed: () {
                  _signOut();
                  print('Signed Out');
                },
              ),
            ],
          ),
        ));
  }
}
