class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        role: data['role']);
  }
}
