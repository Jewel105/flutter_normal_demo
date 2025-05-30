import 'env.dev.dart';
import 'env.pro.dart';

class Env {
  // 当前环境配置
  /// App enviorment config
  static EnvConfig get envConfig => _getEnvConfig();

  // Command: flutter run --dart-define=APP_ENV=dev
  // Get app enviorment, default:dev 当前环境
  static const String _appEnv =
      String.fromEnvironment('APP_ENV', defaultValue: 'uat');

  static EnvConfig _getEnvConfig() {
    switch (_appEnv) {
      case 'pro':
        return kProConfig;
      default:
        return kDevConfig;
    }
  }
}

class EnvConfig {
  final EnvType envType;
  final String envHttpUrl;
  final String envWsUrl;
  final String tronUrl;

  const EnvConfig({
    required this.envType,
    required this.envHttpUrl,
    required this.envWsUrl,
    required this.tronUrl,
  });
}

enum EnvType { development, production }
