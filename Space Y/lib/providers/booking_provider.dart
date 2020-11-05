import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:space_y/api/api.dart';
import 'package:space_y/blocs/user_bloc.dart';
import 'package:space_y/models/tickets_model.dart';

class BookingProvider {
  final Client kClient = Client();

  Future<String> buyTicket({
    String date,
    bool massage,
    bool meal,
    bool pool
  })
  async {

    final Map<String, dynamic> kData = <String, dynamic> {
      'date_takeoff': date,
      'massage': massage,
      'no_gravity_meal': meal,
      'no_gravity_pool': pool,
    };
    final String kToken = await kUserBloc.getToken();


    final String kBody = json.encode(kData);
    final Map<String, String> kHeader = <String, String> {
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response kRes = await kClient.post(
      kTicketsRoute,
      headers: kHeader,
      body: kBody,
    );
    if (kRes.statusCode == 200) {
      print(kRes.body.toString());
      return kRes.body.toString();
    } else {
      throw Exception('Failed to book a ticket');
    }
  }

  Future<Tickets> getBookedTickets() async {
    final String kToken = await kUserBloc.getToken();
    final Map<String, String> kHeader = <String, String> {
      'custom_auth': 'authorization=Token ' + kToken,
      'Content-Type': 'application/json',
    };

    final Response kRes = await kClient.get(
        kTicketsRoute,
        headers: kHeader
    );
    if (kRes.statusCode == 200) {
      final List<dynamic> kTicketMap = jsonDecode(kRes.body) as List<dynamic>;
      final Tickets kTickets = Tickets.fromJson(kTicketMap);
      return kTickets;
    } else {
      throw Exception('Failed to get the tickets');
    }
  }
}