import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import 'package:space_y/models/tickets_model.dart';
import 'package:space_y/providers/repository.dart';

class Booking extends Validators {
  Repository repository = Repository();

  Future<String> sendBooking({bool massage, bool meal, bool pool}) async {

    String res;
    final DateTime kNow = DateTime.now();

    res = await submitBooking(kNow.toString(), massage, meal, pool);
    return res;
  }

  Future<String> submitBooking(String date, bool massage, bool meal, bool pool) async {
    final String kRes = await repository.booking(date, massage, meal, pool);
    if (kRes != null) {
      print('booking sent');
      return kRes;
    } else {
      print('error: booking');
    }
    return kRes;
  }

  final kTickets = PublishSubject<Tickets>();
  Stream<Tickets> get allTickets => kTickets.stream;

  Future<Tickets> getUserTickets() async {
    final Tickets res = await repository.getBookedTickets();
    return res;
  }

  List<List> BookingMenuButtons = [
    ["Get free Ticket", true],
    ["My Tickets", false]
  ];

  final PublishSubject _changeBookingSection = PublishSubject<List<List>>();
  Stream<List<List>> get changeBookingSection => _changeBookingSection.stream;

  changeBookingMenuSection(int section) {
    if (section == 0) {
      BookingMenuButtons[0][1] = true;
      BookingMenuButtons[1][1] = false;
      _changeBookingSection.sink.add(BookingMenuButtons);
      dispose();
    }
    if (section == 1) {
      BookingMenuButtons[0][1] = false;
      BookingMenuButtons[1][1] = true;
      _changeBookingSection.sink.add(BookingMenuButtons);
    }
  }

  void dispose() {
  }
}

class Validators{
}