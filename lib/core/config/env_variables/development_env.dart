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
  /// Base url of the api
  @EnviedField(varName: 'BASE_URL')
  static String baseURL = _DevEnv.baseURL;

  @EnviedField(varName: 'BASE_URL_QURAN')
  static String baseURLQuran = _DevEnv.baseURLQuran;
}
