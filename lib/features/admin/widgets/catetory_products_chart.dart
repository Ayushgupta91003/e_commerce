import 'package:e_commerce/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'sales.dart'; // Import your Sales model here

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> earnings;

  const CategoryProductsChart({
    Key? key,
    required this.earnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Adjusted for better layout
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: earnings
              .map((sale) => BarChartGroupData(
                    x: earnings.indexOf(sale),
                    barRods: [
                      BarChartRodData(
                        toY: sale.earning.toDouble(),
                        width: 20,
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ))
              .toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                // margin: 8,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < earnings.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        earnings[value.toInt()].label,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}












// import 'package:fl_chart/fl_chart.dart';
// import 'package:e_commerce/features/admin/models/sales.dart';
// import 'package:flutter/material.dart';

// class CategoryProductsChart extends StatelessWidget {
//   final List<Sales> earnings;

//   const CategoryProductsChart({
//     Key? key,
//     required this.earnings,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         barGroups: earnings
//             .map((sale) => BarChartGroupData(
//                   x: earnings.indexOf(sale),
//                   barRods: [
//                     BarChartRodData(
//                       toY: sale.earning.toDouble(),
//                       width: 20,
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ],
//                 ))
//             .toList(),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: true),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 if (value.toInt() >= 0 && value.toInt() < earnings.length) {
//                   return Text(
//                     earnings[value.toInt()].label,
//                     style: const TextStyle(fontSize: 10),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ),
//         gridData: FlGridData(show: true),
//         borderData: FlBorderData(show: false),
//       ),
//     );
//   }
// }













// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:e_commerce/features/admin/models/sales.dart';
// import 'package:flutter/material.dart';

// class CategoryProductsChart extends StatelessWidget {
//   final List<charts.Series<Sales, String>> seriesList;
//   const CategoryProductsChart({
//     Key? key,
//     required this.seriesList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return charts.BarChart(
//       seriesList,
//       animate: true,
//     );
//   }
// }






// import 'package:e_commerce/features/admin/models/sales.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class CategoryProductsChart extends StatelessWidget {
//   final List<Sales> salesData;
//   const CategoryProductsChart({
//     Key? key,
//     required this.salesData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: BarChart(
//         BarChartData(
//           barGroups: salesData
//               .asMap()
//               .entries
//               .map(
//                 (entry) => BarChartGroupData(
//                   x: entry.key,
//                   barRods: [
//                     BarChartRodData(
//                       toY: entry.value.sales.toDouble(),
//                       color: Colors.blue,
//                       width: 16,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ],
//                 ),
//               )
//               .toList(),
//           borderData: FlBorderData(show: false),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   return Text(salesData[value.toInt()].category);
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
