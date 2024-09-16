import 'package:fl_chart/fl_chart.dart'; // Ensure you're using fl_chart correctly
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For Date formatting
import 'package:shopzy_ecommerce_backend/controllers/controllers.dart';
import 'package:shopzy_ecommerce_backend/models/models.dart';
import 'package:shopzy_ecommerce_backend/screens/products_screen.dart';
import 'package:shopzy_ecommerce_backend/screens/screens.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController = Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopzy', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add the bar chart here
            FutureBuilder<List<OrderStats>>(
                future: orderStatsController.stats.value,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 250,
                      padding: const EdgeInsets.all(10),
                      child: CustomBarChart(
                        orderStats: snapshot.data!,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(child: CircularProgressIndicator(color: Colors.black));
                }
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductsScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to Products'),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => OrderScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to Orders'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    Key? key,
    required this.orderStats,
  }) : super(key: key);

  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: orderStats
            .map((orderStat) => BarChartGroupData(
          x: orderStat.index, // Use index as x
          barRods: [
            BarChartRodData(
              toY: orderStat.orders.toDouble(),
              color: orderStat.barColor,
              width: 15,
            )
          ],
        ))
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                return Text(DateFormat.d().format(orderStats[index].dateTime)); // Display date
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
