import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc {
  final StreamController<bool> _themeStreamController = StreamController<bool>();

  Stream<bool> get darkThemeIsEnabled => _themeStreamController.stream;

  Future<void> Function(bool darkThemeIsEnabled) get changeTheTheme => (bool darkThemeIsEnabled) async {
    _themeStreamController.sink.add(darkThemeIsEnabled); 
    final SharedPreferences kPrefs = await SharedPreferences.getInstance();
    await kPrefs.setBool('darkThemeIsEnabled', !darkThemeIsEnabled);
  };

  Future<bool> isDarkThemeEnabled() async {
    final SharedPreferences kPrefs = await SharedPreferences.getInstance();
    return kPrefs.getBool('darkThemeIsEnabled');
  }
}

final ThemeBloc kThemeBloc = ThemeBloc();