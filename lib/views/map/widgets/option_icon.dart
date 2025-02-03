import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/size_util.dart';

import '../../../resources/theme/app_colors.dart';
import '../../../resources/view_utilities/animations/animation_extensions.dart';
import '../../../resources/view_utilities/view_util.dart';

class OptionIcon extends StatefulWidget {
  const OptionIcon(
      {super.key,
      required this.scale,
      required this.onChooseOption,
      required this.expandFunction,
      required this.shrinkFunction});
  final Function(int selectedIndex) onChooseOption;
  final VoidCallback shrinkFunction;
  final VoidCallback expandFunction;
  final double scale;

  @override
  State<OptionIcon> createState() => _OptionIconState();
}

class _OptionIconState extends State<OptionIcon> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;
  List<String> choiceText = [
    'Cosy areas',
    'Price',
    'Infrastructure',
    'WITHOUT layer'
  ];
  List<IconData> headerIcon = [
    Icons.health_and_safety,
    Icons.wallet,
    Icons.delete_forever_rounded,
    Icons.stacked_line_chart_rounded
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationUtil.genAnimController(
      this,
    );

    // Define the scale animation from 0 to 1
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    // Trigger the scale animation when tapped
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  int selectedIndex = 9;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      alignment: Alignment.bottomLeft,
      child: Column(
        children: [
          SizedBox(
            child: Stack(
              clipBehavior: Clip.none, // Allow the new container to overflow
              children: [
                // Small initial container
                SizedBox(
                  height: 250,
                  child: GestureDetector(
                    onTap: _toggleAnimation,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Color(0x80F6F6F6),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.wallet_travel_outlined,
                              color: Colors.white,
                            ),
                          ).animatedScale(scale: widget.scale),
                        ],
                      ),
                    ),
                  ),
                ),
                // Animated larger container
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.bottomLeft,
                        child: ViewUtil.customOutlineContainer(
                            color: Colors.white,
                            borderRadius: 16,
                            // height: 400,
                            width: 200,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(4, (index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 1) {
                                        widget.shrinkFunction();
                                      }
                                      if (index == 3) {
                                        widget.expandFunction();
                                      }
                                      setState(() {
                                        selectedIndex = index;
                                      });

                                      _toggleAnimation();
                                    },
                                    child: ListTile(
                                      horizontalTitleGap: 0,
                                      minLeadingWidth: 30.w,
                                      leading: Icon(headerIcon[index]),
                                      title: Text(
                                        choiceText[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: index == selectedIndex
                                                ? AppColors.gold5
                                                : null),
                                      ),
                                    ),
                                  );
                                }))),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0x80F6F6F6), shape: BoxShape.circle),
              child: Icon(
                Icons.near_me_outlined,
                color: Colors.white,
              ),
            ).animatedScale(scale: widget.scale),
          ),
        ],
      ),
    );
  }
}
