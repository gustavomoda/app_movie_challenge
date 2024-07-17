import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as extern_logger;

export 'package:logger/logger.dart' show Level;

class AppLogger extends extern_logger.Logger {
  AppLogger({required extern_logger.Level level, super.output}) : super(level: level);

  void flutterError(FlutterErrorDetails flutterErrorDetails) {
    log(
      extern_logger.Level.error,
      flutterErrorDetails.exceptionAsString(),
      error: flutterErrorDetails.exception,
      stackTrace: flutterErrorDetails.stack,
    );
  }

  bool platformError(Object exception, StackTrace stackTrace) {
    log(
      extern_logger.Level.error,
      exception.toString(),
      error: exception,
      stackTrace: stackTrace,
    );
    return true;
  }
}
