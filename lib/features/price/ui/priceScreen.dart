import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/home/bloc/home_bloc.dart';
import 'package:omla_demo_app/features/home/ui/homeScreen.dart';
import 'package:omla_demo_app/features/price/bloc/price_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({
    super.key,
    /*required this.tickerData*/
  });
  //final dynamic tickerData;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final HomeBloc homeBloc = HomeBloc();
  double? btcUsdtPrice = 0;
  dynamic datafromWs;

  /////**********This is the dumy Data because Ws is not giving correct time */

  final List<Data> chartData = [
    Data("12:10", 40000),
    Data("13:20", 60000),
    Data("14:25", 50000),
    Data("15:30", 90000),
  ];

//   covertTime() {
//     DateTime timefromData = DateTime(datafromWs['ts']);

//     String newtime = timefromData.toString();
//     //ar millis = 978296400000;
//     getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
//     // dateFormat = 'MM/dd/yy';
//     final DateTime docDateTime = DateTime.parse(givenDateTime);
//     return DateFormat(dateFormat).format(docDateTime);
// }

//     // double pricefromData = datafromWs['price'];

//     // chartData.add(Data(newtime, pricefromData));
//   }

  @override
  void initState() {
    super.initState();
    homeBloc.add(GenerateTokenAndComparePriceEvent());
    //dothething();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is WebSocketPriceSucessState) {
          var initialData = state.data['price'];
          setState(() {
            datafromWs = state.data;
            btcUsdtPrice = initialData;
          });
        }

        //  else if (state is WebSocketDataSucessState){
        //   print(state.data['symbol']);
        // }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 300,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData.map((data) {
                    return FlSpot(data.getTimeAsDouble(), data.price);
                  }).toList(),
                  isCurved: true,
                  // colors: [Colors.blue],

                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Data {
  final String time;
  final double price;

  Data(this.time, this.price);

  double getTimeAsDouble() {
    final parts = time.split(":");
    final hours = double.parse(parts[0]);
    final minutes = double.parse(parts[1]) / 60.0;
    return hours + minutes;
  }
}
