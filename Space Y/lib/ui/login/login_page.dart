import 'package:space_y/blocs/login_bloc.dart';
import 'package:space_y/ui/login/widgets/email_field.dart';
import 'package:space_y/ui/login/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  void initState() {
    loginBloc = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  Widget emailField(LoginBloc loginBloc, String fieldLabel, double labelSize) =>
      StreamBuilder<String>(
        stream: loginBloc.email,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return createEmailRequiredTextfield(
              context, snapshot, fieldLabel, labelSize, loginBloc);
        },
      );

  Widget passwordField(
          LoginBloc loginBloc, String fieldLabel, double labelSize) =>
      StreamBuilder<String>(
        stream: loginBloc.password,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return createPasswordRequiredTextField(
              context, snapshot, fieldLabel, labelSize, loginBloc);
        },
      );

  Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (BuildContext context, AsyncSnapshot<bool> snap) {
          return ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            height: 55,
            minWidth: MediaQuery.of(context).size.width,
            child: RaisedButton(
              key: const Key('loginSubmitButton'),
              disabledColor: Colors.grey[400],
              disabledTextColor: Theme.of(context).primaryColorDark,
              onPressed: (!snap.hasData) ? null : bloc.submit,
              child: const Text(
                'Connexion',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Theme.of(context).primaryColorDark,
            ),
          );
        },
      );

  Widget buildLoginView(BuildContext context, LoginBloc loginBloc) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        key: const Key('loginScrollableColumn'),
        children: <Widget>[
          emailField(loginBloc, 'E-mail', 20),
          const SizedBox(
            height: 10,
          ),
          passwordField(loginBloc, 'Mot de passe', 20),
          const SizedBox(
            height: 130,
          ),
          submitButton(loginBloc),
        ],
      ),
    );
  }

  Widget loginHeader(BuildContext context, String header, double size) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 123, left: 30),
      //color: Colors.blueGrey,
      constraints: const BoxConstraints(maxWidth: 120),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 180),
        //color: Colors.cyan,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(),
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
                  width: 170,
                  height: 2,
                  color: Theme.of(context).accentColor,
                ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          loginHeader(context, 'CONNEXION', 30),
          buildLoginView(context, loginBloc),
        ],
      ),
    );
  }
}