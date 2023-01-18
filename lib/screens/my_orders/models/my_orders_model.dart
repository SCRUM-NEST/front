import 'package:fhemtni/core/order.dart';
import 'package:flutter/cupertino.dart';

class MyOrdersModel extends ChangeNotifier {
  List<Order> orders = [];
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    orders = List.generate(
        40,
        (index) => Order(
            id: index,
            createdAt: DateTime.now(),
            specifications: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            meetLink: null,
            meetDate: null,
            status: index % 4 == 0
                ? OrderStatus.accpeted
                : index % 4 == 1
                    ? OrderStatus.declined
                    : index % 4 == 2
                        ? OrderStatus.delivered
                        : OrderStatus.pending));

    isLoading = false;
    notifyListeners();
  }
}
