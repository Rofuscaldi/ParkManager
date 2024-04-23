import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_manager/domain/model/spot.dart';
import 'package:park_manager/presentation/history/bloc/history_bloc.dart';
import 'package:park_manager/presentation/history/history_card_widget.dart';
import 'package:park_manager/utils/gm_colors.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/utils/keys.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.title});

  final String title;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryBloc _bloc;

  @override
  void initState() {
    _bloc = sl.get<HistoryBloc>();
    if (!_bloc.isClosed) {
      _bloc.add(GetHistoryEvent());
    }
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
        child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (BuildContext context, HistoryState state) {
          if (state is HistorySuccess) {
            final list = state.history;
            if (list.isNotEmpty) {
              return ListView(
                key: Keys.historyListKey,
                reverse: true,
                children: _buildHistoryList(list),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.garage,
                      size: 200,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Text(
                      'Não há nada no histórico no momento',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32, color: Colors.grey.withOpacity(0.3)),
                    )
                  ],
                ),
              );
            }
          } else if (state is HistoryError) {
            return _buildErrorScreen();
          }

          return const Center(
              child: CircularProgressIndicator(
            color: PMColor.lightBlue,
          ));
        }),
      ),
    );
  }

  List<Widget> _buildHistoryList(List<Spot> list) {
    return list.map((spot) => HistoryCardWidget(spot)).toList();
  }

  Widget _buildErrorScreen() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
              key: Keys.historyErrorWidgetKey,
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
