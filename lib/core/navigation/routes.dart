class Routes {
  static Future<String> get initialRoute async {
    try {
      return login;
    } catch (err) {
      return login;
    }
  }

  static const login = '/login';
  static const home = '/home';
}