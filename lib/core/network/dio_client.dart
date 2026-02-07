
import 'package:appointment/core/constant/app_strings.dart';
import 'package:dio/dio.dart';

import '../utils/pref_helper.dart';


class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppStrings.apiURL,
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
    //to see all the request and response from the backend

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          final token = await PrefHelper.getToken();
          print(' API Request to: ${options.path}');
          print(' Token for request: ${token ?? 'null'}');

          if (token != null && token.isNotEmpty ) {
            options.headers['Authorization'] = 'Bearer $token';
            print('Authorization header added');
          } else {
            print('No authorization header added');
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
