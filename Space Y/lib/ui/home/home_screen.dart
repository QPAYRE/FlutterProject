import 'package:space_y/blocs/navigation_bloc.dart';
import 'package:space_y/blocs/user_bloc.dart';
import 'package:space_y/models/user_model.dart';
import 'package:space_y/ui/booking/book_screen.dart';
import 'package:space_y/ui/booking/booking_screen.dart';

import 'package:space_y/ui/home/navBar.dart';
import 'package:space_y/ui/profile/profile_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigationBloc navigationBloc;
  UserBloc userBloc;
  UserModel user;

  @override
  void initState() {
    super.initState();
    navigationBloc = NavigationBloc();
    userBloc = UserBloc();
    initSocket();
  }

  @override
  void dispose() {
    //navigationBloc.close();
    super.dispose();
  }

  Future<bool> initSocket() async {
    user = await userBloc.getUser();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<NavBarItem>(
        stream: navigationBloc.itemStream,
        initialData: navigationBloc.defaultPage,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.BOOKING:
              return BookScreen();
            case NavBarItem.PROFILE:
              return const ProfileScreen();
          }
          return null;
        },
      ),
      bottomNavigationBar: navBar(context, navigationBloc),
    );
  }
}
