import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  final PublishSubject<bool> _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }

  Future<bool> restoreSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _tokenString = prefs.get('token') as String;

    if (_tokenString != null && _tokenString.isNotEmpty) {
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
    return true;
  }

  Future<bool> openSession(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    _isSessionValid.sink.add(true);

    return true;
  }

  Future<bool> closeSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _isSessionValid.sink.add(false);
    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('token') as String;
  }
}

final AuthBloc authBloc = AuthBloc();
