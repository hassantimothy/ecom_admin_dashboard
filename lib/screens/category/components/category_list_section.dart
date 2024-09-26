import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../models/category.dart';
import 'add_category_form.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "All Categories",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: defaultPadding),
          // Wrapping in LayoutBuilder to handle responsive layout
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
                            label: Text("Category Name"),
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
                          dataProvider.categories.length,
                          (index) => categoryDataRow(
                            dataProvider.categories[index],
                            index + 1,
                            delete: () {
                              context.categoryProvider.deleteCategory(
                                  dataProvider.categories[index]);
                            },
                            edit: () {
                              showAddCategoryForm(
                                  context, dataProvider.categories[index]);
                            },
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

DataRow categoryDataRow(Category catInfo, int index,
    {Function? edit, Function? delete}) {
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
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(catInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(catInfo.createdAt ?? '')),
      DataCell(IconButton(
        onPressed: () {
          if (edit != null) edit();
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
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
