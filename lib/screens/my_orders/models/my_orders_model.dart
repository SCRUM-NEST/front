import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/core/order.dart';
import 'package:fhemtni/services/orders_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class MyOrdersModel extends ChangeNotifier {
  List<Order> orders = [];
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
  try{
  isLoading = true;
    notifyListeners();
    final ordersService = GetIt.I.get<OrdersService>();
    orders = await ordersService.getOrders();

    isLoading = false;
    notifyListeners();
  }on AppException catch(e){
    print(e.message);

  }
  }
}
