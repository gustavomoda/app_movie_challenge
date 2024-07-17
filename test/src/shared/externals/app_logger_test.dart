import 'package:app_movie_challenge/src/shared/externals/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart' as extern_logger;

class _Output extends extern_logger.ConsoleOutput {
  final outputs = [];

  @override
  void output(extern_logger.OutputEvent event) {
    outputs.add(event.lines);
  }

  void reset() {
    outputs.clear();
  }
}

void main() {
  group('AppLogger:', () {
    test('should log flutter errors correctly', () {
      final output = _Output();
      final logger = AppLogger(
        level: extern_logger.Level.debug,
        output: output,
      );

      final flutterErrorDetails = FlutterErrorDetails(
        exception: Exception('Test Flutter error'),
        stack: StackTrace.current,
      );

      logger.flutterError(flutterErrorDetails);

      expect(output.outputs, isNotEmpty);
      expect(output.outputs.first.join('\n'), contains('Test Flutter error'));
    });

    test('should log platform errors correctly', () {
      final output = _Output();
      final logger = AppLogger(
        level: extern_logger.Level.debug,
        output: output,
      );

      final exception = Exception('Test Platform error');
      final stackTrace = StackTrace.current;

      logger.platformError(exception, stackTrace);

      expect(output.outputs, isNotEmpty);
      expect(output.outputs.first.join('\n'), contains('Test Platform error'));
    });

    test('should return true on platform error', () {
      final output = _Output();
      final logger = AppLogger(
        level: extern_logger.Level.debug,
        output: output,
      );

      final exception = Exception('Test Platform error');
      final stackTrace = StackTrace.current;

      final result = logger.platformError(exception, stackTrace);

      expect(result, isTrue);
    });
  });
}
