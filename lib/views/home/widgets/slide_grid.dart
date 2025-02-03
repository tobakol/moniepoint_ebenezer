import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/size_util.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

import '../../../resources/theme/app_colors.dart';
import '../../../resources/view_utilities/animations/animation_extensions.dart';
import '../../../resources/view_utilities/app_assets.dart';
import 'counter.dart';
import 'live_cards.dart';

class SlideInGridViewExample extends StatefulWidget {
  const SlideInGridViewExample({super.key, required this.setNavBar});
  final VoidCallback setNavBar;

  @override
  State<SlideInGridViewExample> createState() => _SlideInGridViewExampleState();
}

class _SlideInGridViewExampleState extends State<SlideInGridViewExample>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late AnimationController _slideController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<int> _countAnimation;
  late Animation<int> _countAnimation2;
  bool secondAnimationTriggered = false;
  @override
  void initState() {
    super.initState();

    // Initialize controllers
    scaleController = AnimationUtil.genAnimController(
      this,
    );
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _slideController.forward(); // Start sliding in
      }
    });

    _slideController = AnimationUtil.genAnimController(
      this,
    );

    _countAnimation = IntTween(begin: 0, end: 964).animate(scaleController);
    _countAnimation2 = IntTween(begin: 0, end: 2062).animate(scaleController);
    // Fade out animation for the circle
    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeOut),
    );

    // Slide up animation for the GridView
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    _startAnimationSequence();
  }

  @override
  void dispose() {
    scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _startAnimationSequence() async {
    scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CountingContainer(
                  scaleAnimation: scaleAnimation,
                  countAnimation: _countAnimation,
                  textColor: AppColors.gold2,
                  bubbleColor: AppColors.gold5,
                  topText: "BUY",
                ),
                SizedBox(
                  width: 20.w,
                ),
                CountingContainer(
                  scaleAnimation: scaleAnimation,
                  countAnimation: _countAnimation2,
                  textColor: AppColors.gold7,
                  bubbleColor: AppColors.fillColor,
                  topText: "RENT",
                  boxShape: BoxShape.rectangle,
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _slideController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: child,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: 412.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
                  LiveCards(
                    header: "Gladkova St, 25",
                    imageUrl: AppAssets.imagePlaceUrl1,
                    containerWidth: 400.w,
                    containerHeight: 200.w,
                    setNavBar: widget.setNavBar,
                  ).padding(bottom: 12),
                  SizedBox(
                    height: 420.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LiveCards(
                          header: "Gubina St, 11",
                          imageUrl: AppAssets.imagePlaceUrl2,
                          containerWidth: 185.w,
                          containerHeight: 416.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LiveCards(
                              header: "Treflova St, 11",
                              containerWidth: 185.w,
                              containerHeight: 200.w,
                              imageUrl: AppAssets.imagePlaceUrl3,
                            ),
                            LiveCards(
                              header: "Sedova St, 25",
                              imageUrl: AppAssets.imagePlaceUrl4,
                              containerWidth: 185.w,
                              containerHeight: 200.w,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ).padding(bottom: 20.w),
            ),
          ),
        ],
      ),
    );
  }
}
