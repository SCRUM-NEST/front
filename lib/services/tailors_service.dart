import 'dart:convert';

import 'package:fhemtni/common/app_config.dart';
import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/core/retailer.dart';
import 'package:fhemtni/utils/api_base_helper.dart';
import 'package:fhemtni/utils/endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

class TailorsService {
  final _logger = Logger("Tailors Service");

  Future<List<Retailer>> getTailors() async {
    final appConfig = GetIt.I.get<AppConfig>();

    final url = appConfig.apiBaseUrl + Endpoints.tailors;

    try {
      final response = await ApiBaseHelper.get(
        url,
        logger: _logger,
      );

      if (response.statusCode == 200) {
        final body = List.from(json.decode(response.body));

        return body.map((e) => Retailer.fromMap(e)).toList();
      } else {
        throw AppException(message: "Can't get orders!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }
}
