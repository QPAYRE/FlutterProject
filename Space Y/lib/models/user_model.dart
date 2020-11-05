class UserModel {
  UserModel.fromJson(Map<String, dynamic> user) {
    print('Getting');
    _id = user['user_id'] as String;
    _username = user['username'] as String;
    _email = user['email'] as String;
  }

  String _id;
  String _username;
  String _email;

  String get id => _id;
  String get username => _username;
  String get email => _email;

}
