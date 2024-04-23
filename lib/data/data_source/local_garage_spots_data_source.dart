import 'package:park_manager/domain/model/spot.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ManageGarage { addVehicle, deleteVehicle }

class LocalGarageSpotsDataSource {
  final garageSpots = [
    Spot(null, null, spotId: '1', isOccupied: false),
    Spot(null, null, spotId: '2', isOccupied: false),
    Spot(null, null, spotId: '3', isOccupied: false),
    Spot(null, null, spotId: '4', isOccupied: false),
    Spot(null, null, spotId: '5', isOccupied: false),
    Spot(null, null, spotId: '6', isOccupied: false),
    Spot(null, null, spotId: '7', isOccupied: false),
    Spot(null, null, spotId: '8', isOccupied: false),
  ];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setGarageSpots(SharedPreferences prefs) async {
    final spotsList = garageSpots.map((spot) => spot.toJson()).toList();
    prefs.setStringList('spots', spotsList);
  }

  Future<List<Spot>> getGarageSpots() async {
    final SharedPreferences prefs = await _prefs;
    final cachedList = prefs.getStringList('spots');
    if (cachedList != null) {
      final spotsList = cachedList.map((e) => Spot.fromJson(e)).toList();
      return spotsList;
    }
    setGarageSpots(prefs);
    return garageSpots;
  }

  Future<List<Spot>> manageGarage(Spot spot, ManageGarage manageGarage) async {
    final SharedPreferences prefs = await _prefs;
    final cachedList = prefs.getStringList('spots');
    if (cachedList != null) {
      final spotsList = cachedList.map((e) => Spot.fromJson(e)).toList();
      final spotToUpdate =
          spotsList.where((element) => element.spotId == spot.spotId).first;
      spotToUpdate.carId =
          manageGarage == ManageGarage.addVehicle ? spot.carId : null;
      spotToUpdate.isOccupied =
          manageGarage == ManageGarage.addVehicle ? true : false;
      final updatedList = spotsList.map((spot) => spot.toJson()).toList();
      prefs.setStringList('spots', updatedList);

      return spotsList;
    }

    return garageSpots;
  }
}
