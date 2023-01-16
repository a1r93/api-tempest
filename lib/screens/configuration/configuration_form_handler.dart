import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FormField<T> {
  T? value;
  String? error;
  TextEditingController controller = TextEditingController();
  String? Function(String?)? validator;

  FormField({this.value, this.validator});

  void setValue(T? value) {
    this.value = value;
  }

  void setError(String? error) {
    this.error = error;
  }
}

class ConfigurationFormHandler extends ChangeNotifier {
  final Logger _logger = getLogger('ConfigurationFormHandler');

  FormField<String> collectionUrl = FormField<String>(validator: (value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return Uri.parse(value).isAbsolute ? null : 'Please enter a valid URL';
  });

  FormField<String> collectionFileContent = FormField<String>(validator: (value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return Helpers.isValidJson(value) ? null : 'Please enter a valid JSON';
  });

  FormField<String> environmentVariables = FormField<String>(validator: (value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return Helpers.isValidJson(value) ? null : 'Please enter a valid JSON';
  });

  FormField<int> nbParallelRequests = FormField<int>();
  FormField<int> nbIterations = FormField<int>();
  FormField<bool> ignoreRedirects = FormField<bool>();

  FormField? getProperty(String property) => {
        "collectionUrl": collectionUrl,
        "collectionFileContent": collectionFileContent,
        "environmentVariables": environmentVariables,
        "nbParallelRequests": nbParallelRequests,
        "nbIterations": nbIterations,
        "ignoreRedirects": ignoreRedirects,
      }[property];

  void setValue(String property, dynamic value) {
    try {
      String? error = getProperty(property)?.validator!(value);
      if (error != null) {
        setError(property, error);
        return;
      }
      setError(property, null);
      getProperty(property)!.setValue(value);
    } catch (error, stackTrace) {
      _logger.e('An error occured when trying to set the value of $property, value: $value', error, stackTrace);
      throw Exception("Invalid collectionUrl");
    }
    notifyListeners();
  }

  void setError(String property, String? error) {
    try {
      getProperty(property)!.setError(error);
    } catch (error, stackTrace) {
      _logger.e('An error occured when trying to set an error for $property, error: $error', error, stackTrace);
      throw Exception("Invalid collectionUrl");
    }
    notifyListeners();
  }

  @override
  void dispose() {
    collectionUrl.controller.dispose();
    collectionFileContent.controller.dispose();
    environmentVariables.controller.dispose();
    nbParallelRequests.controller.dispose();
    nbIterations.controller.dispose();
    ignoreRedirects.controller.dispose();
    super.dispose();
  }
}
