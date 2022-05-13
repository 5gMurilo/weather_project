import 'package:dio/dio.dart';
import 'package:flutter_wheater/src/controller/client/my_http_client.dart';

class DioClient implements MyHttpClient {
  final dio = Dio();

  @override
  Future<dynamic> get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
