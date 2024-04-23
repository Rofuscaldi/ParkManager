import 'package:park_manager/domain/contract/garage_repository.dart';
import 'package:park_manager/domain/model/spot.dart';

class GetSpotsUseCase {
  GetSpotsUseCase(this._getSpotRepository);

  final GarageRepository _getSpotRepository;

  Future<List<Spot>> call() {
    return _getSpotRepository.getSpots();
  }
}
