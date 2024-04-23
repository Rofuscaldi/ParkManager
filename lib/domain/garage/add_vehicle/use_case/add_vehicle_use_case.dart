import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class AddVehicleUseCase {
  AddVehicleUseCase(this._addVehicleRepository);

  final GarageRepository _addVehicleRepository;

  Future<List<Spot>> call(Spot spot) {
    return _addVehicleRepository.updateGarageSpots(spot);
  }
}
