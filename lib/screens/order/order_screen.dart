import 'package:admin/utility/extensions.dart';
import 'components/order_header.dart';
import 'components/order_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_dropdown.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const OrderHeader(),
            const SizedBox(height: defaultPadding),
            LayoutBuilder(
              builder: (context, constraints) {
                // Check screen width and adjust layout
                if (constraints.maxWidth < 850) {
                  // Mobile Layout
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildOrderHeader(context),
                      const Gap(defaultPadding),
                      const OrderListSection(),
                    ],
                  );
                } else {
                  // Tablet/Laptop Layout
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            buildOrderHeader(context),
                            const Gap(defaultPadding),
                            const OrderListSection(),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Extracted method to handle the order header (reused in both layouts)
  Widget buildOrderHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            "Orders",
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Gap(20),
        SizedBox(
          width: 300,
          child: CustomDropdown(
            hintText: 'Filter Order By status',
            initialValue: 'All order',
            items: const [
              'All order',
              'pending',
              'processing',
              'shipped',
              'delivered',
              'cancelled'
            ],
            displayItem: (val) => val,
            onChanged: (newValue) {
              if (newValue?.toLowerCase() == 'all order') {
                context.dataProvider.filterOrders('');
              } else {
                context.dataProvider
                    .filterOrders(newValue?.toLowerCase() ?? '');
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Please select status';
              }
              return null;
            },
          ),
        ),
        const Gap(40),
        IconButton(
            onPressed: () {
              context.dataProvider.getAllOrders(showSnack: true);
            },
            icon: const Icon(Icons.refresh)),
      ],
    );
  }
}
