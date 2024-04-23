import 'package:get_it/get_it.dart';
import 'package:park_manager/domain/garage/get_spots/di/get_spots_di.dart' as get_spots;
import 'package:park_manager/domain/garage/add_vehicle/di/add_vehicle_di.dart' as add_vehicle;
import 'package:park_manager/domain/garage/delete_vehicle/di/delete_vehicle_di.dart' as delete_vehicle;
import 'package:park_manager/domain/history/di/history_di.dart' as history;

void setup(GetIt sl) {
  add_vehicle.setup(sl);
  delete_vehicle.setup(sl);
  get_spots.setup(sl);
  history.setup(sl);
}
