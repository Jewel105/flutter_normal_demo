import 'package:dio/dio.dart';
import 'package:hb_common/utils/hb_storage.dart';

import '../app/app_constant.dart';
import 'base_entity.dart';

class DioInterceptors extends Interceptor {
  // Intercept request and add token to headers
  // 请求拦截
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Add token to headers
    // 添加token头
    String? token = HbStorage.get(AppConstant.TOKEN) as String?;
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
  ) {
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
      // TODO: showDialog needs to be implemented
      // showDialog(content: err.toString());
      return;
    }
    handler.next(response);
  }

  // network error interceptor
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // 如果使用了代理，提示关闭代理
    // If use proxy, show tip to close proxy
    if (err.toString().contains('Certificate')) {
      // showDialog(content:"please close the proxy and try again!");
    }
    handler.next(err);
  }
}
