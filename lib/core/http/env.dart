class EnvConfig {
  final String envName;
  final String envHttpUrl;

  EnvConfig({
    required this.envName,
    required this.envHttpUrl,
  });
}

enum EnvType { development, production }

class Env {
  // 当前环境配置
  /// App enviorment config
  static EnvConfig get envConfig => _getEnvConfig();

  // Command: flutter run --dart-define=APP_ENV=dev
  // Get app enviorment, default:dev 当前环境
  static const String _appEnv =
      String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  static EnvType get appEnv {
    switch (_appEnv) {
      case 'dev':
        return EnvType.development;
      case 'pro':
        return EnvType.production;
      default:
        return EnvType.development;
    }
  }

  static EnvConfig _getEnvConfig() {
    switch (_appEnv) {
      case 'pro':
        return _proConfig;
      default:
        return _devConfig;
    }
  }

  // Dev config
  static final EnvConfig _devConfig = EnvConfig(
    envName: 'development',
    envHttpUrl: 'https://127.0.0.1:8081/api/v1',
  );

  // Production config
  static final EnvConfig _proConfig = EnvConfig(
    envName: 'production',
    envHttpUrl: 'https://8.137.51.56:8081/api/v1',
  );
}
