class Endpoints {
  Endpoints._();

  static const String login = "user/login";
  static const String register = "user/register";
  static const String tailors = 'user/getListOfTailors/tailor';
  static const String order = 'order';
  static String userOrders(int id) => 'order/user/$id';
  static String tailorOrders(int id) => 'order/tailor/$id';
}
