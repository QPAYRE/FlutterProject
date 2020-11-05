import 'dart:async';
import 'package:space_y/models/auth_model.dart';
import 'package:space_y/models/tickets_model.dart';
import 'package:space_y/models/user_model.dart';
import 'package:space_y/providers/user_provider.dart';
import 'package:space_y/providers/auth_provider.dart';
import 'package:space_y/providers/booking_provider.dart';

class Repository {
  final AuthProvider authProvider = AuthProvider();
  final UserProvider userProvider = UserProvider();
  final BookingProvider ticketProvider = BookingProvider();

  Future<AuthModel> signUp(String username, String email, String password) =>
      authProvider
          .signUp(
              username: username,
              email: email,
              password: password)
          .catchError((dynamic e) {
        print(e);
      });

  Future<AuthModel> login(String email, String password) =>
      authProvider.login(email: email, password: password).catchError((dynamic e) {
        print(e);
      });

  Future<UserModel> getUser() => userProvider.getUser().catchError((dynamic e) {
        print(e);
      });

  Future<UserModel> getUserById(String userId) =>
      userProvider.getUserById(userId).catchError((dynamic e) {
        print(e);
      });

  Future<UserModel> editUser(String username, String email) =>
      userProvider.editUser(username, email).catchError((dynamic e) {
        print(e);
      });

  Future<String> booking(String date, bool massage, bool meal, bool pool) =>
      ticketProvider.buyTicket(date: date, massage: massage, meal: meal, pool: pool)
          .catchError((dynamic e) {
        print(e);
      });
  
  Future<Tickets> getBookedTickets() =>
      ticketProvider.getBookedTickets()
          .catchError((dynamic e) {
    print(e);
  });
}
