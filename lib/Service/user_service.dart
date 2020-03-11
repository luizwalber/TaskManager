import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/repository/user_repository.dart';

class UserService implements UserRepository {
  final FirebaseAuth auth;

  const UserService(this.auth);

  @override
  Future<User> login() async {
    final firebaseUser = await auth.signInAnonymously();

    return User(
      id: firebaseUser.user.uid,
      name: firebaseUser.user.displayName,
      photoUrl: firebaseUser.user.photoUrl,
    );
  }
}
