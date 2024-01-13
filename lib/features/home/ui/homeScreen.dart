import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/CustomWidgets/appButton.dart';

import 'package:omla_demo_app/features/CustomWidgets/homeTextField.dart';
import 'package:omla_demo_app/features/CustomWidgets/showPriceWidget.dart';
import 'package:omla_demo_app/features/home/bloc/home_bloc.dart';
import 'package:omla_demo_app/features/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController priceController = TextEditingController();

  final HomeBloc homeBloc = HomeBloc();

  double? btcUsdtPrice = 0;
  String initialUserInput = "";
  bool isPositive = false;
  bool isnegative = false;
  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    homeBloc.add(GenerateTokenAndComparePriceEvent());
  }

  conparePrice(double? marketPrice) {
    initialUserInput = priceController.text.toString();
    double inputDouble = double.parse(initialUserInput);
    if (marketPrice! > inputDouble) {
      setState(() {
        isPositive = true;
        isnegative = false;
      });
    } else if (marketPrice < inputDouble) {
      setState(() {
        isnegative = true;
        isPositive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is WebSocketPriceSucessState) {
          setState(() {
            btcUsdtPrice = state.price;
          });
        } else if (state is HomeErrorState) {
          Utils().errorMessage(state.errorMessage.toString(), context);
        }
      },
      builder: (context, state) {
        switch (btcUsdtPrice) {
          case 0.0:
            return const Scaffold(
              backgroundColor: Color.fromARGB(255, 77, 44, 207),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Getting the Data please hold on...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            );

          default:
            return Scaffold(
                backgroundColor: const Color.fromARGB(255, 77, 44, 207),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trade Highlight!",
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
                        'Compare your prices here!',
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
                            conparePrice(btcUsdtPrice);
                            showDialog(
                              context: context,
                              builder: (context) => PriceDailog(
                                price: btcUsdtPrice,
                                isPositive: isPositive,
                                isnegative: isnegative,
                              ),
                            );
                          },
                          width: 180,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const Text(
                            "For Price Chart click here",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_circle_right_rounded,
                                color: Colors.white,
                                size: 40,
                              ))
                        ],
                      ),
                    ],
                  ),
                ));
        }
      },
    );
  }
}
