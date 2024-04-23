import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:park_manager/domain/model/spot.dart';

import '../../../domain/history/use_case/get_history_use_case.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {

  final GetHistoryUseCase _getHistoryUseCase;

  HistoryBloc(this._getHistoryUseCase) : super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) async {
      if (event is GetHistoryEvent) {
        final history = await _getHistoryUseCase.call();
        if(history.isNotEmpty) {
          emit(HistorySuccess(history: history));
        } else {
          emit(HistoryError());
        }
      }
    });
  }
}
