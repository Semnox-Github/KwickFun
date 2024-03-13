library semnox_logger;

enum Level { debug, info, warning, error, fatal }

class SemnoxLogger {
  String _className = "";
  SemnoxLogger(String className) {
    _className = className;
  }

  /// Log a message at level [Level.debug].
  void debug(dynamic source, dynamic message) {
    log(Level.debug, source, message, null);
  }

  /// Log a message at level [Level.info].
  void info(dynamic source, dynamic message) {
    log(Level.debug, source, message, null);
  }

  /// Log a message at level [Level.warning].
  void warning(dynamic source, dynamic message) {
    log(Level.warning, source, message, null);
  }

  /// Log a message at level [Level.error].
  void error(dynamic source, dynamic message, Exception exception) {
    log(Level.error, source, message, exception);
  }

  /// Log a message at level [Level.fatal].
  void fatal(dynamic source, dynamic message) {
    log(Level.fatal, source, message, null);
  }

  /// Log a message with [level].
  void log(Level level, String source, dynamic message, Exception? error) {
    var logEvent = LogEvent(level, source, message, error);
  }
}

class LogEvent {
  final String source;
  final Level level;
  final dynamic message;
  final Exception? error;

  LogEvent(this.level, this.source, this.message, this.error);
}
