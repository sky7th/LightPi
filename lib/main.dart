import 'package:flutter/material.dart';
import 'package:light_key/screens/login_page.dart';
import 'package:light_key/screens/tab_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:light_key/screens/master_list_page.dart';

import 'screens/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          buttonColor: Colors.white),
      home: RootPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/applyListPage':
            return PageTransition(
              child: ApplyListPage(),
              type: PageTransitionType.leftToRight,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
