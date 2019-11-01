import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:light_key/data/join_or_login.dart';
import 'package:light_key/screens//tab_page.dart';
import 'package:light_key/screens/login_page.dart';
import 'package:light_key/tools/build_grid_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//import 'package:firebase_auth/firebase_auth.dart';

//var storage = new FlutterSecureStorage();

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userInfoLoginId = prefs.getString('userLoginId') ?? 'none';
        userInfoId = prefs.getInt('userId');
        print(userInfoLoginId);
        return userInfoLoginId;
      }(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator()
            );
          default:
            print(snapshot.data);
            return snapshot.data  != 'none'
                ? TabPage()
                : ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(), child: AuthPage());
        }
        print('루트에연');
        print(snapshot.data);
        return snapshot.data  != 'none'
        ? TabPage()
        : ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(), child: AuthPage());
      },
    );
  }
}

//return StreamBuilder<String>(
//      stream: isloginStreamController.stream,
//      initialData: userInfoLoginId,
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        print('루트에연');
//        print(snapshot.data);
//        return snapshot.data  != 'none'
//        ? TabPage()
//        : ChangeNotifierProvider<JoinOrLogin>.value(
//            value: JoinOrLogin(), child: AuthPage());
//      },
//    );

//class Splash extends StatefulWidget {
//  @override
//  _SplashState createState() => _SplashState();
//}
//
//class _SplashState extends State<Splash> {
//  StreamController<String> login;
//
//  @override
//  Widget build(BuildContext context) {
//    print('aaaaaaaaaaaaaaaaaaaaaasdf');
//
//    () async {
//      login.add(await storage.read(key: 'isLogin'));
//    }();
//    print(login);
//    print('aaaaaaaaaaaaaaaaaaaaaasdf');
//
//    return login == 'true'
//        ? TabPage()
//        : ChangeNotifierProvider<JoinOrLogin>.value(
//            value: JoinOrLogin(), child: AuthPage());
//  }
//}
