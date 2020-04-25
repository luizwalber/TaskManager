abstract class LocaleRepository {
  Future<String> fetchUserLocale();

  Future<void> changeLocale(String newLocale);
}
