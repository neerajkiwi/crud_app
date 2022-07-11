import "package:dio/dio.dart";

class DioApi {
  final Dio _dio = Dio();

  final _url = 'https://jsonkeeper.com/b/N54Z';

  Future<List> getResponse() async {
    Response response = await _dio.get(_url);
    return response.data["users"];
  }
}
