import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PriceDailog extends StatelessWidget {
  PriceDailog({
    super.key,
    required this.price,
    required this.isPositive,
    required this.isnegative,
  });
  double? price;
  bool isPositive;
  bool isnegative;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Market Price '),
      content: Container(
        height: 210,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                price.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Visibility(
                  visible: isPositive,
                  child: const Icon(
                    Icons.arrow_circle_up_rounded,
                    color: Colors.greenAccent,
                    size: 60,
                  )),
              Visibility(
                  visible: isnegative,
                  child: const Icon(
                    Icons.arrow_circle_down_rounded,
                    color: Colors.redAccent,
                    size: 60,
                  ))
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
