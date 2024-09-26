// lib/screens/main/main_screen.dart
// lib/screens/main/main_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/utility/extensions.dart';
import 'package:admin/widgets/responsive.dart';
import 'provider/main_screen_provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.dataProvider;
    final bool showSideMenu = Responsive.isDesktop(context);

    return Scaffold(
      key: context.read<MainScreenProvider>().scaffoldKey,
      drawer: showSideMenu ? null : const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSideMenu)
              const Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
              flex: showSideMenu ? 5 : 6,
              child: Consumer<MainScreenProvider>(
                builder: (context, provider, child) {
                  return provider.selectedScreen;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
