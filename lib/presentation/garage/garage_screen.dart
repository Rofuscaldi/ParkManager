import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/domain/model/spot.dart';
import 'package:park_manager/presentation/garage/bloc/garage_bloc.dart';
import 'package:park_manager/presentation/garage/spot_card_widget.dart';
import 'package:park_manager/utils/car_id_input_mask.dart';
import 'package:park_manager/utils/gm_colors.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/utils/keys.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key, required this.title});

  final String title;

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  late TextEditingController _spotIdTextFieldController;
  late TextEditingController _vehicleIdTextFieldController;

  late GarageBloc _bloc;

  @override
  void initState() {
    _bloc = sl.get<GarageBloc>();
    _bloc.add(GetSpotsEvent());

    _vehicleIdTextFieldController = TextEditingController();
    _spotIdTextFieldController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PMColor.lightBlue,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<GarageBloc, GarageState>(
            builder: (BuildContext context, GarageState state) {
          if (state is GetSpotsSuccess) {
            final list = state.spots;
            return ListView(
              key: Keys.listViewKey,
              children: _buildSpotsList(list),
            );
          } else if (state is GarageLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: PMColor.lightBlue,
            ));
          } else {
            return _buildErrorScreen();
          }
        }),
      ),
    );
  }

  List<Widget> _buildSpotsList(List<Spot> list) {
    return list
        .map((spot) => SpotCardWidget(
            spot, _vehicleIdTextFieldController, _spotIdTextFieldController))
        .toList();
  }

  Widget _buildErrorScreen() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
              height: 300,
              width: 300,
              child: Image(
                image: AssetImage('lib/utils/assets/error_logo.png'),
                fit: BoxFit.fitHeight,
              )),
          Text(
            'Ops!',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            'Houve um erro ao carregar o aplicativo. Tente novamente mais tarde!',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class AddVehicleBottomSheet extends StatelessWidget {
  const AddVehicleBottomSheet(this._spotIdTextFieldController,
      this._vehicleIdTextFieldController, this._selectedSpot,
      {super.key});

  final TextEditingController _spotIdTextFieldController;
  final TextEditingController _vehicleIdTextFieldController;

  final Spot _selectedSpot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Vaga',
                style: TextStyle(fontSize: 40),
              ),
              Text(
                _selectedSpot.spotId,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  maxLength: 8,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.streetAddress,
                  controller: _vehicleIdTextFieldController,
                  inputFormatters: [
                    CarIdInputMask(mask: 'xxx-xxxx', separator: '-'),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Placa do veículo',
                      counterText: '')),
              const SizedBox(
                height: 48,
              ),
              ValueListenableBuilder(
                valueListenable: _vehicleIdTextFieldController,
                builder: (BuildContext context, value, Widget? child) {
                  return ElevatedButton(
                      onPressed: value.text.isNotEmpty
                          ? () async {
                              final newVehicle = Spot(
                                  _vehicleIdTextFieldController.text, null,
                                  spotId: _selectedSpot.spotId,
                                  isOccupied: true);
                              Navigator.pop(context, newVehicle);
                              _spotIdTextFieldController.clear();
                              _vehicleIdTextFieldController.clear();
                            }
                          : null,
                      child: Text(
                        'Adicionar veículo',
                        style: TextStyle(
                            color: value.text.isNotEmpty
                                ? PMColor.lightBlue
                                : Colors.black12),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
