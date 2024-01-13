import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/CustomWidgets/appButton.dart';
import 'package:omla_demo_app/features/CustomWidgets/appTextFeild.dart';
import 'package:omla_demo_app/features/CustomWidgets/compareButton.dart';
import 'package:omla_demo_app/features/CustomWidgets/homeTextField.dart';
import 'package:omla_demo_app/features/CustomWidgets/showPriceWidget.dart';
import 'package:omla_demo_app/features/home/bloc/home_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController priceController = TextEditingController();

  final HomeBloc homeBloc = HomeBloc();

  double? btcUsdtPrice = 0;
  String initialUserInput = "";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(GenerateTokenAndComparePriceEvent());
    // initialUserInput = priceController.text.toString();
    // double inputDouble = double.parse(initialUserInput);



  }

  conparePrice(double? marketPrice){
    initialUserInput = priceController.text.toString();
    double inputDouble = double.parse(initialUserInput);
    if(marketPrice!>inputDouble){
      print('market price is higer');
    } else if(marketPrice<inputDouble){
      print('market price is lower');
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is WebSocketPriceSucessState) {
          print(" this is the price from ui${state.price}");
          setState(() {
            btcUsdtPrice = state.price;
          });
        }
      },
      builder: (context, state) {
        switch (btcUsdtPrice) {
          case 0.0:
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 77, 44, 207),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                      
                    ),
                    SizedBox(height: 50,),
                    Text('Getting the Data please hold on...',style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
            );
          
          default:
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 77, 44, 207),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hi There!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40),
                      ),
                      Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                        size: 40,
                      )
                    ],
                  ),
                  const Text(
                    'compare your prices here!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: HomeTextField(
                      controller: priceController,
                      hintText: 'Enter your price here',
                      filledCollor: Colors.white,
                      hintColor: Colors.grey,
                      textColor: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      text: 'Compare',
                      onTap: () async {
                        //print('first click from ui');
                        print('comparing price');
                        conparePrice(btcUsdtPrice);
                        print(btcUsdtPrice);
                        // homeBloc.add(GenerateTokenAndComparePriceEvent());
                      },
                      width: 180,
                      height: 50,
                    ),
                  ),
                  //Text(btcUsdtPrice)
                  // Container(
                  //   height: 180,
                  //   width: 250,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(16),
                  //     color: Colors.white
                  //   ),
                  // )
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PriceDailog(),
                        );
                      },
                      child: Text('pree'))


                  
                ],
              ),
            ));
        }
      },
    );
  }
}





// class WebsocketDemo extends StatefulWidget {
//   const WebsocketDemo({Key? key}) : super(key: key);

//   @override
//   State<WebsocketDemo> createState() => _WebsocketDemoState();
// }

// class _WebsocketDemoState extends State<WebsocketDemo> {
//   String btcUsdtPrice = "0";
  
//   @override
//   void initState() {
//     super.initState();
//     streamListener();
//   }

//   streamListener() async{
//     final wsUrl = Uri.parse(
//               "wss://futures-apiws.poloniex.com/endpoint?token=DcXijCbKcWFew_i0BS8y6UNmBtlHW3UAvR4Nx4VADIn15tt-jDqMbYWNZ2II5fSnrClCBBv6dTDc8PMFHz-H6vzY_5GdW8SI2rDi7nMjGYIacWDRQCm5JGMGfZAja_q_-wgHjBcT7RhvJVwiLf8PgeW86xA2-Bfl7gi2RE3si5Y=.F4X18_MNXoO4P0PovdCntw==");
//           final channel = WebSocketChannel.connect(wsUrl);
//           await channel.ready;
//           channel.sink.add(
//             jsonEncode({
//               "id": 1545910660740,
//               "type": "subscribe",
//               "topic": "/contractMarket/ticker:BTCUSDTPERP",
//               "response": true
//             }),
//           );

//           /// Listen for all incoming data
          
//           channel.stream.listen(
//             (data) {
//               // // Map data = responseJson['data'];
//               // // Map price = data['price'];
//               // print(data);
//               Map message = jsonDecode(data);

//               if (message.containsKey('data')) {
//                 Map data = message['data'];

//                 double price = data['price'];
//                 print(price);
//                 setState(() {
//                   btcUsdtPrice = price.toString();
//                 });
//                 // on((event, emit) => emit(WebSocketPriceSucessState(price: price))
//                 // );

//                 //emit(WebSocketPriceSucessState(price: price));
//                 // on((event, emit) {
//                 //   channel.stream.listen((data) { 
//                 //     Map message = jsonDecode(data);
//                 //     Map datatwo = message['data'];
//                 //     double price = datatwo['price'];
//                 //     emit(WebSocketPriceSucessState(price: price));

//                 //   });
//                 // }
//                 // );

                
                  
                
                
                
//                 // priceone = price;

//                 // print(price);
//                 // print(price.runtimeType);
//               }
//             },
//             onError: (error) => print(error),
//           );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "BTC/USDT Price",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 30),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 btcUsdtPrice,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 250, 194, 25),
//                     fontSize: 30),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }