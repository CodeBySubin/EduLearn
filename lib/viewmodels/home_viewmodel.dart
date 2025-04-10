import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_project/core/network/api_client.dart';
import 'package:lms_project/core/network/api_endpoint.dart';
import 'package:lms_project/core/network/dio_exception.dart';
import 'package:lms_project/model/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final apiClient = ApiClient();
  bool isLoading = false;
  List<Homemodel> homelsit = [];
  String? errorMessage;
  int selectedIndex = 0;

  //Fetching data from api
  Future<void> fetchHome() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.get(APIEndPoints.home);
      if (response.statusCode == 200) {
        homelsit =
            (jsonDecode(response.data) as List)
                .map((json) => Homemodel.fromJson(json))
                .toList();
      }
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e).toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
