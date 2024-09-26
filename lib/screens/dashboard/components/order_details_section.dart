// admin_dashboard/lib/screens/dashboard/components/order_details_section.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import 'chart.dart';
import 'order_info_card.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        int totalOrder = context.dataProvider.calculateOrdersWithStatus();
        int pendingOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'pending');
        int processingOrder = context.dataProvider
            .calculateOrdersWithStatus(status: 'processing');
        int cancelledOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
        int shippedOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
        int deliveredOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'delivered');

        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders Details",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  constraints.maxWidth > 600
                      ? _buildWideLayout(
                          context,
                          totalOrder,
                          pendingOrder,
                          processingOrder,
                          cancelledOrder,
                          shippedOrder,
                          deliveredOrder)
                      : _buildNarrowLayout(
                          context,
                          totalOrder,
                          pendingOrder,
                          processingOrder,
                          cancelledOrder,
                          shippedOrder,
                          deliveredOrder),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildWideLayout(
      BuildContext context,
      int totalOrder,
      int pendingOrder,
      int processingOrder,
      int cancelledOrder,
      int shippedOrder,
      int deliveredOrder) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 2,
          child: Chart(),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildOrderInfoCards(
                  context,
                  totalOrder,
                  pendingOrder,
                  processingOrder,
                  cancelledOrder,
                  shippedOrder,
                  deliveredOrder),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(
      BuildContext context,
      int totalOrder,
      int pendingOrder,
      int processingOrder,
      int cancelledOrder,
      int shippedOrder,
      int deliveredOrder) {
    return Column(
      children: [
        const Chart(),
        const SizedBox(height: defaultPadding),
        _buildOrderInfoCards(context, totalOrder, pendingOrder, processingOrder,
            cancelledOrder, shippedOrder, deliveredOrder),
      ],
    );
  }

  Widget _buildOrderInfoCards(
      BuildContext context,
      int totalOrder,
      int pendingOrder,
      int processingOrder,
      int cancelledOrder,
      int shippedOrder,
      int deliveredOrder) {
    return Wrap(
      spacing: defaultPadding,
      runSpacing: defaultPadding,
      children: [
        OrderInfoCard(
          svgSrc: "assets/icons/delivery1.svg",
          title: "All Orders",
          totalOrder: totalOrder,
        ),
        OrderInfoCard(
          svgSrc: "assets/icons/delivery5.svg",
          title: "Pending Orders",
          totalOrder: pendingOrder,
        ),
        OrderInfoCard(
          svgSrc: "assets/icons/delivery6.svg",
          title: "Processed Orders",
          totalOrder: processingOrder,
        ),
        OrderInfoCard(
          svgSrc: "assets/icons/delivery2.svg",
          title: "Cancelled Orders",
          totalOrder: cancelledOrder,
        ),
        OrderInfoCard(
          svgSrc: "assets/icons/delivery4.svg",
          title: "Shipped Orders",
          totalOrder: shippedOrder,
        ),
        OrderInfoCard(
          svgSrc: "assets/icons/delivery3.svg",
          title: "Delivered Orders",
          totalOrder: deliveredOrder,
        ),
      ],
    );
  }
}
