// admin_dashboard/lib/screens/dashboard/components/chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../core/data/data_provider.dart';
import '../../../utility/extensions.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < 300 ? 150.0 : 200.0;
        return SizedBox(
          height: size,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: size * 0.35,
                  startDegreeOffset: -90,
                  sections: _buildPieChartSelectionData(context),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: defaultPadding / 2),
                    Consumer<DataProvider>(
                      builder: (context, dataProvider, child) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${context.dataProvider.calculateOrdersWithStatus()}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  height: 0.5,
                                ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Order"),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
    // ignore: unused_local_variable
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    int pendingOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'pending');
    int processingOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'processing');
    int cancelledOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
    int shippedOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
    int deliveredOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'delivered');

    return [
      PieChartSectionData(
        color: Theme.of(context).colorScheme.secondary,
        value: pendingOrder.toDouble(),
        showTitle: false,
        radius: 15,
      ),
      PieChartSectionData(
        color: Theme.of(context).colorScheme.error,
        value: cancelledOrder.toDouble(),
        showTitle: false,
        radius: 15,
      ),
      PieChartSectionData(
        color: Theme.of(context).primaryColor,
        value: shippedOrder.toDouble(),
        showTitle: false,
        radius: 15,
      ),
      PieChartSectionData(
        color: Theme.of(context).colorScheme.primaryContainer,
        value: deliveredOrder.toDouble(),
        showTitle: false,
        radius: 15,
      ),
      PieChartSectionData(
        color: Theme.of(context).scaffoldBackgroundColor,
        value: processingOrder.toDouble(),
        showTitle: false,
        radius: 15,
      ),
    ];
  }
}
