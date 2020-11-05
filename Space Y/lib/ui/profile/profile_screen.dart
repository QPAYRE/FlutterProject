import 'package:space_y/blocs/login_bloc.dart';
import 'package:space_y/blocs/user_bloc.dart';
import 'package:space_y/models/user_model.dart';

import 'package:space_y/ui/profile/widgets/profile_header.dart';
import 'package:space_y/ui/profile/widgets/profile_info.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserBloc userBloc;
  LoginBloc loginBloc;
  UserModel user;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
    loginBloc = LoginBloc();
    userBloc.getUser();
  }

  @override
  void dispose() {
    userBloc.dispose();
    super.dispose();
  }

  void updateProfileState() {
    setState(() {
      userBloc.getUser();
    });
  }


  Container profile(BuildContext context, AsyncSnapshot<UserModel> snapshot) {
    final UserModel kUser = snapshot.data;

    return Container(
      child: Column(
        children: <Widget>[
          profileHeader(context, kUser),
          profileInfo(context, kUser, loginBloc),
        ],
      ),
    );
  }

  Widget buildProfileView(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: userBloc.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          return profile(context, snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Padding(
          padding: EdgeInsets.only(top: 70, left: 20),
          child: Center(
            child: LinearProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          buildProfileView(context),
        ],
      ),
    );
  }
}