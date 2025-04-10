import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_project/core/network/api_client.dart';
import 'package:lms_project/core/network/api_endpoint.dart';
import 'package:lms_project/core/network/dio_exception.dart';
import 'package:lms_project/model/video_model.dart';

class VideoViewmodel extends ChangeNotifier {
  final apiClient = ApiClient();
  bool isLoading = false;
  List<Videomodel> videolist = [];
  Errors? errorMessage;
  Videomodel? videwModel;
  bool isFullScreen = false;

  Future<void> fetchvideos(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await apiClient.get(
        APIEndPoints.videos,
        params: {"module_id": id},
      );
      if (response.statusCode == 200) {
        videolist =
            (jsonDecode(response.data) as List)
                .map((json) => Videomodel.fromJson(json))
                .toList();
        videwModel = videolist.first;
      }
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
