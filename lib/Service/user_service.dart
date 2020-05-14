import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/model/User.dart';

/// Service to isolate the actions for the User
class UserService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Firestore firestore = Firestore.instance;

  UserService._();

  static UserService _instance;

  static UserService get instance {
    return _instance ??= UserService._();
  }

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
