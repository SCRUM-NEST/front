class Order {
  final DateTime createdAt;
  final int id;
  final String specifications;
  final String? meetLink;
  final DateTime? meetDate;
  final OrderStatus status;

  Order(
      {required this.id,
      required this.createdAt,
      required this.specifications,
      required this.meetLink,
      required this.meetDate,
      required this.status});

  factory Order.fromMap(Map<String, dynamic> data) {
    return Order(
        id: data['id'],
        createdAt: DateTime.parse(data['createdAt']),
        specifications: data['specifications'],
        meetLink: data['specifications'],
        meetDate: data['meetDate'] != null ? DateTime.parse(data['meetDate']) : null,
        status: data['status'] == "delivered"
            ? OrderStatus.delivered
            : data['status'] == "accepted"
                ? OrderStatus.accpeted
                : data['status'] == "declined"
                    ? OrderStatus.declined
                    : OrderStatus.pending);
  }
}

enum OrderStatus { pending, accpeted, declined, delivered }
