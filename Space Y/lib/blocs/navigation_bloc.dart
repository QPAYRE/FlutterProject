import 'dart:async';

enum NavBarItem { BOOKING, PROFILE }

class NavigationBloc {
  final StreamController<NavBarItem> _navBarController = StreamController<
      NavBarItem>.broadcast();

  NavBarItem defaultPage = NavBarItem.BOOKING;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.BOOKING);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }

    // void close() {
    //   _navBarController?.close();
    // }
  }
}

final NavigationBloc kNavigationBloc = NavigationBloc();