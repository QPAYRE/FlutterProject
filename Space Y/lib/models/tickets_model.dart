import 'package:space_y/models/ticket_model.dart';

class Tickets {
  List<Ticket> _tickets = [];
  Tickets.fromJson(List<dynamic> jsonTickets) {
    for (int i = 0; i < jsonTickets.length; i++) {
      tickets.add(Ticket.fromJson(jsonTickets[i] as Map<String, dynamic>));
    }
  }
  List<Ticket> get tickets => _tickets;
}