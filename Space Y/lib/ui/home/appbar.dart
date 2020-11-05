import 'package:space_y/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
    return AppBar(
    backgroundColor: Colors.transparent,
    bottomOpacity: 0.0,
    elevation: 0.0,
    centerTitle: true,
    title: FutureBuilder<bool>(
      future: kThemeBloc.isDarkThemeEnabled(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return Image.asset('assets/images/logo_space_y.png', height: 30.0);
        } else {
          return Image.asset('assets/images/logo_space_y.png', height: 30.0);
        }  
      })
    );
  }
