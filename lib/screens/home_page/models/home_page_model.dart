import 'package:fhemtni/core/retailer.dart';

import 'package:flutter/cupertino.dart';

class HomePageModel extends ChangeNotifier {
  List<Retailer> retailers = [];
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    retailers = List.generate(40,
        (index) => Retailer(id: index, firstName: "Retailer", lastName: index.toString(), email: "retailer@gmail.com"));

    isLoading = false;
    notifyListeners();
  }
}
