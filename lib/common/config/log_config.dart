import 'package:indoxx1/common/util/log.dart';
import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name} : ${record.time} : ${record.message}');
  });
  Log.init(Logger.root);
}