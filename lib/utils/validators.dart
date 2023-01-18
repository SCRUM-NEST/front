class Validators{
  Validators._();


  static bool email(String email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static bool password(String password) =>
      password.length >= 8;

  static bool code(String code) =>
      code.length >= 9;

  static bool firstName(String firstName) =>
      firstName.isNotEmpty;
  static bool lastName(String lastName) =>
      lastName.isNotEmpty;

  static bool phone(String phone) =>
      phone.length == 8;

  static bool username(String username) =>
      username.length>=4;
}