import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_y/landing_page.dart';


Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences kPrefs = await SharedPreferences.getInstance();
  runApp(SpaceY(kPrefs));
  return true;
}
