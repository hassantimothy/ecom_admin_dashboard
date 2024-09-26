import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../models/variant_type.dart';
import 'add_variant_type_form.dart';

class VariantsTypeListSection extends StatelessWidget {
  const VariantsTypeListSection({
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
            "All Variants Type",
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
                            label: Text("Variant Name"),
                          ),
                          DataColumn(
                            label: Text("Variant Type"),
                          ),
                          DataColumn(
                            label: Text("Added Date"),
                          ),
                          DataColumn(
                            label: Text("Edit"),
                          ),
                          DataColumn(
                            label: Text("Delete"),
                          ),
                        ],
                        rows: List.generate(
                          dataProvider.variantTypes.length,
                          (index) => variantTypeDataRow(
                            dataProvider.variantTypes[index],
                            index + 1,
                            edit: () {
                              showAddVariantsTypeForm(
                                  context, dataProvider.variantTypes[index]);
                            },
                            delete: () {
                              context.variantTypeProvider.deleteVariantType(
                                  dataProvider.variantTypes[index]);
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

DataRow variantTypeDataRow(VariantType variantTypeInfo, int index,
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
              child: Text(variantTypeInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(variantTypeInfo.type ?? '')),
      DataCell(Text(variantTypeInfo.createdAt ?? '')),
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
