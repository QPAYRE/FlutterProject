import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:space_y/providers/repository.dart';

import 'package:space_y/models/auth_model.dart';
import 'package:space_y/blocs/auth_bloc.dart';

class LoginBloc extends Validators {
  Repository repository = Repository();
  final BehaviorSubject<String> _kEmailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _kPasswordController = BehaviorSubject<String>();
  final PublishSubject<bool> _kLoadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _kEmailController.sink.add;
  Function(String) get changePassword => _kPasswordController.sink.add;

  Stream<String> get email => _kEmailController.stream.transform(kValidateEmail);
  Stream<String> get password => _kPasswordController.stream.transform(validatePassword);
  
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (String email, String password) => true);
  Stream<bool> get loading => _kLoadingData.stream;

  void submit() {
    final String kValidEmail = _kEmailController.value;
    final String kValidPassword = _kPasswordController.value;
    _kLoadingData.sink.add(true);
    login(kValidEmail, kValidPassword);
  }


  Future<bool> login(String email, String password) async {
    final AuthModel kAuth = await repository.login(email, password);
    _kLoadingData.sink.add(false);
    if (kAuth != null) {
      print('Connexion authorized\nWelcome ' + kAuth.email + '\n');
      print(kAuth.token);
      authBloc.openSession(kAuth.token);
      _kEmailController.value = ''; /* TODO : Vérifier que tout est ok quand j'enlève ça */
      _kPasswordController.value = '';
      return true;
    } else {
      print('Connexion refused');
      return false;
    }
  }

  void logout() {
    authBloc.closeSession();
  }

  void dispose() {
    _kEmailController.close();
    _kPasswordController.close();
    _kLoadingData.close();
  }
}

class Validators {
  final StreamTransformer<String, String> kValidateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
    const String kPattern = r'^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(kPattern);

    if (regex.hasMatch(email))
      sink.add(email);
    else
      sink.addError('Please insert a valid email address');
  });
  final StreamTransformer<String, String> validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('The password must have at least 8 characters');
    }
  });
}

final LoginBloc kLoginBloc = LoginBloc();