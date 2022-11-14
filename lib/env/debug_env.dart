import 'package:envied/envied.dart';

part 'debug_env.g.dart';

@Envied(path: '.env')
abstract class DebugEnv {
  @EnviedField(varName: 'apiKey')
  static const API_KEY = _DebugEnv.API_KEY;
  @EnviedField(varName: 'apiId')
  static const API_ID = _DebugEnv.API_ID;
  @EnviedField(varName: 'apiUrl')
  static const API_URL = _DebugEnv.API_URL;
}
