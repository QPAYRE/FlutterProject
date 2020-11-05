import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:space_y/api/api.dart';
import 'package:space_y/blocs/user_bloc.dart';
import 'package:space_y/models/user_model.dart';

class UserProvider {
  Client client = Client();

  Future<UserModel> getUser() async {
    final String kToken = await kUserBloc.getToken();
    final Map<String, String> kHeader = <String, String> {
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response res = await client.get(kGetUserRoute, headers: kHeader);
    if (res.statusCode == 200) {
      final Map<String, dynamic> kJsonBody = json.decode(res.body) as Map<String, dynamic>;
      final UserModel kUser = UserModel.fromJson(kJsonBody);
      return kUser;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future<UserModel> getUserById(String userId) async {
    final String kToken = await kUserBloc.getToken();
    final Map<String, String> kHeader = <String, String> {
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response res = await client.get(kGetUserByIdRoute + userId, headers: kHeader);
    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to get user');
    }
  }

  Map<String, dynamic> getMapFromParameters(String username, String email) {
    final Map<String, dynamic> data = <String, dynamic>
    {
      'username': username,
      'email': email
    };

    if (username == null) {
      data.remove('username');
    }
    if (email == null) {
      data.remove('email');
    }

    return data;
    }

  Future<UserModel> editUser(String username, String email) async {
    final String kToken = await kUserBloc.getToken();
    final Map<String, dynamic> kData = getMapFromParameters(username, email);
    final String kBody = json.encode(kData);
    final Map<String, String> kHeader = <String, String>{
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response kRes = await client.post(kEditUserRoute,
        headers: kHeader,
        body: kBody);
    if (kRes.statusCode == 200) {
      return UserModel.fromJson(json.decode(kBody) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to Update the profile');
    }
  }
}

