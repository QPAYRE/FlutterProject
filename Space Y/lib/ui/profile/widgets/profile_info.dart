import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' show Response, Client;
import 'package:space_y/blocs/login_bloc.dart';
import 'package:space_y/models/user_model.dart';

// GestureDetector(
// onTap: () async {
// _address = await getAddress();
// },
// child: Text(
// _address,
// ),
// ),

String _address = 'Taper ici pour rechercher';

Future<String> getAddress() async {
  final List<double> kLatLon = await getLatLonFromGPS();
  final Response address = await getAddressFromLatLon(kLatLon[0], kLatLon[1]);


  final Map<String, dynamic> kResJson = json.decode(address.body) as Map<String, dynamic>;
  print(kResJson['features'][0]['properties']['label']);
  return kResJson['features'][0]['properties']['label'] as String;
}

Future<Response> getAddressFromLatLon(double lon, double lat) async {
  final Client kClient = Client();

  const String kBaseUrl = 'https://api-adresse.data.gouv.fr/reverse/';
  final String parameters = '?lon=$lon&lat=$lat';
  final Response kAddressFromApi = await kClient.get(
      kBaseUrl + parameters);

  return kAddressFromApi;
}

Future<List<double>> getLatLonFromGPS() async {
  final Position kPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  final List<double> kLonLat = <double>[];

  kLonLat.add(kPosition.toJson()['longitude'] as double);
  kLonLat.add(kPosition.toJson()['latitude'] as double);
  return kLonLat;
}

SingleChildScrollView profileInfo(BuildContext context, UserModel user, LoginBloc loginBloc) {
  return SingleChildScrollView(
    key: const Key('ProfileScrollable'),
    child: Column(
      children: <Widget> [
        const Text('Email',
            textScaleFactor: 1.4, style: TextStyle()),
        displayEmail(context, user),
        const Text('Adresse',
            textScaleFactor: 1.4, style: TextStyle()),
        displayAddress(context),
        RaisedButton(
          key: const Key('LogoutButton'),
          onPressed: loginBloc.logout,
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
        ),
      ],
    ),
  );
}

Container displayAddress(BuildContext context) {
  return Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          borderOnForeground: false,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        _address = await getAddress();
                      },
                      child: Text(
                        _address,
                        style: const TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

Container displayEmail(BuildContext context, UserModel user) {
  return Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.white,
          borderOnForeground: false,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      user.email,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      textScaleFactor: 1.15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
