import 'package:space_y/ui/signUp/signup_page.dart';

import 'package:space_y/ui/startup_page/startup_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:space_y/ui/login/login_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  void animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  final PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView(
        controller: _pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[LoginPage(), startupPage(context, _pageController), SignUpPage()],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}