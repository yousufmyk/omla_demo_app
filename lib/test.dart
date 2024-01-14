// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';



// class Chart extends StatelessWidget {
//   final List<Data> chartData = [
//     Data("12:50", 4560),
//     Data("14:30", 4550),
//     Data("16:15", 4340),
//     Data("18:45", 430),
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//       padding: const EdgeInsets.all(10),
//       width: double.infinity,
//       height: 300,
//       child: LineChart(
//         LineChartData(
          
//           borderData: FlBorderData(show: false),
//           lineBarsData: [
//             LineChartBarData(
//               spots: chartData.map((data) {
//                 return FlSpot(data.getTimeAsDouble(), data.price);
//               }).toList(),
//               isCurved: true,
//              // colors: [Colors.blue],
             
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
          
//         ),
//       ),
//     ),
//     );
//   }
// }

// class Data {
//   final String time;
//   final double price;

//   Data(this.time, this.price);

//   double getTimeAsDouble() {
//     final parts = time.split(":");
//     final hours = double.parse(parts[0]);
//     final minutes = double.parse(parts[1]) / 60.0;
//     return hours + minutes;
//   }
// }