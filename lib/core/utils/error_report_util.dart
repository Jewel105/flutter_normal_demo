import 'dart:async';

import 'package:flutter/foundation.dart';

class ErrorReportUtil {
  late final Zone errorHandlingZone;

  ErrorReportUtil() {
    _initializeAsyncErrorZone();
    _initializeSyncErrorHandling();
  }

  /// Sets up a custom Zone to intercept uncaught asynchronous errors.
  /// 配置自定义 Zone 用于拦截未捕获的异步错误
  void _initializeAsyncErrorZone() {
    ZoneSpecification zoneSpecification = ZoneSpecification(
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        // TODO: Ignore network-related exceptions
        // 忽略网络相关异常
        // if (error is DioException || error is DioH2NotSupportedException) return;
        _reportError(error.toString(), stackTrace.toString());
      },
    );
    // Fork a new Zone for error handling
    // 创建一个新的 Zone 来处理错误
    errorHandlingZone = Zone.current.fork(specification: zoneSpecification);
  }

  /// Overrides Flutter's default synchronous error handling mechanism.
  /// 重写 Flutter 的默认同步错误处理机制
  void _initializeSyncErrorHandling() {
    FlutterExceptionHandler? originalHandler = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      originalHandler?.call(errorDetails);
      debugPrint(errorDetails.exception.toString());
      debugPrint(errorDetails.stack.toString());
      _reportError(
        errorDetails.exception.toString(),
        errorDetails.stack.toString(),
      );
    };
  }

  /// Reports the given error and stack trace. Only reports in release mode.
  /// 上报错误信息和堆栈，仅在 Release 模式下执行
  Future<void> _reportError(String error, String stack) async {
    if (!kReleaseMode) return;
    // TODO: Add logic to report errors to your error tracking service
  }
}
