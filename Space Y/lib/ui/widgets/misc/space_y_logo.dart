import 'package:flutter/material.dart';

class SpaceYLogo extends StatelessWidget {
  const SpaceYLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('StartupScrollablePage'),
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.90,
          child: Image.asset('assets/images/logo_space_y.png'),
        ),
      ),
    );
  }
}