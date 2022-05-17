import 'package:flutter/material.dart';
import 'package:santa/pages/friends_page.dart';
import 'package:santa/pages/santa_home_page.dart';

class SantaApp extends StatelessWidget {
  final String? groupName;

  const SantaApp({this.groupName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Santa",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SantaHomePage(),
      routes: {
        "/home": (BuildContext context) => const SantaHomePage(),
        "/friends": (BuildContext context) => const FriendsPage(),
      },
      initialRoute:
          groupName == null ? SantaHomePage.routeName : FriendsPage.routeName,
    );
  }
}
