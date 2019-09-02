import 'package:flutter/material.dart';
import 'package:light_key/data/join_or_login.dart';
import 'package:light_key/screens//tab_page.dart';
import 'package:light_key/screens/login_page.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JoinOrLogin>.value(
        value: JoinOrLogin(), child: AuthPage());
  }
}

//return StreamBuilder<FirebaseUser>(
//stream: FirebaseAuth.instance.onAuthStateChanged,
//builder: (BuildContext context, AsyncSnapshot snapshot) {
//if (snapshot.hasData) {
//return TabPage(snapshot.data);
//} else {
//return AuthPage();
//}
//},
//);
