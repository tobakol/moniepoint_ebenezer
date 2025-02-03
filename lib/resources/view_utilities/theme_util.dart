import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ThemeUtil {
  static late ThemeData _themeData;
  static late TextTheme textTheme;

  void init(BuildContext context) {
    _themeData = Theme.of(context);
    textTheme = _themeData.textTheme;
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get displaySmall => merge(ThemeUtil.textTheme.displaySmall);
  TextStyle get bodySmall => merge(ThemeUtil.textTheme.bodySmall);
  //TextStyle get bodySmallBlack => merge(ThemeUtil.textTheme.bodySmall).merge(TextStyle(color: Colors.black));

  TextStyle get bodyMedium => merge(ThemeUtil.textTheme.bodyMedium);
  TextStyle get bodyLarge => merge(ThemeUtil.textTheme.bodyLarge);
  // TextStyle get bodyLargeBlack => merge(ThemeUtil.textTheme.bodyLarge).merge(TextStyle(color: Colors.black));

  TextStyle get titleSmall => merge(ThemeUtil.textTheme.titleSmall);
  TextStyle get titleMedium => merge(ThemeUtil.textTheme.titleMedium);
  TextStyle get titleLarge => merge(ThemeUtil.textTheme.titleLarge);
  TextStyle get headlineSmall => merge(ThemeUtil.textTheme.headlineSmall);
  TextStyle get headlineMedium => merge(ThemeUtil.textTheme.headlineMedium);
  TextStyle get headlineLarge => merge(ThemeUtil.textTheme.headlineLarge);
  TextStyle get makeBlack => merge(TextStyle(color: Colors.black));
  TextStyle get makeGold => merge(TextStyle(color: AppColors.gold7));
  TextStyle get makeWhite => merge(TextStyle(color: Colors.white));

  TextStyle get onboardingHeadline =>
      merge(ThemeUtil.textTheme.headlineMedium).merge(TextStyle(
          fontSize: 20,
          fontFamily: 'Inter-Bold',
          fontWeight: FontWeight.w800,
          height: 0,
          letterSpacing: 0.25));

  //  TextStyle get getBodySmallTheme => merge(ThemeUtil.textTheme.bodySmall);
//TextStyle get getBodySmallTheme => merge(ThemeUtil.textTheme.bodySmall);
}

TextStyle appTextStyle({required TextStyle theme}) {
  return TextStyle().merge(theme);
}
