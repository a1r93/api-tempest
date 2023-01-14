import 'package:api_tempest/utils/localizations.dart';
import 'package:api_tempest/utils/logger/logger.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Helpers {
  static final logger = getLogger('Helpers');

  static String? translate(BuildContext? context, String key, [var args = const []]) {
    if (key == '') {
      return '';
    }

    String? value = AppLocalizations.of(context!)!.translate(key, args);

    if (value == null) {
      logger.w("[TRANSLATION] The translation for $key is missing");
      return key;
    }

    return value;
  }

  static Future<bool> isOffline() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi;
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String camelCaseToWords(String text) {
    return capitalize(text.replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => " ${m[1]!.toLowerCase()}").trim());
  }

  static String camelCaseToKebabCase(String text) {
    return text.replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => "-${m[1]!.toLowerCase()}").trim().substring(1);
  }
}
