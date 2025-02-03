import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_assets.dart';

class ViewUtil {
  static Widget customOutlineContainer(
      {Key? key,
      required Widget child,
      double borderRadius = 0,
      Color color = Colors.grey,
      Color backgroundColor = Colors.white,
      double borderWidth = 0.5,
      double? height,
      double? width,
      bool isShadowPresent = true}) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: ShapeDecoration(
        shadows: [
          if (isShadowPresent)
            BoxShadow(
              color: Color(0x4CEDF0F4),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
        ],
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: borderWidth, color: color),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      // BoxDecoration(
      //     border: Border.all(
      //       color: color,
      //     ),
      //     borderRadius: BorderRadius.circular(borderRadius)),
      child: child,
    );
  }

  static Widget imageBackgroundContainer({
    required Widget child,
    required double height,
    required double width,
    required String background,
    bool isNetworkImage = true,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              fit: BoxFit.cover, image: CachedNetworkImageProvider(background)
              //: AssetImage(background),
              ),
        ),
        child: child);
  }

  static Widget circleImageBgContainer({
    required double radius,
    required String background,
    bool isNetworkImage = true,
  }) {
    return Container(
      width: radius,
      height: radius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: isNetworkImage
              ? CachedNetworkImageProvider(AppAssets.profileImage)
              : AssetImage(background),
        ),
        color: Colors.blue,
        shape: BoxShape.circle,
      ),

      // child: CachedNetworkImage(imageUrl: AppAssets.profileImage),
    );
  }

  static Widget tabBarHighlight(
      {double scale = 1,
      Color tapColor = AppColors.gold5,
      Widget? child,
      double radius = 50}) {
    return Container(
      width: radius * scale,
      height: radius * scale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tapColor,
      ),
      child: child,
    );
  }
}
