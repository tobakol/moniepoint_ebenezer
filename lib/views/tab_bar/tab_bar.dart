import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

import '../../resources/theme/app_colors.dart';
import '../../resources/view_utilities/animations/animation_extensions.dart';
import '../../resources/view_utilities/size_util.dart';
import '../../resources/view_utilities/theme_util.dart';
import '../../resources/view_utilities/view_util.dart';
import '../home/screens/home.dart';
import '../map/screens/map_screener.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _isNavBarVisible = false;
  int _selectedIndex = 2;
  int _previousIndex = 9;

  // List of screens
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      MapScreen(),
      Placeholder(),
      HomePageScreen(
        raiseNavBar: () {
          _toggleNavBar();
        },
      ),
      Placeholder(),
      Placeholder()
    ];

    _slideAnimationController = AnimationUtil.genAnimController(this);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 2), // Off-screen initially
      end: Offset(0, 0), // Normal position
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeOutBack, // Smooth animation
    ));

    _scaleAnimationController = AnimationUtil.genAnimController(this);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeOutExpo, // Smooth expand effect
    ));
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    _scaleAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    SizeUtil().init(context);
    ThemeUtil().init(context);
    super.didChangeDependencies();
  }

  void _toggleNavBar() {
    setState(() {
      _isNavBarVisible = true;
    });

    if (_isNavBarVisible) {
      _slideAnimationController.forward();
    } else {
      _slideAnimationController.reverse();
    }
  }

  void _onTabSelected(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
    _pageController.jumpToPage(
      _selectedIndex,
    );
    _scaleAnimationController.forward(from: 0.0);
  }

  final PageController _pageController = PageController(initialPage: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: (value) {
              _selectedIndex = value;
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: ViewUtil.customOutlineContainer(
                      backgroundColor: AppColors.neutral9_5,
                      borderWidth: 0,
                      isShadowPresent: false,
                      borderRadius: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(Icons.saved_search_rounded, 0)
                              .padding(right: 8),
                          _buildNavItem(Icons.message, 1).padding(right: 8),
                          _buildNavItem(Icons.other_houses_sharp, 2)
                              .padding(right: 8),
                          _buildNavItem(Icons.heart_broken, 3)
                              .padding(right: 8),
                          _buildNavItem(Icons.person, 4),
                        ],
                      ).paddingSymmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ViewUtil.tabBarHighlight(tapColor: AppColors.a, radius: 45),
          if (_previousIndex == 7 + index || index == _previousIndex)
            ViewUtil.tabBarHighlight().fadeAnimation(
                isVisible: index == _previousIndex,
                fadeIn: false,
                duration: Duration(milliseconds: 1000)),
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              double scale = isSelected ? _scaleAnimation.value : 0;
              return ViewUtil.tabBarHighlight(scale: scale);
            },
          ),
          ViewUtil.tabBarHighlight(
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
              tapColor: Colors.transparent),
        ],
      ),
    );
  }
}
