// lib/screens/main/components/side_menu.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/responsive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSideMenu(context, Responsive.isMobile(context));
  }

  Widget _buildSideMenu(BuildContext context, bool isSmallScreen) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: isSmallScreen ? 100 : 200,
                  ),
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashboard.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Dashboard');
                  },
                ),
                DrawerListTile(
                  title: "Category",
                  svgSrc: "assets/icons/menu_tran.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Category');
                  },
                ),
                DrawerListTile(
                  title: "Sub Category",
                  svgSrc: "assets/icons/menu_task.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('SubCategory');
                  },
                ),
                DrawerListTile(
                  title: "Brands",
                  svgSrc: "assets/icons/menu_doc.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Brands');
                  },
                ),
                DrawerListTile(
                  title: "Variant Type",
                  svgSrc: "assets/icons/menu_store.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('VariantType');
                  },
                ),
                DrawerListTile(
                  title: "Variants",
                  svgSrc: "assets/icons/menu_notification.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Variants');
                  },
                ),
                DrawerListTile(
                  title: "Orders",
                  svgSrc: "assets/icons/menu_profile.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Order');
                  },
                ),
                DrawerListTile(
                  title: "Coupons",
                  svgSrc: "assets/icons/menu_setting.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Coupon');
                  },
                ),
                DrawerListTile(
                  title: "Posters",
                  svgSrc: "assets/icons/menu_doc.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider.navigateToScreen('Poster');
                  },
                ),
                DrawerListTile(
                  title: "Notifications",
                  svgSrc: "assets/icons/menu_notification.svg",
                  isSmallScreen: isSmallScreen,
                  press: () {
                    context.mainScreenProvider
                        .navigateToScreen('Notifications');
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: ProfileCard(),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSmallScreen,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        press(); // This calls the navigation function
        if (Responsive.isMobile(context)) {
          context.mainScreenProvider.toggleDrawer();
        }
      },
      horizontalTitleGap: isSmallScreen ? 4.0 : 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter:
            ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
        height: isSmallScreen ? 12 : 16,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: isSmallScreen ? 12 : 14,
            ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 200;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 20, 109, 168).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: isSmallScreen ? 16 : 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (!isSmallScreen) ...[
                const SizedBox(width: 12),
                Text(
                  "Admin",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
