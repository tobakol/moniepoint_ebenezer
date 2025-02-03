import 'package:flutter/material.dart';

class RisingTextAnimation extends StatefulWidget {
  const RisingTextAnimation(
      {super.key,
      this.containerHeight = 50,
      required this.child,
      required this.isVisible,
      this.onEnd,
      required this.duration});
  final bool isVisible;

  final Widget child;
  final double containerHeight;
  final Duration duration;
  final VoidCallback? onEnd;
  @override
  State<RisingTextAnimation> createState() => _RisingTextAnimationState();
}

class _RisingTextAnimationState extends State<RisingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen at the top
      end: Offset(0, 0.0), // Move off-screen at the bottom
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onEnd?.call();
      }
    });
    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant RisingTextAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Clipping area (defines where the text is visible)
            ClipRect(
              child: SizedBox(
                // width: 200, // Visible width
                height: widget.containerHeight, // Visible height
                child: SlideTransition(
                  position: _slideAnimation,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
