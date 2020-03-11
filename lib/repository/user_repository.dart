import 'package:task_manager/model/User.dart';

abstract class UserRepository {
  Future<User> login();
}
