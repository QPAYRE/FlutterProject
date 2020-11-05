import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:space_y/providers/repository.dart';

import 'package:space_y/models/auth_model.dart';
import 'package:space_y/blocs/login_bloc.dart';

class SignUpBloc extends Validators {
  Repository repository = Repository();

  final BehaviorSubject<String> _usernameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  final PublishSubject<bool> _loadingData = PublishSubject<bool>();
  Stream<bool> get loading => _loadingData.stream;

  Stream<String> get username => _usernameController.stream.transform(kValidateUsername);
  Stream<String> get email => _emailController.stream.transform(kValidateEmail);
  Stream<String> get password => _passwordController.stream.transform(kValidatePassword);

  Stream<bool> get submitValid => Rx.combineLatest3(username, email, password, (String username, String  email, String password) => true);

  void submit() {
    final String validUsername = _usernameController.value;
    final String validEmail = _emailController.value;
    final String validPassword = _passwordController.value;

    _loadingData.sink.add(true);

    signUp(validUsername , validEmail, validPassword);

    kLoginBloc.login(validEmail, validPassword);
  }

  Future<bool> signUp(String username, String email, String password) async {
    final AuthModel kAuth = await repository.signUp(username, email, password);
    _loadingData.sink.add(false);
    if (kAuth != null) {
      print('SignUp authorized\nWelcome ' + kAuth.email + '\n');
      print(kAuth.token);
      return true;
    } else {
      print('SignUp refused');
      return false;
    }
  }

  void dispose() {
    _usernameController.close();
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}

class Validators {
  final StreamTransformer<String, String> kValidateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
    const String pattern = r'^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp kRegex = RegExp(pattern);
    if (kRegex.hasMatch(email))
      sink.add(email);
    else
      sink.addError('The email address must be valid');
  });
  
  final StreamTransformer<String, String> kValidatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
    if (password.length > 8) {
      sink.add(password);
    } else {
      sink.addError('The password must be at least 9 characters long');
    }
  });

  final StreamTransformer<String, String> kValidateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (String username, EventSink<String> sink) {
    if (username.length > 5) {
      sink.add(username);
    } else {
      sink.addError('The username must be at least 6 characters long');
    }
  });
}

final SignUpBloc kSignUpBloc = SignUpBloc();