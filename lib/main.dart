import 'package:flutter/material.dart';
import 'package:santa/app.dart';
import 'package:santa/pages/santa_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => _prepareAndRun();

Future<void> _prepareAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var groupName = prefs.getString(groupNameKey);
  runApp(SantaApp(groupName: groupName));
}
