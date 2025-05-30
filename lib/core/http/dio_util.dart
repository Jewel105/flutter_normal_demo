import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_normal_demo/core/env/env.dart';
import 'package:hb_common/utils/index.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

import 'base_entity.dart';
import 'dio_interceptors.dart';

// 请求方法
// request method
enum DioMethod { get, post, put, delete, patch, head }

/// 使用拓展枚举替代switch判断取值
/// get request method by index
extension MethodExtension on DioMethod {
  String get value =>
      <String>['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}

class DioUtil {
  // 连接超时时间
  // Connect timeout duration
  static const Duration _connectTime = Duration(seconds: 60);
  // 响应超时时间
  // Response timeout duration
  static const Duration _receiveTime = Duration(seconds: 60);
  // 请求url前缀
  // base url
  static final String _baseUrl = Env.envConfig.envHttpUrl;

  // 允许访问的证书sha256，避免中间人攻击
  // Allow access to the certificate sha256, avoiding man-in-the-middle attacks
  List<String> allowedSHAFingerprints = <String>[];

  // 单例模式
  // Singleton pattern
  static final DioUtil _instance = DioUtil._internal();
  factory DioUtil() => _instance;

  late Dio _dio;
  Dio get dio => _dio;

  DioUtil._internal() {
    _init();
  }

  _init() {
    // 初始化基本选项
    // Initialize base options
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTime,
      receiveTimeout: _receiveTime,
    );

    _dio = Dio(options);

    // release
    if (kReleaseMode && Env.envConfig.envType == EnvType.production) {
      //生产环境配置http2证书
      // Add http2 client adapter
      _dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(
            idleTimeout: _receiveTime,
            onClientCreate: (_, ClientSetting config) {
              config.onBadCertificate = (X509Certificate cert) {
                return true;
              };
            }),
      );
    } else {
      // 非生产环境使用http或https
      // Add http client adapter
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient();
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return true;
          };
          return client;
        },
      );
    }

    // 添加拦截
    // Add interceptors
    if (Env.envConfig.envType == EnvType.production) {
      // 生产环境校验证书，防止中间人攻击
      // Verify the certificate, preventing man-in-the-middle attacks
      _dio.interceptors.add(CertificatePinningInterceptor(
        allowedSHAFingerprints: allowedSHAFingerprints,
        callFollowingErrorInterceptor: true,
      ));
    }
    _dio.interceptors.add(DioInterceptors());
  }

  /// 取消请求token
  /// cancel request token
  final CancelToken _cancelToken = CancelToken();

  // 取消请求方法
  /// cancel request
  void cancelRequests() {
    _cancelToken.cancel('cancel');
  }

  // 发送请求方法
  // send request
  Future<T> request<T>(String path,
      {DioMethod method = DioMethod.get,
      Map<String, dynamic>? params,
      Object? data,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool loading = false}) async {
    options ??= Options();
    options.method = method.value;

    if (loading) {
      HbDialog.showLoading();
    }

    try {
      // 调用dio的请求方法
      // dio request
      Response<Map<String, dynamic>?> response =
          await _dio.request<Map<String, dynamic>?>(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return BaseEntity<dynamic>.fromJson(response.data ?? {}).data;
    } on DioException catch (_) {
      rethrow;
    } finally {
      if (loading) {
        HbDialog.closeAllLoading();
      }
    }
  }

  // get
  Future<T?> get<T>({
    required String url,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool loading = false,
  }) =>
      request<T>(
        url,
        method: DioMethod.get,
        params: params,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        loading: loading,
      );

  // POST
  Future<T?> post<T>({
    required String url,
    Object? data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool loading = false,
  }) =>
      request<T>(
        url,
        method: DioMethod.post,
        data: data,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        loading: loading,
      );
}
