import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/screens/home_page/views/home_page.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:fhemtni/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignInModel extends ChangeNotifier {
  bool isLoading = false;
  bool validEmail = true;
  bool validPhone = true;
  bool validPassword = true;

  bool obscurePassword = true;

  String dialCode = "+216";

  void changePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(focusNode);
      notifyListeners();
    }
  }

  void removeFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  Future<void> submit(BuildContext context, {required String username, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();

      final auth = GetIt.I.get<Auth>();

      await auth.login(username: username, password: password);

      HomePage.create(context);
    } on AppException catch (e) {
      ToastUtils.show(context, e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
