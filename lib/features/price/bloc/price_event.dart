part of 'price_bloc.dart';

@immutable
abstract class PriceEvent {}

class PriceScreenBackEvent extends PriceEvent {}

class GenerateTokenAndGetPriceEvent extends PriceEvent {}
