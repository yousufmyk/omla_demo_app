import 'package:flutter/material.dart';

class PriceDailog extends StatelessWidget {
  const PriceDailog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            //title: Text('My '),
            content: Container(
               height: 210,
               width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Price here',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.black),),
                    Icon(Icons.arrow_circle_up_rounded,color: Colors.green,size: 60,)
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
  }
}