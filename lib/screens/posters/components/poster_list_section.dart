import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/poster.dart';
import '../../../utility/constants.dart';
import 'add_poster_form.dart';

class PosterListSection extends StatelessWidget {
  const PosterListSection({
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
            "All Posters",
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
                            label: Text("Category Name"),
                          ),
                          DataColumn(
                            label: Text("Edit"),
                          ),
                          DataColumn(
                            label: Text("Delete"),
                          ),
                        ],
                        rows: List.generate(
                          dataProvider.posters.length,
                          (index) => posterDataRow(
                            dataProvider.posters[index],
                            delete: () {
                              context.posterProvider
                                  .deletePoster(dataProvider.posters[index]);
                            },
                            edit: () {
                              showAddPosterForm(
                                  context, dataProvider.posters[index]);
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

DataRow posterDataRow(Poster poster,
    {Function? edit, Function? delete, required bool isDarkMode}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              poster.imageUrl ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(Icons.error,
                    color: isDarkMode ? Colors.white : Colors.black54);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(poster.posterName ?? ''),
            ),
          ],
        ),
      ),
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
