import 'package:flutter/material.dart';
import 'package:park_manager/domain/model/spot.dart';
import 'package:park_manager/presentation/garage/bloc/garage_bloc.dart';
import 'package:park_manager/presentation/garage/garage_screen.dart';
import 'package:park_manager/utils/gm_colors.dart';

import '../../core/service_locator.dart';

class SpotCardWidget extends StatelessWidget {
  const SpotCardWidget(this.spot, this._vehicleIdTextFieldController,
      this._spotIdTextFieldController,
      {super.key});

  final TextEditingController _spotIdTextFieldController;
  final TextEditingController _vehicleIdTextFieldController;

  final Spot spot;

  Future<void> enableSpot(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Liberar vaga?',
            textAlign: TextAlign.center,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Se prosseguir, a vaga será liberada para novos veículos.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                spot.isOccupied = false;
                sl.get<GarageBloc>().add(DeleteVehicleEvent(vehicle: spot));
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void manageGarage(BuildContext context) async {
    if (!spot.isOccupied) {
      final newVehicle = await showModalBottomSheet<Spot>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return AddVehicleBottomSheet(
              _spotIdTextFieldController, _vehicleIdTextFieldController, spot);
        },
      );
      sl.get<GarageBloc>().add(AddVehicleEvent(newVehicle: newVehicle!));
    } else {
      enableSpot(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => manageGarage(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: spot.isOccupied ? PMColor.lightOrange : PMColor.lightGreen,
              borderRadius: BorderRadius.circular(16)),
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
                    Text(
                      spot.isOccupied ? spot.carId! : 'Livre',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
