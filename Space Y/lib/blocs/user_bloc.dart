import 'package:space_y/models/user_model.dart';
import 'package:space_y/providers/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:space_y/blocs/auth_bloc.dart';

class UserBloc {
  final Repository kRepository = Repository();
  final PublishSubject<UserModel> kUserFetcher = PublishSubject<UserModel>();

  Stream<UserModel> get user => kUserFetcher.stream;
  Future<String> getToken() async {
    return await authBloc.getToken();
  }

  Future<UserModel> getUser() async {
    final UserModel kUser = await kRepository.getUser();
    kUserFetcher.sink.add(kUser);
    return kUser;
  }

  Future<UserModel> getUserById(String userId) async {
    final UserModel kUser = await kRepository.getUserById(userId);
    return kUser;
  }

  Future<bool> editUser({String username, String email}) async {
    final UserModel oldUser = await kRepository.getUser();

    username ??= oldUser.username;
    email ??= oldUser.email;

    final UserModel kUser = await kRepository.editUser(username, email);
    kUserFetcher.sink.add(kUser);
    return true;
  }

  dynamic dispose() async => kUserFetcher.close();
}

final UserBloc kUserBloc = UserBloc();
