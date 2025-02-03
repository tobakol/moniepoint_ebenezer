import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/size_util.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/theme_util.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

import '../../../resources/theme/app_colors.dart';
import '../../../resources/view_utilities/animations/animation_extensions.dart';
import '../../../resources/view_utilities/view_util.dart';

class LiveCards extends StatefulWidget {
  const LiveCards(
      {super.key,
      this.setNavBar,
      required this.imageUrl,
      required this.containerWidth,
      required this.header,
      this.containerHeight = 200});
  final String imageUrl;
  final double containerWidth;
  final double containerHeight;
  final VoidCallback? setNavBar;
  final String header;

  @override
  State<LiveCards> createState() => _LiveCardsState();
}

class _LiveCardsState extends State<LiveCards> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool startExpansion = false;
  bool showText = false;
  bool startFadeIn = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationUtil.genAnimController(
      this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward().then((_) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          startExpansion = true;
        });

        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            showText = true; // Text now exists
          });

          Future.delayed(Duration(milliseconds: 100), () {
            setState(() {
              startFadeIn = true;
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _assertSizedBoxInleft = false;
  @override
  Widget build(BuildContext context) {
    double liveTogglePadding = 10;
    return ViewUtil.imageBackgroundContainer(
      background: widget.imageUrl,
      height: widget.containerHeight,
      width: widget.containerWidth,
      isNetworkImage: true,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              onEnd: () {
                if (widget.setNavBar != null) {
                  widget.setNavBar!();
                }
                setState(() {
                  _assertSizedBoxInleft = true;
                });
              },
              duration: Duration(seconds: 2),
              curve: Curves.easeOut,
              width: startExpansion
                  ? widget.containerWidth - (2 * liveTogglePadding)
                  : 48,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xF7F6F6F6),
                    Color(0xF7B8B8B8),
                    Color(0xF76B6B6B)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.containerWidth > ((412.w) / 2) &&
                      _assertSizedBoxInleft)
                    SizedBox(
                      width: 22,
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Offstage(
                      offstage: !showText,
                      child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: startFadeIn ? 1.0 : 0.0,
                        child: Text(
                          widget.header,
                          textAlign: TextAlign.center,
                          style: TextStyle().titleSmall,
                        ).padding(left: 10),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.neutral4,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.neutral10,
                    ),
                  ).padding(right: 2)
                ],
              ),
            ),
          );
        },
      ).padding(bottom: 6, left: liveTogglePadding, right: liveTogglePadding),
    );
  }
}
