import 'package:park_manager/domain/model/spot.dart';

abstract class GarageRepository {
    Future<List<Spot>> updateGarageSpots(Spot spot);

    Future<List<Spot>> deleteVehicle(Spot spot);

    Future<List<Spot>> getSpots();
}