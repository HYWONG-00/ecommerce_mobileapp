import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
      // methodCount: 2, // Number of method calls to be displayed
      // errorMethodCount: 8, // Number of method calls if stacktrace is provided
      // lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
);

// logger.t("Trace log"); //blue

void appDebugLog(dynamic msg) {
  logger.d(msg);
}

void appInfoLog(dynamic msg) {
  logger.i(msg);
}

void appWarningLog(dynamic msg) {
  logger.i(msg);
}

void appErrorLog(dynamic msg) {
  logger.e(msg);
}

void appFatalErrorLog(dynamic msg) {
  logger.f(msg);
}
