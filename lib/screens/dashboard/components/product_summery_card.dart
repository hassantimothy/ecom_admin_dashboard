import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/constants.dart';
import '../../../models/product_summery_info.dart';

// Stateless widget to display product summary
class ProductSummeryCard extends StatelessWidget {
  const ProductSummeryCard({
    Key? key,
    required this.info, // Product summary information
    required this.onTap, // Callback function for tap events
  }) : super(key: key);

  final ProductSummeryInfo info; // Product summary information
  final Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return InkWell(
      onTap: () {
        onTap(info.title); // Trigger onTap callback with product title
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: isDarkMode ? cardDarkColor : cardLightColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to start
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Distribute space between children
          children: [
            Text(
              info.title!, // Display product title
              maxLines: 1, // Limit to one line
              overflow: TextOverflow.ellipsis, // Ellipsis for overflow text
            ),
            // Replace ProgressLine with ProgressCircle
            ResponsiveProgressCircle(
              color: info.color, // Progress circle color
              percentage: info.percentage, // Progress percentage
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Space between items
                children: [
                  Text(
                    "${info.productsCount} Product", // Display number of products
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isDarkMode
                            ? Colors.white70
                            : Colors.black87), // Conditional text color
                    overflow:
                        TextOverflow.ellipsis, // Ellipsis for overflow text
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Stateless widget to display progress as a responsive circle
class ResponsiveProgressCircle extends StatelessWidget {
  const ResponsiveProgressCircle({
    Key? key,
    this.color = primaryColor, // Default color for the progress circle
    required this.percentage, // Required percentage value
  }) : super(key: key);

  final Color? color; // Color of the progress circle
  final double? percentage; // Progress percentage

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.2; // 20% of the available width
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: percentage! / 100, // Set value based on percentage
            backgroundColor: color!.withOpacity(0.1), // Light background
            valueColor: AlwaysStoppedAnimation<Color>(color!), // Progress color
          ),
        );
      },
    );
  }
}
