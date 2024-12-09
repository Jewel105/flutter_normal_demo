import '../http/dio_util.dart';

// 网络请求示例
// Example usage:
class CommonApi {
  static final DioUtil _dio = DioUtil();

  /// login post request
  static Future<String> login(Map<String, dynamic> data) async {
    final String response =
        await _dio.post(url: '/common/user/login', data: data);
    return response;
  }

  /// logout get request
  static Future<bool> logout() async {
    return await _dio.get(url: '/common/user/session/logout');
  }
}
