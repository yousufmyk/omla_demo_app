import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';

part 'price_event.dart';
part 'price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc() : super(PriceInitial()) {
    on<PriceScreenBackEvent>(priceScreenBackEvent);
    on<GenerateTokenAndGetPriceEvent>(generateTokenAndGetPriceEvent);
  }

  FutureOr<void> priceScreenBackEvent(
      PriceScreenBackEvent event, Emitter<PriceState> emit) {
    emit(PriceScreenBackState());
  }

  FutureOr<void> generateTokenAndGetPriceEvent(
      GenerateTokenAndGetPriceEvent event, Emitter<PriceState> emit) async {}
}
