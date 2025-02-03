import 'package:flutter/material.dart';

class SizeUtil {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeUtil.screenHeight;

  return (inputHeight / 896) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeUtil.screenWidth;

  return (inputWidth / 412) * screenWidth;
}

extension SizeUtilExtension on num {
  double get w => (this / 412) * SizeUtil.screenWidth;

  double get h => (this / 896) * SizeUtil.screenHeight;
}
