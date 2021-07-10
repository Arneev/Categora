import 'package:logger/logger.dart';

final Logger log = Logger(
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: false,
    errorMethodCount: 3,
    methodCount: 0,
    lineLength: 50,
  ),
);
