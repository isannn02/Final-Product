import 'package:aplikasi_body_goals/model/user_info_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import '../app/config_app.dart';

class AllServices {
  //--singleton--
  static final AllServices _instance = AllServices._internal();
  AllServices._internal();
  factory AllServices() {
    return _instance;
  }

  //-- dio initialize--
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConfigApp.baseUrl,
    ),
  );

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token ?? "";
  }

//----------------------------------------------------------------------------------------//

  Future<UserInfoResponseModel> getInfoUsers() async {
    try {
      String token = await getToken();
      final response = await _dio.get(
        '/user',
        options: Options(
          headers: {
            'access_token': token,
          },
        ),
      );

      UserInfoResponseModel result =
          UserInfoResponseModel.fromJson(response.data);

      return result;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> updateArticle({
    required String filePath,
    required String title,
    required String detail,
    required String idArticle,
  }) async {
    try {
      String token = await getToken();
      var response = await _dio.put(
        "/event/$idArticle",
        data: FormData.fromMap({
          'title': title,
          'detail': detail,
          'photoEvent': await MultipartFile.fromFile(
            filePath,
            filename: path.basename(filePath),
            contentType: MediaType('image', "jpeg"),
          ),
        }),
        options: Options(
          headers: {
            'access_token': token,
          },
        ),
      );
      // return response.statusCode.toString();
      return response.data['message'][0];
    } on DioException catch (e) {
      return e.response?.data['errors'] ?? "gagal mengubah artikel";
    }
  }

  Future<String> updateNutrition({
    required String iamgeFilePath,
    required String name,
    required String link,
    required String idNutrion,
  }) async {
    try {
      String token = await getToken();
      var response = await _dio.put(
        "/nutrition/$idNutrion",
        data: FormData.fromMap({
          'name': name,
          'link': link,
          'photo': await MultipartFile.fromFile(
            iamgeFilePath,
            filename: path.basename(iamgeFilePath),
            contentType: MediaType('image', "jpeg"),
          ),
        }),
        options: Options(
          headers: {
            'access_token': token,
          },
        ),
      );
      // return response.statusCode.toString();
      return response.data['message'][0];
    } on DioException catch (e) {
      return e.response?.data['errors'] ?? "gagal mengubah artikel";
    }
  }

  Future<String> updateTrainer({
    required String iamgeFilePath,
    required String nameTrainer,
    required String phone,
    required String idTrainer,
  }) async {
    try {
      String token = await getToken();
      var response = await _dio.put(
        "/contact/$idTrainer",
        data: FormData.fromMap({
          'nama': nameTrainer,
          'no_hp': phone,
          'photo': await MultipartFile.fromFile(
            iamgeFilePath,
            filename: path.basename(iamgeFilePath),
            contentType: MediaType('image', "jpeg"),
          ),
        }),
        options: Options(
          headers: {
            'access_token': token,
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      return response.data['message'][0];
    } on DioException catch (e) {
      debugPrint(e.response?.data['errors'][0]);
      // return "asw";
      return e.response?.data['errors'][0] ?? "gagal mengubah artikel";
    }
  }
}
