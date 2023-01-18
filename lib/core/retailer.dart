class Retailer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Retailer({required this.id, required this.firstName, required this.lastName, required this.email});

  factory Retailer.fromMap(Map<String, dynamic> data) {
    return Retailer(id: data['id'], firstName: data['firstName'], lastName: data['lastName'], email: data['email']);
  }
}
