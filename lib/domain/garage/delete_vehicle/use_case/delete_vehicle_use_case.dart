import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class DeleteVehicleUseCase {
  DeleteVehicleUseCase(this._garageRepository);

  final GarageRepository _garageRepository;

  Future<List<Spot>> call(Spot spot) {
    return _garageRepository.deleteVehicle(spot);
  }
}
