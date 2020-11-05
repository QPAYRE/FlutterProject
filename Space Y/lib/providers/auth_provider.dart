import 'dart:convert';

import 'package:space_y/models/auth_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:space_y/api/api.dart' as api;

class AuthProvider {
  Client client = Client();

  Future<AuthModel> login({
    @required String email,
    @required String password,
  }) async {
    final Map<String,String> data = <String,String> {
      'email': email,
      'password': password
    };

    final String body = json.encode(data);
    final Map<String, String> kHeader = <String, String> {
        'Content-Type': 'application/json'
      };

    final Response res = await client.post(
      api.kLoginRoute,
      headers: kHeader,
      body: body,
    );
    if (res.statusCode == 200) {
      final Map<String, dynamic> kData = json.decode(res.body) as Map<String, dynamic>;
      if (kData['error'] == null) {
        return AuthModel.fromJson(json.decode(res.body) as Map<String, dynamic>);
      }
    } else {
      throw Exception('Failed to add new profile');
    }
    return null;
  }

  Future<AuthModel> signUp({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    final Client kClient = Client();
    final Map<String, dynamic> kData = <String, dynamic> {
      'username': username,
      'email': email,
      'password': password
    };

    final String body = json.encode(kData);
    final Map<String, String> kHeader = <String, String> {
      'Content-Type': 'application/json'
    };
    final Response kRes = await kClient.post(
      api.kSignUpRoute,
      headers: kHeader,
      body: body,
    );
    if (kRes.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(kRes.body) as Map<String, dynamic>;
      if (data['error'] == null) {
        AuthModel newUser = AuthModel.fromJson(json.decode(kRes.body) as Map<String, dynamic>);
        newUser = await addNewProfile(newUser);
        return AuthModel.fromJson(json.decode(kRes.body) as Map<String, dynamic>);
      }
    } else {
      throw Exception('Failed to signUp');
    }
    return null;
  }

  Future<AuthModel> addNewProfile(AuthModel newUser) async {
    final String kToken = newUser.token;
    final Client kClient = Client();
    final Map<String, dynamic> data = <String, dynamic> {
      'email' : newUser.email
    };
    final Map<String, String> kHeader = <String, String>{
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response res = await kClient.post(
      api.kAddUserRoute,
      headers: kHeader,
      body: json.encode(data)
    );
    if (res.statusCode == 200) {
      return newUser;
    } else {
      throw Exception('Failed to add the profile');
    }
  }
}
