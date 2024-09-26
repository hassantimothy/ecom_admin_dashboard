// lib/screens/dashboard/components/dash_board_header.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../utility/extensions.dart';
import '../../../utility/constants.dart';
import '../../../widgets/responsive.dart';
import '../../main/provider/main_screen_provider.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Menu icon for smaller screens
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              context.read<MainScreenProvider>().toggleDrawer();
            },
          ),
        // Dashboard title

        const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: SearchField(
            onChange: (val) {
              context.dataProvider.filterProducts(val);
            },
          ),
        ),
        const Spacer(flex: 2),
        // Sun-Moon Button for theme toggle
        GetBuilder<ThemeController>(
          builder: (controller) => IconButton(
            icon: controller.isDarkMode
                ? Icon(Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color)
                : Icon(Icons.light_mode,
                    color: Theme.of(context).iconTheme.color),
            onPressed: () {
              controller.switchTheme();
            },
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  final Function(String) onChange;

  const SearchField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).cardColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
