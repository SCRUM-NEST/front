import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:fhemtni/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpModel extends ChangeNotifier {
  bool isLoading = false;

  bool passwordsMatch = true;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void changeConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

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

  Future<void> submit(BuildContext context,
      {required String username, required String password, required String email, required String role}) async {
    try {
      isLoading = true;
      notifyListeners();

      final auth = GetIt.I.get<Auth>();

      await auth.register(username: username, password: password, email: email, role: role);

      Navigator.pop(context);
    } on AppException catch (e) {
      ToastUtils.show(context, e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
