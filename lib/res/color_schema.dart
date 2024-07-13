import 'package:ft_red_drop/package/config_packages.dart';

abstract class AppColor {
  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      AppPref().isDark = true;
    }
  }

  const AppColor._();

  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static Color primaryColor() {
    return isDarkTheme() ? DarkTheme.primary : LightTheme.primary;
  }

  ///======================== RedDrop ========================
  static const primaryRed = Color(0xFFDE0A1E);
  static const lightRedColor2 = Color(0xFFE54656);
  static const lightRedColor = Color(0xFFFFCACE);
  static const lightRedColor3 = Color(0xFFFFF1F2);
  static const primaryDarkBlue = Color(0xff050A30);
  static const primarySkyBlue = Color(0xffEEFEFF);
  static const whiteColor = Color(0xFFFFFFFF);
  static const textColor = Color(0xFF353535);
  static const textColor2 = Color(0xFF595959);
  static const textColor3 = Color(0xFF706F6F);
  static const secondaryColor = Color(0xFFB6B6B6);
  static const secondaryTextColor = Color(0xFFE3E3E3);
  static const blackColor = Color(0xFF000000);
  static const yellowColor = Color(0xFFFFB92A);
  static const lightBlueColor = Color(0xFFB5DCFF);
  static const greenColor = Color(0xFF4CAF50);


}

class LightTheme {
  static const primary = Color(0xff18191A);
}

class DarkTheme {
  static const primary = Color(0xff18191A);
}
