import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GenerateTokenAndComparePriceEvent>(generateTokenAndComparePriceEvent);
    on<NavigateToPriceScreen>(navigateToPriceScreen);
  }

  FutureOr<void> generateTokenAndComparePriceEvent(
      GenerateTokenAndComparePriceEvent event, Emitter<HomeState> emit) async {
    try {
      const url = "https://futures-api.poloniex.com/api/v1/bullet-public";
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        Map<String, dynamic> data = responseJson['data'];
        String token = data['token'];

        try {
          final wsUrl = Uri.parse(
              "wss://futures-apiws.poloniex.com/endpoint?token=$token");
          final channel = WebSocketChannel.connect(wsUrl);
          await channel.ready;
          channel.sink.add(
            jsonEncode({
              "id": 1545910660740,
              "type": "subscribe",
              "topic": "/contractMarket/ticker:BTCUSDTPERP",
              "response": true
            }),
          );

          await channel.stream
              .map((data) => jsonDecode(data))
              .where((message) => message.containsKey('data'))
              .map((message) => message['data'])
              // .map((data) => data['price'])
              .map((data) => WebSocketPriceSucessState(data: data))
              .forEach(emit)
              .whenComplete(() => () {
                    channel.sink.close();
                  });
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> navigateToPriceScreen(
      NavigateToPriceScreen event, Emitter<HomeState> emit) {
    emit(NavigateToPriceScreenState());
  }
}
