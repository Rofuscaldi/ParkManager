import 'package:get_it/get_it.dart';
import 'package:park_manager/presentation/garage/di/garage_di.dart' as garage;
import 'package:park_manager/presentation/history/di/history_di.dart' as history;

void setup(GetIt sl) {
  garage.setup(sl);
  history.setup(sl);
}