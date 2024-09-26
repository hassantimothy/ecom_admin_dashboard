// lib/main.dart
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/data/data_provider.dart';
import 'core/routes/app_pages.dart';
import 'screens/brands/provider/brand_provider.dart';
import 'screens/category/provider/category_provider.dart';
import 'screens/coupon_code/provider/coupon_code_provider.dart';
import 'screens/dashboard/provider/dash_board_provider.dart';
import 'screens/main/main_screen.dart';
import 'screens/main/provider/main_screen_provider.dart';
import 'screens/notification/provider/notification_provider.dart';
import 'screens/order/provider/order_provider.dart';
import 'screens/posters/provider/poster_provider.dart';
import 'screens/sub_category/provider/sub_category_provider.dart';
import 'screens/variants/provider/variant_provider.dart';
import 'screens/variants_type/provider/variant_type_provider.dart';
import 'utility/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeThemeController(); // Initialize the ThemeController
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataProvider()),
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(
        create: (context) => CategoryProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => SubCategoryProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => BrandProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => VariantsTypeProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => VariantsProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => DashBoardProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => CouponCodeProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => PosterProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => OrderProvider(context.dataProvider)),
    ChangeNotifierProvider(
        create: (context) => NotificationProvider(context.dataProvider)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Get.find<ThemeController>().theme,
      initialRoute: AppPages.HOME,
      unknownRoute: GetPage(name: '/notFound', page: () => const MainScreen()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}
