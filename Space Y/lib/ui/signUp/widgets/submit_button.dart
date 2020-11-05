import 'package:space_y/blocs/signUp_bloc.dart';
import 'package:flutter/material.dart';

Widget submitButton(SignUpBloc bloc) => StreamBuilder<bool>(
  stream: bloc.submitValid,
  builder: (BuildContext context, AsyncSnapshot<bool> snap) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      height: 55,
      minWidth: MediaQuery.of(context).size.width,
      child: RaisedButton(
        key: const Key('SignUpSubmitButton'),
        disabledColor: Colors.grey[400],
        disabledTextColor: Theme.of(context).primaryColorDark,
        onPressed: (!snap.hasData) ? null : bloc.submit,
        child: const Text(
          'Inscription',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Theme.of(context).primaryColorDark,
      ),
    );
  },
);