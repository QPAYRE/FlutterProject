import 'package:space_y/blocs/theme_bloc.dart';
import 'package:space_y/themes.dart' as themes;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './blocs/auth_bloc.dart';
import './ui/home/home_screen.dart';
import './ui/login/login_screen.dart';

class SpaceY extends StatelessWidget {
  const SpaceY(this.prefs);
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    StatefulWidget spaceY(bool darkThemeIsEnabled) {
      return StreamBuilder<bool>(
          stream: authBloc.isSessionValid,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return const HomeScreen();
            }
            return LoginScreen();
          });
    }

    authBloc.restoreSession();

    return StreamBuilder<dynamic>(
        initialData: prefs?.getBool('darkThemeIsEnabled') ?? false,
        stream: kThemeBloc.darkThemeIsEnabled,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { /* TODO AsyncSnapshot<bool> ? */
          return MaterialApp(
            title: 'SpaceY',
            initialRoute: '/',
            // routes: <String, WidgetBuilder> {
            //   // '/booking': (context) => BookingScreen(),
            //   // '/profile': (context) => ProfileScreen(prefs?.getBool('darkThemeIsEnabled')),
            // },
            debugShowCheckedModeBanner: false,
            theme: snapshot.data != null ? themes.dark  : themes.light,
            home: spaceY(snapshot.data as bool),
          );
        });
  }
}
