class AuthModel {
  AuthModel.fromJson(Map<String, dynamic> parsedJson) {
    final Map<String, dynamic> kData = parsedJson['authUser'] as Map<String, dynamic>;
    _id = kData['id'] as String;
    _email = kData['mail'] as String;
    _token = kData['token'] as String;
  }

  String _id;
  String _email;
  String _token;

  String get id => _id;
  String get email => _email;
  String get token => _token;
}