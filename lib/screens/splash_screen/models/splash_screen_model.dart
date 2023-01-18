import 'package:fhemtni/common/app_config.dart';
import 'package:fhemtni/screens/sign_in/views/sign_in.dart';
import 'package:fhemtni/services/auth.dart';
import 'package:fhemtni/services/orders_service.dart';
import 'package:fhemtni/services/tailors_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SplashScreenModel extends ChangeNotifier {
  final String env;
  SplashScreenModel({required this.env});
  bool hasError = false;
  bool isLoading = true;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    GetIt.I.registerSingleton(AppConfig());
    GetIt.I.registerSingleton(Auth());
    GetIt.I.registerSingleton(OrdersService());
    GetIt.I.registerSingleton(TailorsService());

    ///Load app configuration
    final appConfig = GetIt.I.get<AppConfig>();
    await appConfig.fromConfiguration(context, env: env);

    SignIn.create(context, returnBack: false);
  }
}
