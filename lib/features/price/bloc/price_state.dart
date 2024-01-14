part of 'price_bloc.dart';

@immutable
abstract class PriceState {}

abstract class PriceActionState extends PriceState {}

final class PriceInitial extends PriceState {}

final class PriceScreenBackState extends PriceActionState {}

final class PriceErrorState extends PriceActionState {
  final String? errorMessage;

  PriceErrorState({required this.errorMessage});
}

final class WebSocketDataSucessState extends PriceActionState {
  final dynamic data;

  WebSocketDataSucessState({required this.data});
}
