import 'package:envied/envied.dart';

part 'development_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.dev.env',
)

/// Development environment variables.
/// Variables that should remain local and not leak, such as
/// base url or api key, are managed here.
abstract class DevEnv {
  @EnviedField(varName: 'BASE_URL')

  /// Base url of the api
  static String baseURL = _DevEnv.baseURL;
}
