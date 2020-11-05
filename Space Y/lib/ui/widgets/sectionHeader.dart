import 'package:flutter/material.dart';

Widget header(BuildContext context, String label) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 30,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
