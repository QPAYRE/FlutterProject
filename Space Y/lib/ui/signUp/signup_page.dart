import 'package:flutter/material.dart';

import 'package:space_y/blocs/signUp_bloc.dart';

import 'package:space_y/ui/signUp/widgets/email_field.dart';
import 'package:space_y/ui/signUp/widgets/password_field.dart';
import 'package:space_y/ui/signUp/widgets/username_field.dart';
import 'package:space_y/ui/signUp/widgets/submit_button.dart';
import 'package:space_y/ui/signUp/widgets/signup_header.dart';


class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  SignUpBloc bloc = SignUpBloc();
 
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          signUpHeader(context, 'INSCRITPION', 40),
          buildSignUpView(context),
        ],
      ),
    );
  }

  Widget buildSignUpView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        key: const Key('SignUpScrollableContainer'),
        children: <Widget>[
          usernameField(kSignUpBloc, 'Pseudo', 18),
          emailField(kSignUpBloc, 'E-mail', 18),
          passwordField(kSignUpBloc, 'Mot de passe', 18),
          const SizedBox(
            height: 40,
          ),
          submitButton(kSignUpBloc),
        ],
      ),
    );
  }
}
