import 'dart:io';

import 'package:api_tempest/utils/logger/log_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

Logger getLogger(String className) => Logger(printer: SimpleLogPrinter(className: className), filter: LoggerFilter());

class Log {
  final DateTime dateTime;
  final String message;
  final String className;
  final Level level;

  Log({
    required this.dateTime,
    required this.message,
    required this.className,
    required this.level,
  });

  @override
  String toString() {
    return '${DateFormat('dd-MM-yyy kk:mm:ss').format(dateTime)} ~ $className ~ ${level.name} ~ $message';
  }
}

class SimpleLogPrinter extends LogPrinter {
  final String className;
  static final List<Log> logHistory = [];

  SimpleLogPrinter({required this.className});

  static Future<String> getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filename = "logs_${DateTime.now().toIso8601String()}.csv";
    final filePath = File("${directory.path}/$filename");
    await filePath.writeAsString(logHistory.reversed.join('\n'));

    return filePath.path;
  }

  void _addLog(Log log) {
    if (logHistory.length > 100000) {
      logHistory.removeAt(0);
    }
    logHistory.add(log);
  }

  @override
  List<String> log(LogEvent event) {
    AnsiColor color = PrettyPrinter.levelColors[event.level]!;
    String emoji = PrettyPrinter.levelEmojis[event.level] ?? '';
    _addLog(Log(
      className: className,
      dateTime: DateTime.now(),
      message: event.message,
      level: event.level,
    ));
    if (kDebugMode) {
      print(color("$emoji $className - ${event.message}"));
    }

    if (event.error != null) {
      _addLog(Log(
        className: className,
        dateTime: DateTime.now(),
        message: "${event.error}",
        level: event.level,
      ));
      if (kDebugMode) {
        print(color("$emoji $className - ${event.error}"));
      }
    }

    if (event.stackTrace != null) {
      _addLog(Log(
        className: className,
        dateTime: DateTime.now(),
        message: "${event.stackTrace}",
        level: event.level,
      ));
      if (kDebugMode) {
        print("${event.stackTrace}");
      }
    }
    return [];
  }
}
