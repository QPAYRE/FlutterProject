import 'package:flutter/material.dart';
import 'package:space_y/models/user_model.dart';

Container profileHeader(BuildContext context, UserModel user) {
  return Container(
    padding: const EdgeInsets.only(left: 20, right: 20),
    height: MediaQuery.of(context).size.height * 0.2,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/emusk.jpg'),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
                height: 90,
                alignment: Alignment.topLeft,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.username,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ],
                )),
          ],
        )
      ],
    ),
  );
}
