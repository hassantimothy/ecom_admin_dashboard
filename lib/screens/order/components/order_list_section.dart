import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../utility/color_list.dart';
import '../../../models/order.dart';
import '../../../utility/constants.dart';
import 'view_order_form.dart';

class OrderListSection extends StatelessWidget {
  const OrderListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDarkMode ? cardDarkColor : cardLightColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Orders",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: defaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Consumer<DataProvider>(
                    builder: (context, dataProvider, child) {
                      return DataTable(
                        columnSpacing: defaultPadding,
                        columns: const [
                          DataColumn(
                            label: Text("Customer Name"),
                          ),
                          DataColumn(
                            label: Text("Order Amount"),
                          ),
                          DataColumn(
                            label: Text("Payment"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                          DataColumn(
                            label: Text("Date"),
                          ),
                          DataColumn(
                            label: Text("Edit"),
                          ),
                          DataColumn(
                            label: Text("Delete"),
                          ),
                        ],
                        rows: List.generate(
                          dataProvider.orders.length,
                          (index) => orderDataRow(
                            dataProvider.orders[index],
                            index + 1,
                            delete: () {
                              context.orderProvider
                                  .deleteOrder(dataProvider.orders[index]);
                            },
                            edit: () {
                              showOrderForm(
                                  context, dataProvider.orders[index]);
                            },
                            isDarkMode: isDarkMode,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

DataRow orderDataRow(Order orderInfo, int index,
    {Function? edit, Function? delete, required bool isDarkMode}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(orderInfo.userID?.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text('${orderInfo.orderTotal?.total}')),
      DataCell(Text(orderInfo.paymentMethod ?? '')),
      DataCell(Text(orderInfo.orderStatus ?? '')),
      DataCell(Text(orderInfo.orderDate ?? '')),
      DataCell(IconButton(
        onPressed: () {
          if (edit != null) edit();
        },
        icon: Icon(
          Icons.edit,
          color: isDarkMode ? Colors.white : Colors.black54,
        ),
      )),
      DataCell(IconButton(
        onPressed: () {
          if (delete != null) delete();
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      )),
    ],
  );
}
