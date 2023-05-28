import 'package:sqlite_crud/db_helper/repository.dart';

import '../model/user.dart';

class UserServices {
  late Repository _repository;
  UserServices() {
    _repository = Repository();
  }
  SaveUser(User user) async {
    return await _repository.InsertData('user', user.userMap());
  }

  raadAllUser() async {
    return await _repository.readData('user');
  }

  UpdateUser(User user) async {
    return await _repository.UpdataData('user', user.userMap());
  }

  deletUser(userId) async {
    return await _repository.deleteDatabyid('user', userId);
  }
}
