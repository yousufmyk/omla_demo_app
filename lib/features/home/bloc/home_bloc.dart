import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GenerateTokenAndComparePriceEvent>(generateTokenAndComparePriceEvent);
  }

  FutureOr<void> generateTokenAndComparePriceEvent(
      GenerateTokenAndComparePriceEvent event, Emitter<HomeState> emit) async {
    print('first click from bloc');
    //String token;
    //var priceone;
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

          /// Listen for all incoming data
          /// 
          /// 
          /// 
          /// 
          /// 
          /// 
          await channel.stream
      .map((data) => jsonDecode(data))
      .where((message) => message.containsKey('data'))
      .map((message) => message['data'])
      .map((data) => data['price'])
      .map((price) => WebSocketPriceSucessState(price: price))
      .forEach(emit).whenComplete(() => (){
        print('stream closed');
        channel.sink.close();
      });




          







          // channel.stream.listen(
          //   (data) {
          //     // // Map data = responseJson['data'];
          //     // // Map price = data['price'];
          //     // print(data);
          //     Map message = jsonDecode(data);

          //     if (message.containsKey('data')) {
          //       Map data = message['data'];

          //       double price = data['price'];
          //       //print(price);
          //       emit(WebSocketPriceSucessState(price: price));
          //       // on((event, emit) => emit(WebSocketPriceSucessState(price: price))
          //       // );

          //       //emit(WebSocketPriceSucessState(price: price));
          //       // on((event, emit) {
          //       //   channel.stream.listen((data) { 
          //       //     Map message = jsonDecode(data);
          //       //     Map datatwo = message['data'];
          //       //     double price = datatwo['price'];
          //       //     emit(WebSocketPriceSucessState(price: price));

          //       //   });
          //       // }
          //       // );

                
                  
                
                
                
          //       // priceone = price;

          //       // print(price);
          //       // print(price.runtimeType);
          //     }
          //   },
          //   onError: (error) => print(error),
          // );
          
        } 
        catch (e) {
          print(e);
        }

        //print(token);
        // Request succeeded, process the response
      } else {
        print('error');
        // Request failed, handle error
      }
      //emit(WebSocketPriceSucessState(price: priceone));
    } catch (e) {
      print('this is e${e.toString()}');
    }
    
  }
}







