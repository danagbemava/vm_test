import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
    errorMethodCount: 5,
  ),
);

mixin LoggerMixin<T> {
  logInfo(String methodName, Object message) {
    _logger.i('$T, $methodName, $message');
  }

  logDebug(String methodName, Object message) {
    _logger.d('$T, $methodName, $message');
  }

  logError(String methodName, Object message) {
    _logger.e('$T, $methodName, $message');
  }
}
