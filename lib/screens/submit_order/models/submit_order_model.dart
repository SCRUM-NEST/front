import 'package:fhemtni/services/orders_service.dart';
import 'package:fhemtni/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class SubmitOrderModel extends ChangeNotifier{
  bool isLoading=false;

  final int tailorId;

  SubmitOrderModel(this.tailorId);


  Future<void> submit(BuildContext context,
  {
    required String description,
    required String cost
  })async{

    isLoading=true;
    notifyListeners();

    final ordersService=GetIt.I.get<OrdersService>();

    await ordersService.SubmitOrder(desctiption: description, tailorId: tailorId, cost: cost);

     isLoading=false;
    notifyListeners();

    ToastUtils.show(context, "Order created");
    Navigator.pop(context);
  }

}