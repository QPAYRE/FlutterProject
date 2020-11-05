import 'package:flutter/material.dart';
import 'package:space_y/ui/widgets/misc/space_y_logo.dart';

Widget startupPage(BuildContext context, PageController _pageController) {
    void animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: applyBackgroundImage(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SpaceYLogo(),
        goToSignUpButton(context, animateToPage),
        goToLoginButton(context, animateToPage),
      ],
    ),
  );
}

Container goToSignUpButton(BuildContext context, void animateToPage(int page)) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: OutlineButton(
            key: const Key('fromStartupPageGoToSignUp'),
            shape: applyRoundedShape(9),
            borderSide: const BorderSide(color: Colors.white),
            onPressed: () => animateToPage(2),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.03
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container goToLoginButton(BuildContext context, void animateToPage(int page)) {
  return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  shape: applyRoundedShape(9),
                  color: Colors.white,
                  onPressed: () => animateToPage(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.03
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

RoundedRectangleBorder applyRoundedShape(double radius) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
  );
}

BoxDecoration applyBackgroundImage() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/background_space_y.png'),
      fit: BoxFit.cover,
    ),
  );
}