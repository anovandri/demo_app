import 'package:logging/logging.dart';

class Log {
  static Log _instance;
  final Logger logger;

  Log.init(this.logger) {
    _instance = this;
  }

  static Log get instance {
    if (_instance == null) {
      _instance = Log.init(Logger.root);
    }
    return _instance;
  }

  /// Send a VERBOSE log message and log the exception.
  static void v(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.info(message, error, stackTrace);
  }

  /// Send a INFO log message and log the exception.
  static void d(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.fine(message, error, stackTrace);
  }

  /// Send a INFO log message and log the exception.
  static void i(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.info(message, error, stackTrace);
  }

  /// Send a WARN log message and log the exception.
  static void w(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.warning(message, error, stackTrace);
  }

  /// Send a ERROR log message and log the exception.
  static void e(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.severe(message, error, stackTrace);
  }

  /// What a Terrible Failure: Report an exception that should never happen.
  static void wtf(message, [Object error, StackTrace stackTrace]) {
    Log._instance?.logger?.severe(message, error, stackTrace);
  }
}