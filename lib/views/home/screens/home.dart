import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/animations/animation_extensions.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

import '../../../resources/theme/app_colors.dart';
import '../../../resources/view_utilities/app_assets.dart';
import '../../../resources/view_utilities/size_util.dart';
import '../../../resources/view_utilities/theme_util.dart';
import '../../../resources/view_utilities/view_util.dart';
import '../widgets/slide_grid.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.raiseNavBar});
  final VoidCallback raiseNavBar;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool anim1 = false;
  bool anim2 = false;
  bool anim3 = false;
  bool anim4 = false;
  bool anim5 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 896.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gold0_5,
                AppColors.gold1,
                AppColors.gold2,
                AppColors.gold3
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        locationTag(),
                        profilePicture(),
                      ],
                    ),
                    greetingText().padding(top: 20),
                  ],
                ).paddingSymmetric(horizontal: 24, vertical: 20),
                if (anim5)
                  SlideInGridViewExample(
                    setNavBar: widget.raiseNavBar,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profilePicture() {
    return ViewUtil.circleImageBgContainer(
            radius: 45, background: AppAssets.profileImage)
        .scaleAnimation(
            isVisible: true,
            then: () {
              setState(() => anim1 = true);
            },
            duration: Duration(milliseconds: 1000));
  }

  Widget greetingText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, Marina",
            style: TextStyle().headlineMedium.makeGold,
          )
              .fadeAnimation(
                  isVisible: anim3,
                  duration: Duration(seconds: 1),
                  then: () {
                    setState(() => anim4 = true);
                  })
              .padding(top: 40, bottom: 16),
          Text(
            "Let's select your",
            style: TextStyle(
              fontSize: 40,
              height: 1,
            ),
          )
              .risingAnimation(
                  height: 40,
                  then: () => setState(() => anim5 = true),
                  isVisible: anim4)
              .padding(bottom: 8),
          Text(
            "favorite place",
            style: TextStyle(
              fontSize: 40,
              height: 1,
            ),
          ).risingAnimation(
              height: 40,
              then: () => setState(() => anim5 = true),
              isVisible: anim4),
        ],
      ).padding(bottom: 20),
    );
  }

  Widget locationTag() {
    return ViewUtil.customOutlineContainer(
            color: Colors.transparent,
            borderRadius: 16,
            height: 50,
            backgroundColor: Colors.white,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.gold7,
                ),
                Text(
                  "Saint Petersburg",
                  style: TextStyle(color: AppColors.gold7),
                )
              ],
            )
                .fadeAnimation(
                    duration: Duration(milliseconds: 1000),
                    isVisible: anim2,
                    then: () => setState(() => anim3 = true))
                .paddingSymmetric(horizontal: 16))
        .scaleAxisAnimation(
      isVisible: anim1,
      duration: Duration(milliseconds: 1000),
      scaleAxis: Axis.horizontal,
      initialSize: 0,
      finalSize: 200,
      then: () {
        setState(() => anim2 = true);
      },
    );
  }
}
