import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/theme_util.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

import '../../../resources/theme/app_colors.dart';
import '../../../resources/view_utilities/animations/animation_extensions.dart';
import '../../../resources/view_utilities/view_util.dart';
import '../widgets/custom_markers.dart';
import '../widgets/map_bg.dart';
import '../widgets/option_icon.dart';
import '../widgets/search_row.dart';

// }

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  late AnimationController _fadeTextController;
  late Animation<double> _fadeText;

  late AnimationController _fadeIconController;
  late Animation<double> _fadeIcon;

  double _currentWidth = 0;
  final double minWidth = 30.0;
  final double maxWidth = 40.0;
  final double containerHeight = 20.0;
  final int containerCount = 5;
  final Color containerColor = AppColors.gold5;
  late List<Offset> _positions;
  List<double> verticalCordinates = [240, 280, 520, 360, 400];

  List<double> horizontalCordinates = [120, 240, 120, 80, 250];
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });

    _controller = AnimationUtil.genAnimController(
      this,
    )..forward();

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _fadeTextController = AnimationUtil.genAnimController(
      this,
    );

    _fadeText =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeTextController);

    _fadeIconController = AnimationUtil.genAnimController(
      this,
    );

    _fadeIcon = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeIconController, curve: Interval(0.5, 1.0)),
    );

    _fadeTextController.forward();

    _positions = List.generate(containerCount, (index) {
      return Offset(
        horizontalCordinates[index],
        verticalCordinates[index],
      );
    });
  }

  void shrinkWidth() {
    setState(() {
      _currentWidth = minWidth;
      _fadeTextController.reverse(); // Text fades out
      _fadeIconController.forward(); // Icon fades in
    });
  }

  void restoreWidth() {
    setState(() {
      _currentWidth = maxWidth;
      _fadeTextController.forward(); // Text fades in
      _fadeIconController.reverse(); // Icon fades out
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapLayoutBg(),
        Positioned(
            top: 80,
            right: 60,
            left: 60,
            child: SearchRow(
              scale: _scale,
            )),
        ...List.generate(containerCount, (index) {
          return Positioned(
            left: _positions[index].dx,
            top: _positions[index].dy,
            child: MarkerContainers(
                index: index,
                scaleAnimation: _scaleAnimation,
                currentWidth: _currentWidth,
                containerHeight: containerHeight,
                containerColor: containerColor,
                maxWidth: maxWidth,
                fadeText: _fadeText,
                minWidth: minWidth,
                fadeIcon: _fadeIcon),
          );
        }),

        // Buttons at Bottom
        Positioned(
            bottom: 130,
            left: 40,
            child: Column(
              children: [
                OptionIcon(
                  scale: _scale,
                  shrinkFunction: shrinkWidth,
                  expandFunction: restoreWidth,
                  onChooseOption: (selectedIndex) {},
                )
              ],
            )),
        Positioned(
            bottom: 130,
            right: 40,
            child: ViewUtil.customOutlineContainer(
                    backgroundColor: Color(0x80F6F6F6),
                    borderRadius: 24,
                    height: 48,
                    isShadowPresent: false,
                    child: Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 24,
                          color: Colors.white,
                        ).padding(right: 8),
                        Text(
                          "List of Variants",
                          style: TextStyle().bodyLarge.makeWhite,
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 12))
                .scaleAnimation(isVisible: true, then: restoreWidth)),
      ],
    );
  }

  // leading: Icon(Icons.list_alt_outlined),
  @override
  void dispose() {
    _controller.dispose();
    _fadeTextController.dispose();
    _fadeIconController.dispose();
    super.dispose();
  }
}
