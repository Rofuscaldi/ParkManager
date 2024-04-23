import 'package:get_it/get_it.dart';
import 'package:park_manager/presentation/di/presentation_di.dart' as presentation;
import 'package:park_manager/domain/di/domain_di.dart' as domain;
import 'package:park_manager/data/di/data_di.dart' as data;

GetIt sl = GetIt.instance;

void setup(GetIt sl) {
  presentation.setup(sl);
  domain.setup(sl);
  data.setup(sl);
}