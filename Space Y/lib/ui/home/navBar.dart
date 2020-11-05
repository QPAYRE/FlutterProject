import 'package:space_y/blocs/navigation_bloc.dart';
import 'package:flutter/material.dart';

Widget navBar(BuildContext context, NavigationBloc navigationBloc) {
  return StreamBuilder<NavBarItem>(
    stream: navigationBloc.itemStream,
    initialData: navigationBloc.defaultPage,
    builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
      return BottomNavigationBar(
        key: const Key('BottomNavigationBar'),
        backgroundColor: Theme.of(context).backgroundColor,
        fixedColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.blueGrey[200],
        currentIndex: snapshot.data.index,
        type: BottomNavigationBarType.fixed,
        onTap: navigationBloc.pickItem,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Reservations'),
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person),
          ),
        ],
      );
    },
  );
}

Widget navBarProgressIndicator() {
  return const Align(
    alignment: FractionalOffset.bottomLeft,
    child: LinearProgressIndicator(),
  );
}