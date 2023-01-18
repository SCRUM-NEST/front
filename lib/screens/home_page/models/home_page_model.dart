import 'package:fhemtni/core/retailer.dart';
import 'package:fhemtni/services/tailors_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomePageModel extends ChangeNotifier {
  List<Retailer> retailers = [];
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final tailorsService=GetIt.I.get<TailorsService>();
    retailers = await tailorsService.getTailors();

    isLoading = false;
    notifyListeners();
  }
}
