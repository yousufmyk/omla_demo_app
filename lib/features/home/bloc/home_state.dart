part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState{}
final class WebSocketPriceSucessState extends HomeActionState{
  final double? price;

  WebSocketPriceSucessState({required this.price});
}
final class HomeErrorState extends HomeActionState{
  final String? errorMessage;

  HomeErrorState({required this.errorMessage});
}
