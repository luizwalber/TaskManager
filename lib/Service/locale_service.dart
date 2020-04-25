import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/repository/locale_repository.dart';

class LocaleService implements LocaleRepository {
  @override
  Future<String> fetchUserLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String languageCode = 'language_code';
    return prefs.get(languageCode);
  }

  @override
  Future<void> changeLocale(String newLocaleCode) async {
    var prefs = await SharedPreferences.getInstance();

    return await prefs.setString('language_code', newLocaleCode);
  }

//  final FirebaseAuth auth;
//
//  const UserService(this.auth);
//
//  @override
//  Future<User> login() async {
//    final firebaseUser = await auth.signInAnonymously();
//
//    return User(
//      id: firebaseUser.user.uid,
//      name: firebaseUser.user.displayName,
//      photoUrl: firebaseUser.user.photoUrl,
//    );
//  }
}
