part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

final class GetHistoryEvent extends HistoryEvent {}