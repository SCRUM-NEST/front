import 'dart:convert';

import 'package:fhemtni/common/app_config.dart';
import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/core/order.dart';
import 'package:fhemtni/screens/submit_order/views/submit_order.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:fhemtni/utils/api_base_helper.dart';
import 'package:fhemtni/utils/endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class OrdersService {
  final _logger = Logger("Orders Service");

  Future<List<Order>> getOrders() async {
    final auth = GetIt.I.get<Auth>();

    final appConfig = GetIt.I.get<AppConfig>();

    final url = appConfig.apiBaseUrl +
        (auth.user!.role == "tailor"
            ? Endpoints.tailorOrders(auth.user!.id)
            : Endpoints.userOrders(auth.user!.id));

    try {
      final response = await ApiBaseHelper.get(
        url,
        logger: _logger,
      );

      if (response.statusCode == 200) {
        final body = List.from(json.decode(response.body));

        return body.map((e) => Order.fromMap(e)).toList();
      } else {
        throw AppException(message: "Can't get orders!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }

  Future<void> SubmitOrder(
      {required String desctiption,
      required int tailorId,
      required String cost}) async {
    final auth = GetIt.I.get<Auth>();

    final appConfig = GetIt.I.get<AppConfig>();

    final url = appConfig.apiBaseUrl + Endpoints.order;

    try {
      final response = await ApiBaseHelper.post(url,
          logger: _logger,
          body: {
            "description": desctiption,
            "userId": auth.user!.id,
            "tailorId": tailorId,
            "cost": int.parse(cost)
          },
          headers: ApiBaseHelper.headers());

      if (response.statusCode == 201) {
      } else {
        throw AppException(message: "Can't create order!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }
}
