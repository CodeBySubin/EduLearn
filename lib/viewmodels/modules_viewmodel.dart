import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_project/core/network/api_client.dart';
import 'package:lms_project/core/network/api_endpoint.dart';
import 'package:lms_project/core/network/dio_exception.dart';
import 'package:lms_project/model/module_model.dart';

class ModulesViewmodel extends ChangeNotifier {
  final apiClient = ApiClient();
  bool isLoading = false;
  List<ModuleModel> modulelist = [];
  Errors? errorMessage;

  Future<void> fetchModules(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.get(
        APIEndPoints.modules,
        params: {"subject_id": id},
      );
      if (response.statusCode == 200) {
        modulelist =
            (jsonDecode(response.data) as List)
                .map((json) => ModuleModel.fromJson(json))
                .toList();
      }
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
