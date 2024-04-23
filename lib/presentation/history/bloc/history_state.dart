part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistorySuccess extends HistoryState {
  HistorySuccess({required this.history});

  final List<Spot> history;
}

final class HistoryError extends HistoryState {}
