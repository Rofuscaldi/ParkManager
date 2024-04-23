import 'dart:convert';

class Spot {
  Spot(this.carId, this.actionDateTime, {required this.spotId, required this.isOccupied});

  String spotId;
  String? carId;
  String? actionDateTime;
  bool isOccupied;

  Map<String, dynamic> toMap() {
    return {
      'spotId': spotId,
      'actionDateTime': actionDateTime,
      'carId': carId,
      'isOccupied': isOccupied
    };
  }

  factory Spot.fromMap(Map<String, dynamic> map) {
    return Spot(
        map['carId'],
        map['actionDateTime'],
        spotId: map['spotId'],
        isOccupied: map['isOccupied']
    );
  }

  String toJson() => json.encode(toMap());

  factory Spot.fromJson(String source) => Spot.fromMap(json.decode(source));
}
