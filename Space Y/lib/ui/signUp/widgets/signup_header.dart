import 'package:flutter/material.dart';

Widget signUpHeader(BuildContext context, String header, double size) {
  return Container(
    padding: const EdgeInsets.only(top: 60, bottom: 50, left: 30),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              header,
              style: TextStyle(
                fontSize: size,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 2),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    ),
  );
}
