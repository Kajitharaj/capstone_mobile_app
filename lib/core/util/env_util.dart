import 'package:capstone_mobile_app/core/shared/model/env_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvUtil {
  static Environment? _environment;

  static init() async {
    String env = const String.fromEnvironment('ENV', defaultValue: 'dev');
    await dotenv.load(fileName: ".env.$env");
    setEnvVariables();
  }

  static setEnvVariables() {
    _environment = Environment(apiUrl: dotenv.env['API_URL'] ?? '');
  }

  static Environment? get env => _environment;
}
