import 'package:flutter/material.dart';
import 'package:park_manager/domain/model/spot.dart';
import 'package:park_manager/utils/date_format.dart';
import 'package:park_manager/utils/gm_colors.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget(this.spot, {super.key});

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: PMColor.grey, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Vaga',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        spot.spotId,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            spot.isOccupied ? 'Entrada' : 'Saída',
                            style: TextStyle(
                                color: spot.isOccupied
                                    ? PMColor.deepOrange
                                    : PMColor.deepGreen),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            spot.isOccupied
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: spot.isOccupied
                                ? PMColor.deepOrange
                                : PMColor.deepGreen,
                          )
                        ],
                      ),
                      Text(
                        DateFormat()
                            .simplyFormat(time: DateTime.now(), dateOnly: true),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    spot.carId!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
