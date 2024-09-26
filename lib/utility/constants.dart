// lib/utility/constants.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';

// Light Mode Colors
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFFFFFFFF);
const cardLightColor = Color(0xFFE5E5E5);

// Dark Mode Colors
const primaryDarkColor = Color(0xFFBB86FC);
const secondaryDarkColor = Color(0xFF121212);
const bgDarkColor = Color(0xFF212121);
const cardDarkColor = Color(0xFF333333);

// Default Padding
const double defaultPadding = 16.0;

// Main URL for API or server-related requests, used in development
const mainUrl = 'http://localhost:3000';

// Theme Management
class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
    update();
  }

  bool get isDarkMode => _loadThemeFromBox();
}

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: bgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
  ),
  cardColor: cardLightColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
  canvasColor: Colors.grey[200],
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryDarkColor,
  scaffoldBackgroundColor: bgDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryDarkColor,
  ),
  cardColor: cardDarkColor,
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
  canvasColor: secondaryDarkColor,
);

// Initialize ThemeController
Future<void> initializeThemeController() async {
  await GetStorage.init();
  Get.put(ThemeController());
}
