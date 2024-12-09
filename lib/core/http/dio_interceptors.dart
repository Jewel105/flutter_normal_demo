import 'package:dio/dio.dart';

import '../app/app_constant.dart';
import '../utils/index.dart';
import 'base_entity.dart';

class DioInterceptors extends Interceptor {
  // Intercept request and add token to headers
  // 请求拦截
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add token to headers
    // 添加token头
    String? token = StorageUtil.get(TOKEN) as String?;
    if (token != null) {
      options.headers['Token'] = token;
    }
    // Continue sending request
    // 继续发送请求
    handler.next(options);
  }

  // Intercept response and handle error
  // 响应拦截
  @override
  void onResponse(
    Response<Object?> response,
    ResponseInterceptorHandler handler,
  ) async {
    // TODO: BaseEntity needs to be implemented
    // 需要根据后端返回，修改BaseEntity的字段
    BaseEntity<Object?> data =
        BaseEntity<Object?>.fromJson(response.data as Map<String, dynamic>);

    // If response is not successful, reject the request
    if (!data.success) {
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        message: data.msg ?? data.code,
      ));
      return;
    }
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // TODO: showDialog needs to be implemented
    // showDialog(content: err.toString());
    handler.next(err);
  }
}
