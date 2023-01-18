import 'dart:convert';
import 'package:fhemtni/common/app_config.dart';
import 'package:fhemtni/core/app_exception.dart';
import 'package:fhemtni/screens/sign_in/views/sign_in.dart';
import 'package:fhemtni/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:fhemtni/utils/api_base_helper.dart';
import 'package:fhemtni/core/user.dart';

class Auth {
  String? accessToken;
  User? user;

  bool get isConnected => accessToken != null && user != null;

  final _logger = Logger("Auth");

  final _storage = const FlutterSecureStorage();

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final body = {
        "username": username,
        "password": password,
      };

      final appConfig = GetIt.I.get<AppConfig>();

      final url = appConfig.apiBaseUrl + Endpoints.login;

      final response = await ApiBaseHelper.post(
        url,
        logger: _logger,
        body: body,
        headers: ApiBaseHelper.headers(),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> body = json.decode(response.body);

        accessToken = body['access_token'];
        user = User.fromMap(body['user']);

        _logger.info("Login successful");
      } else if (response.statusCode == 4047) {
        throw AppException(message: "Invalid email or password!");
      } else {
        throw AppException(message: "Unknown error!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
    required String email,
  }) async {
    try {
      final body = {
        "username": username,
        "password": password,
        "email": email,
        "role": role,
        "firstName": firstName,
        "lastName": lastName
      };

      final appConfig = GetIt.I.get<AppConfig>();

      final url = appConfig.apiBaseUrl + Endpoints.register;

      final response = await ApiBaseHelper.post(
        url,
        logger: _logger,
        body: body,
        headers: ApiBaseHelper.headers(),
      );

      if (response.statusCode == 201) {
      } else if (response.statusCode == 409) {
        throw AppException(message: "Username and email have to be unique!");
      } else {
        throw AppException(message: "Unknown error!");
      }
    } catch (e, stack) {
      throw AppException.formatServiceException(_logger, e, stack);
    }
  }

  Future<void> signOut(BuildContext context) async {
    accessToken = null;
    user = null;
    await _storage.delete(key: "token");
    SignIn.create(context);
  }

  Future<void> init() async {
    final _accessToken = await _storage.read(key: "token");

    if (_accessToken == null) {
      throw AppException(message: "Token not found!");
    } else {
      accessToken = _accessToken;
    }
  }
}
